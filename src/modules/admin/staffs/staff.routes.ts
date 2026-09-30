import { Router } from 'express';
import { list, get, create, update, remove, toggleStatus } from './staff.controller.js';

export const staffAdminRoutes = Router();

staffAdminRoutes.get('/', list);
staffAdminRoutes.post('/', create);
staffAdminRoutes.get('/:id', get);
staffAdminRoutes.put('/:id', update);
staffAdminRoutes.delete('/:id', remove);
staffAdminRoutes.patch('/:id/toggle-status', toggleStatus);
