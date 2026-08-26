import type { Request, Response } from 'express';
import { sendError, sendSuccess } from '../../utils/response.js';
import { uploadToFTP } from '../../lib/ftp.js';
import crypto from 'crypto';
import path from 'path';
import * as ftp from 'basic-ftp';
import { env } from '../../config/env.js';

export async function uploadFile(req: Request, res: Response): Promise<void> {
  try {
    if (!req.file) {
      sendError(res, 'BAD_REQUEST', 'No file uploaded', 400);
      return;
    }

    const requestedFolder = (req.body.folder as string) || 'misc';
    const folder = `all-time-market/${requestedFolder}`;
    
    const ext = path.extname(req.file.originalname) || '.jpg';
    const filename = `${crypto.randomUUID()}${ext}`;

    const relativePath = await uploadToFTP(req.file.buffer, folder, filename);

    // Return the local server URL which will proxy to FTP
    const baseUrl = process.env.IMAGE_BASE_URL || 'http://localhost:4000/uploads';
    const finalUrl = `${baseUrl}/${relativePath}`;

    sendSuccess(res, { url: finalUrl });
  } catch (error) {
    console.error('FTP Upload Error:', error);
    sendError(res, 'INTERNAL_SERVER_ERROR', 'Failed to upload file to FTP', 500);
  }
}

export async function getFileFromFTP(req: Request, res: Response): Promise<void> {
  const filePath = req.params[0]; // Gets the wildcard path after /uploads/
  if (!filePath) {
    res.status(400).send('File path required');
    return;
  }

  const client = new ftp.Client();
  try {
    await client.access({
      host: env.FTP_HOST,
      user: env.FTP_USER,
      password: env.FTP_PASSWORD,
      secure: false
    });

    const ext = path.extname(filePath);
    if (ext) {
      res.type(ext);
    }
    
    // Pipe the FTP download stream directly to the HTTP response
    await client.downloadTo(res, filePath);
  } catch (error) {
    console.error(`FTP Proxy Error for ${filePath}:`, error);
    if (!res.headersSent) {
      res.status(404).send('File not found or error connecting to FTP');
    }
  } finally {
    client.close();
  }
}
