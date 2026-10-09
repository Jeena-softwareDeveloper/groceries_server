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
import { sendFast2SmsOtp } from '../../lib/sms.js';
import { AppError, ForbiddenError, UnauthorizedError, ValidationError } from '../../utils/errors.js';
import type { UserRole } from '../../types/index.js';
import { sendNotification } from '../notification/notification.service.js';

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
  return phone === TEST_PHONE;
}

function generateOtp(phone: string): string {
  if (isTestPhone(phone)) return TEST_OTP;
  if (isDev && !env.FAST2SMS_API_KEY) return TEST_OTP;
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

  const customer = await prisma.customer.findUnique({ where: { phone: normalized } });
  if (customer && customer.isBlocked) {
    throw new ForbiddenError('This account is suspended. Please contact support.');
  }

  if (deviceId && customer) {
    const trustedSession = await prisma.refreshToken.findFirst({
      where: { userId: customer.id, deviceId, expiresAt: { gt: new Date() } },
      orderBy: { createdAt: 'desc' }
    });

    if (trustedSession) {
      const tokens = await issueTokens({ sub: customer.id, role: 'CUSTOMER' }, deviceName, ipAddress, deviceId, deviceModel, osVersion);
      return { message: 'Trusted device login successful', autoLogin: true, tokens };
    }
  }

  await prisma.otpSession.deleteMany({ where: { phone: normalized } });

  const otp = generateOtp(normalized);
  await prisma.otpSession.create({
    data: {
      phone: normalized,
      otp,
      expiresAt: new Date(Date.now() + 10 * 60 * 1000),
    },
  });

  if (env.FAST2SMS_API_KEY && !isTestPhone(normalized)) {
    const smsResult = await sendFast2SmsOtp(normalized, otp);
    if (!smsResult.success) {
      console.error(`[Auth] Fast2SMS OTP send failed for ${normalized}:`, smsResult.message);
      if (!isDev) {
        throw new ValidationError(smsResult.message || 'Failed to send OTP SMS. Please try again.');
      }
    }
  } else if (!isDev) {
    console.warn('Fast2SMS credentials missing — OTP generated in DB but SMS not dispatched for', normalized);
  }

  console.log(`[Auth] OTP for ${normalized}: ${otp}`);

  return {
    message: 'OTP sent successfully',
    ...(isDev ? { otp } : {}),
  };
}

export async function verifyCustomerOtp(phone: string, otp: string, deviceName?: string, ipAddress?: string, deviceId?: string, deviceModel?: string, osVersion?: string, staffReferralCode?: string) {
  const normalized = assertValidPhone(phone);

  if (!/^\d{6}$/.test(otp)) {
    throw new ValidationError('Invalid OTP');
  }

  if (isTestPhone(normalized) && otp === TEST_OTP) {
    // Test account bypass
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

    // Resolve staff referral code to a staffId if provided
    let staffId: string | undefined;
    if (staffReferralCode) {
      const staff = await prisma.staff.findUnique({ where: { code: staffReferralCode.toUpperCase() } });
      if (staff) staffId = staff.id;
    }

    customer = await prisma.customer.create({
      data: {
        phone: normalized,
        wallet: { create: {} },
        ...(staffId ? { staffId, staffReferralCode: staffReferralCode!.toUpperCase() } : {}),
      },
    });

    // Log a CUSTOMER_ONBOARDED audit event for the referring staff
    if (staffId) {
      await prisma.staffAuditLog.create({
        data: { staffId, action: 'CUSTOMER_ONBOARDED', platform: 'App' }
      }).catch(() => {}); // non-critical
    }

    sendNotification({
      customerId: customer.id,
      type: 'WELCOME',
      title: '👋 Welcome to All Time Market!',
      body: 'Find fresh groceries and daily essentials from your favorite local shops with quick delivery!',
    }).catch(() => {});
  }

  if (customer.isBlocked) throw new ForbiddenError('This account is suspended. Please contact support.');

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
  // If called with a vendorId (user already has VENDOR token), resolve the actual customerId first
  const possibleVendor = await prisma.vendor.findUnique({
    where: { id: customerId },
    select: { customerId: true },
  });
  const resolvedCustomerId = possibleVendor?.customerId ?? customerId;

  const vendor = await prisma.vendor.findFirst({
    where: { customerId: resolvedCustomerId, status: 'APPROVED' },
  });
  if (!vendor) {
    // Check if there's an approved vendor request without a vendor record (partial failure)
    const approvedReq = await prisma.vendorRequest.findFirst({ where: { customerId: resolvedCustomerId, status: 'APPROVED' } });
    if (approvedReq) {
      throw new AppError('CONFLICT', 'Your application is approved but the vendor account setup is incomplete. Please contact support.', 409);
    }
    throw new ForbiddenError('Not an approved vendor');
  }
  
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

  if (payload.role === 'CUSTOMER') {
    const customer = await prisma.customer.findUnique({ where: { id: payload.sub } });
    if (!customer || customer.isBlocked) {
      throw new ForbiddenError('This account is suspended. Please contact support.');
    }
  }

  // Generate only a new access token to prevent Refresh Token Rotation race conditions
  const accessToken = signAccessToken({ sub: payload.sub, role: payload.role });
  return { accessToken, refreshToken, role: payload.role };
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
      return { id: admin.id, email: admin.email, name: admin.name, role: 'SUPER_ADMIN' as const, createdAt: admin.createdAt };
    }
    case 'VENDOR': {
      const vendor = await prisma.vendor.findUnique({ where: { id: userId } });
      if (!vendor) return null;
      return {
        id: vendor.id,
        email: vendor.email,
        name: vendor.shopName,
        shopName: vendor.shopName,
        phone: vendor.phone,
        status: vendor.status,
        role: 'VENDOR' as const,
        createdAt: vendor.createdAt,
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
        createdAt: customer.createdAt,
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
