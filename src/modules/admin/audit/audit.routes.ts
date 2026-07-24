import { Router, type Request, type Response, type NextFunction } from 'express';
import { sendSuccess } from '../../../utils/response.js';
import * as svc from '../../audit/audit.service.js';

export const auditAdminRoutes = Router();

auditAdminRoutes.get('/', async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { entityType, action, search, page, limit } = req.query;
    const r = await svc.listAuditLogs(
      Number(page) || 1,
      Number(limit) || 20,
      entityType as string | undefined,
      action as string | undefined,
      search as string | undefined
    );
    sendSuccess(res, r.items, 200, { page: r.page, limit: r.limit, total: r.total });
  } catch (e) {
    next(e);
  }
});
