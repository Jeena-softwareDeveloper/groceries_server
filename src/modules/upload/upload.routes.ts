import { Router } from 'express';
import { authenticate } from '../auth/auth.service.js';
import { getUploadSignature } from './upload.controller.js';

export const uploadRoutes = Router();

uploadRoutes.get('/signature', authenticate, getUploadSignature);
