import type { Request, Response } from 'express';
import { sendError, sendSuccess } from '../../utils/response.js';
import { uploadToFTP } from '../../lib/ftp.js';
import crypto from 'crypto';
import path from 'path';

export async function uploadFile(req: Request, res: Response): Promise<void> {
  try {
    if (!req.file) {
      sendError(res, 'BAD_REQUEST', 'No file uploaded', 400);
      return;
    }

    // Determine the folder, default to 'all-time-market/misc'
    const requestedFolder = (req.body.folder as string) || 'misc';
    const folder = `all-time-market/${requestedFolder}`;
    
    // Generate a unique filename using crypto and preserve original extension
    const ext = path.extname(req.file.originalname) || '.jpg';
    const filename = `${crypto.randomUUID()}${ext}`;

    // Upload to FTP
    const relativePath = await uploadToFTP(req.file.buffer, folder, filename);

    // Assume EXPO_PUBLIC_IMAGE_BASE_URL (or a default) maps to the root of the FTP server
    const baseUrl = process.env.IMAGE_BASE_URL || 'https://api.jeenora.com/uploads';
    const finalUrl = `${baseUrl}/${relativePath}`;

    sendSuccess(res, { url: finalUrl });
  } catch (error) {
    sendError(res, 'INTERNAL_SERVER_ERROR', 'Failed to upload file to FTP', 500);
  }
}

