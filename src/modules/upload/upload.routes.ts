import { Router } from 'express';
import { authenticate } from '../auth/auth.service.js';
import { uploadFile } from './upload.controller.js';
import multer from 'multer';

const upload = multer({ 
  storage: multer.memoryStorage(),
  limits: { fileSize: 5 * 1024 * 1024 } // 5MB limit
});

export const uploadRoutes = Router();

uploadRoutes.post('/', authenticate, upload.single('file'), uploadFile);
