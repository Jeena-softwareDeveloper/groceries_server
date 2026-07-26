import { z } from 'zod';
import sanitizeHtml from 'sanitize-html';

const sanitize = (val: string) => sanitizeHtml(val, { allowedTags: [], allowedAttributes: {} });

export const rejectProductApprovalSchema = z.object({
  reason: z.string().min(3, 'Rejection reason must be at least 3 characters long').transform(sanitize),
});

export const requestChangesSchema = z.object({
  notes: z.string().min(3, 'Change request notes must be at least 3 characters long').transform(sanitize),
});

export const adminUpdateProductSchema = z.object({
  categoryId: z.string().optional(),
  subCategoryId: z.string().optional().nullable(),
  name: z.string().min(2, 'Name is required').transform(sanitize).optional(),
  description: z.string().transform(sanitize).optional().nullable(),
  brand: z.string().optional().nullable(),
  barcode: z.string().optional().nullable(),
  mrp: z.number().min(0).optional(),
  sellingPrice: z.number().min(0).optional(),
  unit: z.string().min(1, 'Unit is required').optional(),
  weight: z.string().optional().nullable(),
  weightGrams: z.number().min(0).optional().nullable(),
  hsnCode: z.string().optional().nullable(),
  tags: z.string().optional().nullable(),
  stock: z.number().int().min(0).optional(),
  images: z.array(z.string().url('Invalid image URL')).optional(),
});
