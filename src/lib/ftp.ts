import * as ftp from 'basic-ftp';
import { env } from '../config/env.js';
import { logger } from './logger.js';
import stream from 'stream';

/**
 * Uploads a file buffer to the FTP server.
 * @param fileBuffer The file content as a Buffer.
 * @param folder The target folder under the root.
 * @param filename The name of the file to save.
 * @returns The relative path of the uploaded file on the FTP server.
 */
export async function uploadToFTP(fileBuffer: Buffer, folder: string, filename: string): Promise<string> {
  const client = new ftp.Client();
  client.ftp.verbose = false;

  try {
    if (!env.FTP_HOST || !env.FTP_USER || !env.FTP_PASSWORD) {
      throw new Error('FTP credentials are not fully configured in environment variables.');
    }

    await client.access({
      host: env.FTP_HOST,
      user: env.FTP_USER,
      password: env.FTP_PASSWORD,
      secure: false, // Set to true if FTPS is required
    });

    // Ensure folder structure exists
    await client.ensureDir(folder);

    // Create a readable stream from the buffer
    const sourceStream = new stream.PassThrough();
    sourceStream.end(fileBuffer);

    // Upload the file
    await client.uploadFrom(sourceStream, filename);
    
    // Return to root directory just in case
    await client.cd('/');

    return `${folder}/${filename}`;
  } catch (error) {
    logger.error({ err: error }, `Failed to upload file to FTP: ${folder}/${filename}`);
    throw error;
  } finally {
    client.close();
  }
}
