import type { Request, Response, NextFunction } from 'express';
import { z } from 'zod';
import { paramId } from '../../../utils/params.js';
import * as service from './staff.service.js';
import { sendSuccess } from '../../../utils/response.js';

const createStaffSchema = z.object({
  name: z.string().min(2, 'Name is required'),
  phone: z.string().min(10, 'Valid 10-digit phone number is required'),
  email: z.string().email('Invalid email').optional().or(z.literal('')),
  designation: z.string().optional(),
  code: z.string().optional(),
  districtId: z.string().optional(),
  areaId: z.string().optional(),
});

export async function list(req: Request, res: Response, next: NextFunction) {
  try {
    const search = req.query.search as string | undefined;
    const page = Number(req.query.page) || 1;
    const limit = Number(req.query.limit) || 100;
    const isActive = req.query.isActive !== undefined ? req.query.isActive === 'true' : undefined;
    const result = await service.listStaffs(search, isActive, page, limit);
    sendSuccess(res, result.items, 200, { page: result.page, limit: result.limit, total: result.total });
  } catch (e) {
    next(e);
  }
}

export async function get(req: Request, res: Response, next: NextFunction) {
  try {
    sendSuccess(res, await service.getStaff(paramId(req)));
  } catch (e) {
    next(e);
  }
}

export async function create(req: Request, res: Response, next: NextFunction) {
  try {
    const data = createStaffSchema.parse(req.body);
    const result = await service.createStaff(data);
    sendSuccess(res, result, 201);
  } catch (e) {
    next(e);
  }
}

export async function update(req: Request, res: Response, next: NextFunction) {
  try {
    sendSuccess(res, await service.updateStaff(paramId(req), req.body));
  } catch (e) {
    next(e);
  }
}

export async function remove(req: Request, res: Response, next: NextFunction) {
  try {
    sendSuccess(res, await service.deleteStaff(paramId(req)));
  } catch (e) {
    next(e);
  }
}

export async function toggleStatus(req: Request, res: Response, next: NextFunction) {
  try {
    const staff = await service.getStaff(paramId(req));
    sendSuccess(res, await service.updateStaff(staff.id, { isActive: !staff.isActive }));
  } catch (e) {
    next(e);
  }
}
