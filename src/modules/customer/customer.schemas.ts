import { z } from 'zod';

export const addToCartSchema = z.object({
  productId: z.string().min(1, 'Product is required'),
  quantity: z.coerce.number().int().min(1).max(99).optional().default(1),
});

export const updateCartSchema = z.object({
  quantity: z.coerce.number().int().min(0).max(99),
});

export const checkoutSchema = z.object({
  addressId: z.string().min(1, 'Address is required'),
  paymentMethod: z.enum(['COD']).default('COD'),
  couponCode: z.string().min(1).max(50).optional(),
});

export const addressSchema = z.object({
  label: z.string().min(1).max(50).default('Home'),
  line1: z.string().min(3, 'Address is too short').max(200),
  line2: z.string().max(200).optional().nullable(),
  city: z.string().min(2, 'City is required').max(100),
  state: z.string().min(2, 'State is required').max(100),
  pincode: z.string().regex(/^\d{6}$/, 'Pincode must be 6 digits'),
  lat: z.number().optional().nullable(),
  lng: z.number().optional().nullable(),
  isDefault: z.boolean().optional(),
});

export const profileSchema = z.object({
  name: z.string().min(1).max(100).optional(),
  email: z.union([z.string().email(), z.literal('')]).optional(),
});

export const supportTicketSchema = z.object({
  subject: z.string().min(3, 'Subject is too short').max(200),
  message: z.string().min(10, 'Message is too short').max(2000),
  orderId: z.string().optional(),
});

export const reviewSchema = z.object({
  orderId: z.string().min(1),
  rating: z.coerce.number().int().min(1).max(5),
  comment: z.string().max(1000).optional(),
  productId: z.string().optional(),
});

export const wishlistSchema = z.object({
  productId: z.string().min(1),
});

export const couponSchema = z.object({
  code: z.string().min(1).max(50),
});

export type AddressInput = z.infer<typeof addressSchema>;
export type ProfileInput = z.infer<typeof profileSchema>;
