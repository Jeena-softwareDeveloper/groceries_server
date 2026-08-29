import { Router } from 'express';
import * as ctrl from './vendor.controller.js';

export const vendorAdminRoutes = Router();

vendorAdminRoutes.post('/', ctrl.create);
vendorAdminRoutes.get('/', ctrl.list);
vendorAdminRoutes.get('/:id', ctrl.get);
vendorAdminRoutes.put('/:id', ctrl.update);
vendorAdminRoutes.post('/:id/approve', ctrl.approve);
vendorAdminRoutes.post('/:id/reject', ctrl.reject);
vendorAdminRoutes.post('/:id/suspend', ctrl.suspend);
vendorAdminRoutes.delete('/:id', ctrl.remove);
