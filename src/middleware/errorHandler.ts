import type { NextFunction, Request, Response } from 'express';
import { ZodError } from 'zod';
import { Prisma } from '@prisma/client';
import { logger } from '../lib/logger.js';
import { AppError } from '../utils/errors.js';
import { sendError } from '../utils/response.js';

export function errorHandler(
  err: Error,
  _req: Request,
  res: Response,
  _next: NextFunction,
): void {
  if (err instanceof AppError) {
    sendError(res, err.code, err.message, err.statusCode, err.details);
    return;
  }

  if (err instanceof ZodError) {
    sendError(res, 'VALIDATION_ERROR', 'Validation failed', 422, {
      fields: err.flatten().fieldErrors,
    });
    return;
  }

  if (err instanceof Prisma.PrismaClientKnownRequestError) {
    if (err.code === 'P2002') {
      const target = Array.isArray(err.meta?.target) ? err.meta.target.join(', ') : (err.meta?.target as string) || 'field';
      sendError(res, 'CONFLICT', `A record with this ${target} already exists.`, 409);
      return;
    }
    if (err.code === 'P2003') {
      const field = (err.meta?.field_name as string) || 'reference';
      sendError(res, 'BAD_REQUEST', `Invalid reference: ${field} not found.`, 400);
      return;
    }
    if (err.code === 'P2025') {
      sendError(res, 'NOT_FOUND', 'Requested record not found.', 404);
      return;
    }
  }

  logger.error({ err }, 'Unhandled error');
  sendError(res, 'INTERNAL_ERROR', 'Internal server error', 500);
}
