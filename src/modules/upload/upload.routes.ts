import { Router } from 'express';
import { authenticate } from '../auth/auth.service.js';
import { uploadFile } from './upload.controller.js';
import multer from 'multer';

// Use memory storage so we can buffer the file and send to FTP directly
const upload = multer({ storage: multer.memoryStorage() });

export const uploadRoutes = Router();

uploadRoutes.post('/', authenticate, upload.single('file'), uploadFile);

