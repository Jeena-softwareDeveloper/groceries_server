import bcrypt from 'bcryptjs';
import { randomInt } from 'crypto';
import type { NextFunction, Request, Response } from 'express';
import { env } from '../../config/env.js';
import { prisma } from '../../lib/prisma.js';
import { getRedis } from '../../lib/redis.js';
import {
  parseExpiresIn,
  signAccessToken,
  signRefreshToken,
  verifyAccessToken,
  verifyRefreshToken,
  type JwtPayload,
} from '../../lib/jwt.js';
import twilio from 'twilio';
import { ForbiddenError, UnauthorizedError, ValidationError } from '../../utils/errors.js';
import type { UserRole } from '../../types/index.js';

const SALT_ROUNDS = 12;

export async function hashPassword(password: string): Promise<string> {
  return bcrypt.hash(password, SALT_ROUNDS);
}

export async function comparePassword(password: string, hash: string): Promise<boolean> {
  return bcrypt.compare(password, hash);
}

const INDIAN_MOBILE = /^[6-9]\d{9}$/;

const TEST_PHONE = '9999999999';
const TEST_OTP = '123456';
const isDev = env.NODE_ENV === 'development';

function normalizePhone(phone: string): string {
  return phone.replace(/\D/g, '').slice(-10);
}

function assertValidPhone(phone: string): string {
  const normalized = normalizePhone(phone);
  if (!INDIAN_MOBILE.test(normalized)) {
    throw new ValidationError('Enter a valid 10-digit Indian mobile number');
  }
  return normalized;
}

function isTestPhone(phone: string): boolean {
  return isDev && phone === TEST_PHONE;
}

function generateOtp(phone: string): string {
  if (isDev) return TEST_OTP;
  return String(randomInt(100000, 999999));
}

export async function requestCustomerOtp(
  phone: string,
  deviceName?: string,
  ipAddress?: string,
  deviceId?: string,
  deviceModel?: string,
  osVersion?: string
): Promise<{ message: string; otp?: string; autoLogin?: boolean; tokens?: any }> {
  const normalized = assertValidPhone(phone);

  if (deviceId) {
    const customer = await prisma.customer.findUnique({ where: { phone: normalized } });
    if (customer) {
      if (customer.isBlocked) throw new ForbiddenError('Account is blocked');
      
      const trustedSession = await prisma.refreshToken.findFirst({
        where: { userId: customer.id, deviceId, expiresAt: { gt: new Date() } },
        orderBy: { createdAt: 'desc' }
      });

      if (trustedSession) {
        const tokens = await issueTokens({ sub: customer.id, role: 'CUSTOMER' }, deviceName, ipAddress, deviceId, deviceModel, osVersion);
        return { message: 'Trusted device login successful', autoLogin: true, tokens };
      }
    }
  }

  await prisma.otpSession.deleteMany({ where: { phone: normalized } });

  const shouldSendSms =
    !!(env.TWILIO_ACCOUNT_SID && env.TWILIO_AUTH_TOKEN && env.TWILIO_VERIFY_SERVICE_SID);

  if (shouldSendSms) {
    try {
      const client = twilio(env.TWILIO_ACCOUNT_SID!, env.TWILIO_AUTH_TOKEN!);
      await client.verify.v2.services(env.TWILIO_VERIFY_SERVICE_SID!).verifications.create({
        to: `+91${normalized}`,
        channel: 'sms'
      });
    } catch (e) {
      console.error('Twilio Verify error', e);
      throw new ValidationError('Failed to send OTP. Please try again.');
    }
    
    return { message: 'OTP sent successfully' };
  } else {
    if (!isDev) {
      console.warn('Twilio Verify credentials missing — OTP generated but not sent for', normalized);
    }
    
    const otp = generateOtp(normalized);
    await prisma.otpSession.create({
      data: {
        phone: normalized,
        otp,
        expiresAt: new Date(Date.now() + 10 * 60 * 1000),
      },
    });

    return {
      message: 'OTP sent successfully',
      ...(isDev ? { otp } : {}),
    };
  }
}

export async function verifyCustomerOtp(phone: string, otp: string, deviceName?: string, ipAddress?: string, deviceId?: string, deviceModel?: string, osVersion?: string) {
  const normalized = assertValidPhone(phone);

  if (!/^\d{6}$/.test(otp)) {
    throw new ValidationError('Invalid OTP');
  }

  const shouldVerifySms =
    !!(env.TWILIO_ACCOUNT_SID && env.TWILIO_AUTH_TOKEN && env.TWILIO_VERIFY_SERVICE_SID);

  if (shouldVerifySms) {
    try {
      const client = twilio(env.TWILIO_ACCOUNT_SID!, env.TWILIO_AUTH_TOKEN!);
      const verification = await client.verify.v2.services(env.TWILIO_VERIFY_SERVICE_SID!).verificationChecks.create({
        to: `+91${normalized}`,
        code: otp
      });
      if (verification.status !== 'approved') {
        throw new ValidationError('Invalid OTP');
      }
    } catch (e) {
      console.error('Twilio Verify check error', e);
      throw new ValidationError('Invalid OTP');
    }
  } else {
    const session = await prisma.otpSession.findFirst({
      where: { phone: normalized },
      orderBy: { createdAt: 'desc' },
    });

    if (!session) throw new ValidationError('OTP expired or not found');
    if (session.expiresAt < new Date()) throw new ValidationError('OTP expired');
    if (session.attempts >= 5) throw new ValidationError('Too many attempts');
    if (session.otp !== otp) {
      await prisma.otpSession.update({
        where: { id: session.id },
        data: { attempts: { increment: 1 } },
      });
      throw new ValidationError('Invalid OTP');
    }

    await prisma.otpSession.delete({ where: { id: session.id } });
  }

  let customer = await prisma.customer.findUnique({ where: { phone: normalized } });
  let isNewUser = false;
  if (!customer) {
    isNewUser = true;
    customer = await prisma.customer.create({
      data: {
        phone: normalized,
        wallet: { create: {} },
      },
    });
  }

  if (customer.isBlocked) throw new ForbiddenError('Account is blocked');

  const approvedVendor = await prisma.vendor.findFirst({
    where: { customerId: customer.id, status: 'APPROVED' }
  });

  if (approvedVendor) {
    const tokens = await issueTokens({ sub: approvedVendor.id, role: 'VENDOR' }, deviceName, ipAddress, deviceId, deviceModel, osVersion);
    return { ...tokens, isNewUser: false };
  }

  const tokens = await issueTokens({ sub: customer.id, role: 'CUSTOMER' }, deviceName, ipAddress, deviceId, deviceModel, osVersion);
  return { ...tokens, isNewUser };
}

export async function loginVendor(email: string, password: string, deviceName?: string, ipAddress?: string, deviceId?: string, deviceModel?: string, osVersion?: string) {
  const vendor = await prisma.vendor.findUnique({ where: { email } });
  if (!vendor || !(await comparePassword(password, vendor.passwordHash))) {
    throw new UnauthorizedError('Invalid credentials');
  }
  if (vendor.status === 'PENDING') throw new ForbiddenError('Vendor account pending approval');
  if (vendor.status === 'REJECTED') throw new ForbiddenError('Vendor application was rejected');
  if (vendor.status === 'SUSPENDED') throw new ForbiddenError('Vendor account is suspended');

  return issueTokens({ sub: vendor.id, role: 'VENDOR' }, deviceName, ipAddress, deviceId, deviceModel, osVersion);
}

export async function switchToVendor(customerId: string, deviceName?: string, ipAddress?: string, deviceId?: string, deviceModel?: string, osVersion?: string) {
  const vendor = await prisma.vendor.findFirst({
    where: { customerId, status: 'APPROVED' },
  });
  if (!vendor) throw new ForbiddenError('Not an approved vendor');
  
  return issueTokens({ sub: vendor.id, role: 'VENDOR' }, deviceName, ipAddress, deviceId, deviceModel, osVersion);
}

export async function switchToCustomer(vendorId: string, deviceName?: string, ipAddress?: string, deviceId?: string, deviceModel?: string, osVersion?: string) {
  const vendor = await prisma.vendor.findUnique({
    where: { id: vendorId },
    select: { customerId: true }
  });
  if (!vendor || !vendor.customerId) throw new ForbiddenError('No linked customer account found');
  
  return issueTokens({ sub: vendor.customerId, role: 'CUSTOMER' }, deviceName, ipAddress, deviceId, deviceModel, osVersion);
}

export async function loginAdmin(email: string, password: string, deviceName?: string, ipAddress?: string, deviceId?: string, deviceModel?: string, osVersion?: string) {
  const admin = await prisma.superAdmin.findUnique({ where: { email } });
  if (!admin || !admin.isActive || !(await comparePassword(password, admin.passwordHash))) {
    throw new UnauthorizedError('Invalid credentials');
  }
  return issueTokens({ sub: admin.id, role: 'SUPER_ADMIN' }, deviceName, ipAddress, deviceId, deviceModel, osVersion);
}

async function issueTokens(payload: JwtPayload, deviceName?: string, ipAddress?: string, deviceId?: string, deviceModel?: string, osVersion?: string) {
  const accessToken = signAccessToken(payload);
  const refreshToken = signRefreshToken(payload);

  await prisma.refreshToken.create({
    data: {
      token: refreshToken,
      userId: payload.sub,
      userRole: payload.role,
      deviceName: deviceName,
      deviceId: deviceId,
      deviceModel: deviceModel,
      osVersion: osVersion,
      ipAddress: ipAddress,
      expiresAt: new Date(Date.now() + parseExpiresIn(env.JWT_REFRESH_EXPIRES_IN) * 1000),
    },
  });

  return { accessToken, refreshToken, role: payload.role };
}

export async function getActiveSessions(userId: string) {
  return prisma.refreshToken.findMany({
    where: { userId },
    select: { id: true, deviceName: true, deviceModel: true, osVersion: true, ipAddress: true, createdAt: true },
    orderBy: { createdAt: 'desc' }
  });
}

export async function revokeSession(sessionId: string, userId: string) {
  const session = await prisma.refreshToken.findFirst({
    where: { id: sessionId, userId }
  });
  if (!session) throw new ValidationError('Session not found');

  const redis = getRedis();
  if (redis) {
    const ttl = Math.floor((session.expiresAt.getTime() - Date.now()) / 1000);
    if (ttl > 0) {
      await redis.setex(`blacklist:${session.token}`, ttl, 'true');
    }
  }

  await prisma.refreshToken.delete({ where: { id: sessionId } });
  return { success: true };
}

export async function refreshTokens(refreshToken: string) {
  let payload: JwtPayload;
  try {
    payload = verifyRefreshToken(refreshToken);
  } catch {
    throw new UnauthorizedError('Invalid refresh token');
  }

  const stored = await prisma.refreshToken.findUnique({ where: { token: refreshToken } });
  if (!stored || stored.expiresAt < new Date()) {
    throw new UnauthorizedError('Refresh token expired');
  }

  const redis = getRedis();
  if (redis && (await redis.get(`blacklist:${refreshToken}`))) {
    throw new UnauthorizedError('Token revoked');
  }

  await prisma.refreshToken.delete({ where: { token: refreshToken } });
  return issueTokens(payload, stored.deviceName || undefined, stored.ipAddress || undefined, stored.deviceId || undefined, stored.deviceModel || undefined, stored.osVersion || undefined);
}

export async function logout(refreshToken: string) {
  const redis = getRedis();
  const ttl = parseExpiresIn(env.JWT_REFRESH_EXPIRES_IN);

  await prisma.refreshToken.deleteMany({ where: { token: refreshToken } });

  if (redis) {
    await redis.setex(`blacklist:${refreshToken}`, ttl, '1');
  }
}

export async function getMe(userId: string, role: UserRole) {
  switch (role) {
    case 'SUPER_ADMIN': {
      const admin = await prisma.superAdmin.findUnique({ where: { id: userId } });
      if (!admin) return null;
      return { id: admin.id, email: admin.email, name: admin.name, role: 'SUPER_ADMIN' as const };
    }
    case 'VENDOR': {
      const vendor = await prisma.vendor.findUnique({ where: { id: userId } });
      if (!vendor) return null;
      return {
        id: vendor.id,
        email: vendor.email,
        shopName: vendor.shopName,
        status: vendor.status,
        role: 'VENDOR' as const,
      };
    }
    case 'CUSTOMER': {
      const customer = await prisma.customer.findUnique({ where: { id: userId } });
      if (!customer) return null;
      return {
        id: customer.id,
        phone: customer.phone,
        email: customer.email,
        name: customer.name,
        role: 'CUSTOMER' as const,
      };
    }
    default:
      return null;
  }
}

declare global {
  namespace Express {
    interface Request {
      user?: JwtPayload;
    }
  }
}

export function authenticate(req: Request, _res: Response, next: NextFunction): void {
  const header = req.headers.authorization;
  if (!header?.startsWith('Bearer ')) {
    next(new UnauthorizedError());
    return;
  }

  try {
    req.user = verifyAccessToken(header.slice(7));
    next();
  } catch {
    next(new UnauthorizedError('Invalid or expired token'));
  }
}

export function optionalAuthenticate(req: Request, _res: Response, next: NextFunction): void {
  const header = req.headers.authorization;
  if (!header?.startsWith('Bearer ')) {
    next();
    return;
  }
  try {
    req.user = verifyAccessToken(header.slice(7));
  } catch {}
  next();
}

export function authorize(...roles: UserRole[]) {
  return (req: Request, _res: Response, next: NextFunction): void => {
    if (!req.user) {
      next(new UnauthorizedError());
      return;
    }
    if (!roles.includes(req.user.role)) {
      next(new ForbiddenError('Insufficient permissions'));
      return;
    }
    next();
  };
}
