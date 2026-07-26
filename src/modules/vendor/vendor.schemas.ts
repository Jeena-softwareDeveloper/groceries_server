import { z } from 'zod';
import sanitizeHtml from 'sanitize-html';

const sanitize = (val: string) => sanitizeHtml(val, { allowedTags: [], allowedAttributes: {} });

export const vendorProfileSchema = z.object({
  shopName: z.string().min(2, 'Shop name is too short').transform(sanitize).optional(),
  description: z.string().transform(sanitize).optional().nullable(),
  logoUrl: z.string().url('Invalid URL').optional().nullable(),
  bannerUrl: z.string().url('Invalid URL').optional().nullable(),
  address: z.string().min(5, 'Address is too short').optional(),
  phone: z.string().min(10, 'Invalid phone number').optional(),
  minOrderValue: z.number().min(0).optional(),
  deliveryRadius: z.number().min(0).optional(),
  isOpen: z.boolean().optional(),
  operatingHours: z.record(z.any()).optional().nullable(),
});

export const productSchema = z.object({
  categoryId: z.string().min(1, 'Category ID is required'),
  subCategoryId: z.string().optional().nullable(),
  name: z.string().min(2, 'Name is required').transform(sanitize),
  description: z.string().transform(sanitize).optional().nullable(),
  brand: z.string().optional().nullable(),
  barcode: z.string().optional().nullable(),
  mrp: z.number().min(0),
  sellingPrice: z.number().min(0),
  unit: z.string().min(1, 'Unit is required'),
  weight: z.string().optional().nullable(),
  weightGrams: z.number().min(0).optional().nullable(),
  hsnCode: z.string().optional().nullable(),
  tags: z.string().optional().nullable(),
  stock: z.number().int().min(0).optional(),
  images: z.array(z.string().url('Invalid image URL')).optional(),
});

export const offerSchema = z.object({
  title: z.string().min(2, 'Title is required').transform(sanitize),
  description: z.string().transform(sanitize).optional().nullable(),
  imageUrl: z.string().url('Invalid image URL').optional().nullable(),
  categoryId: z.string().optional().nullable(),
  discountPct: z.number().min(0).max(100).optional().nullable(),
  discountAmt: z.number().min(0).optional().nullable(),
  minOrder: z.number().min(0).optional().nullable(),
  startsAt: z.string().datetime().optional().nullable(),
  endsAt: z.string().datetime().optional().nullable(),
});

export type VendorProfileUpdate = z.infer<typeof vendorProfileSchema>;
export type ProductInput = z.infer<typeof productSchema>;
export type OfferInput = z.infer<typeof offerSchema>;
