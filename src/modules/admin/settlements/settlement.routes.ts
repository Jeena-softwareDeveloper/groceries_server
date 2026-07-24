import { Router, type Request, type Response, type NextFunction } from 'express';
import { sendSuccess } from '../../../utils/response.js';
import { paramId } from '../../../utils/params.js';
import * as svc from '../../settlement/settlement.service.js';

export const settlementAdminRoutes = Router();

settlementAdminRoutes.get('/', async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { vendorId, status, page, limit } = req.query;
    const r = await svc.listSettlements(
      vendorId as string | undefined,
      status as string | undefined,
      Number(page) || 1,
      Number(limit) || 20
    );
    sendSuccess(res, r.items, 200, { page: r.page, limit: r.limit, total: r.total });
  } catch (e) {
    next(e);
  }
});

settlementAdminRoutes.post('/generate', async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { vendorId, startDate, endDate } = req.body;
    const settlement = await svc.generateVendorSettlement(
      vendorId,
      startDate ? new Date(startDate) : undefined,
      endDate ? new Date(endDate) : undefined
    );
    sendSuccess(res, settlement, 201);
  } catch (e) {
    next(e);
  }
});

settlementAdminRoutes.post('/:id/approve', async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { bankReference } = req.body;
    const result = await svc.approveSettlement(paramId(req), req.user!.sub, bankReference);
    sendSuccess(res, result);
  } catch (e) {
    next(e);
  }
});

settlementAdminRoutes.post('/:id/reject', async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { reason } = req.body;
    const result = await svc.rejectSettlement(paramId(req), req.user!.sub, reason || 'Rejected by Admin');
    sendSuccess(res, result);
  } catch (e) {
    next(e);
  }
});
