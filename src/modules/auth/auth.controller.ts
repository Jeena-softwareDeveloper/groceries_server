import type { Request, Response, NextFunction } from 'express';
import { z } from 'zod';
import * as authService from './auth.service.js';
import { sendSuccess } from '../../utils/response.js';

const indianPhone = z
  .string()
  .transform((v) => v.replace(/\D/g, '').slice(-10))
  .refine((v) => /^[6-9]\d{9}$/.test(v), 'Enter a valid 10-digit Indian mobile number');

const otpRequestSchema = z.object({ phone: indianPhone });
const otpVerifySchema = z.object({
  phone: indianPhone,
  otp: z.string().regex(/^\d{6}$/, 'OTP must be 6 digits'),
  deviceId: z.string().optional(),
  deviceModel: z.string().optional(),
  osVersion: z.string().optional(),
});
const loginSchema = z.object({ email: z.string().email(), password: z.string().min(6), deviceId: z.string().optional(), deviceModel: z.string().optional(), osVersion: z.string().optional() });
const refreshSchema = z.object({ refreshToken: z.string().min(1) });
const switchSchema = z.object({ deviceId: z.string().optional(), deviceModel: z.string().optional(), osVersion: z.string().optional() });

export async function customerOtpRequest(req: Request, res: Response, next: NextFunction) {
  try {
    const { phone } = otpRequestSchema.parse(req.body);
    const result = await authService.requestCustomerOtp(phone);
    sendSuccess(res, result);
  } catch (err) {
    next(err);
  }
}

export async function customerOtpVerify(req: Request, res: Response, next: NextFunction) {
  try {
    const { phone, otp, deviceId, deviceModel, osVersion } = otpVerifySchema.parse(req.body);
    const deviceName = req.headers['user-agent'];
    const tokens = await authService.verifyCustomerOtp(phone, otp, deviceName, req.ip, deviceId, deviceModel, osVersion);
    sendSuccess(res, tokens);
  } catch (err) {
    next(err);
  }
}

export async function vendorLogin(req: Request, res: Response, next: NextFunction) {
  try {
    const { email, password, deviceId, deviceModel, osVersion } = loginSchema.parse(req.body);
    const deviceName = req.headers['user-agent'];
    const tokens = await authService.loginVendor(email, password, deviceName, req.ip, deviceId, deviceModel, osVersion);
    sendSuccess(res, tokens);
  } catch (err) {
    next(err);
  }
}

export async function adminLogin(req: Request, res: Response, next: NextFunction) {
  try {
    const { email, password, deviceId, deviceModel, osVersion } = loginSchema.parse(req.body);
    const deviceName = req.headers['user-agent'];
    const tokens = await authService.loginAdmin(email, password, deviceName, req.ip, deviceId, deviceModel, osVersion);
    sendSuccess(res, tokens);
  } catch (err) {
    next(err);
  }
}

export async function refresh(req: Request, res: Response, next: NextFunction) {
  try {
    const token = req.cookies?.refreshToken ?? refreshSchema.parse(req.body).refreshToken;
    const tokens = await authService.refreshTokens(token);
    sendSuccess(res, tokens);
  } catch (err) {
    next(err);
  }
}

export async function logout(req: Request, res: Response, next: NextFunction) {
  try {
    const token = req.cookies?.refreshToken ?? refreshSchema.parse(req.body).refreshToken;
    await authService.logout(token);
    res.clearCookie('refreshToken');
    sendSuccess(res, { message: 'Logged out' });
  } catch (err) {
    next(err);
  }
}

export async function me(req: Request, res: Response, next: NextFunction) {
  try {
    const user = await authService.getMe(req.user!.sub, req.user!.role);
    sendSuccess(res, user);
  } catch (err) {
    next(err);
  }
}

export async function switchToVendor(req: Request, res: Response, next: NextFunction) {
  try {
    const { deviceId, deviceModel, osVersion } = switchSchema.parse(req.body || {});
    const deviceName = req.headers['user-agent'];
    const tokens = await authService.switchToVendor(req.user!.sub, deviceName, req.ip, deviceId, deviceModel, osVersion);
    sendSuccess(res, tokens);
  } catch (err) {
    next(err);
  }
}

export async function switchToCustomer(req: Request, res: Response, next: NextFunction) {
  try {
    const { deviceId, deviceModel, osVersion } = switchSchema.parse(req.body || {});
    const deviceName = req.headers['user-agent'];
    const tokens = await authService.switchToCustomer(req.user!.sub, deviceName, req.ip, deviceId, deviceModel, osVersion);
    sendSuccess(res, tokens);
  } catch (err) {
    next(err);
  }
}

export async function getSessions(req: Request, res: Response, next: NextFunction) {
  try {
    const sessions = await authService.getActiveSessions(req.user!.sub);
    sendSuccess(res, sessions);
  } catch (err) {
    next(err);
  }
}

export async function deleteSession(req: Request, res: Response, next: NextFunction) {
  try {
    const result = await authService.revokeSession(req.params.id as string, req.user!.sub);
    sendSuccess(res, result);
  } catch (err) {
    next(err);
  }
}
