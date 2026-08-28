import { Router } from 'express';
import { authenticate, authorize, optionalAuthenticate } from '../auth/auth.service.js';
import { sendSuccess } from '../../utils/response.js';
import { paramId } from '../../utils/params.js';
import * as svc from './customer.service.js';
import { vendorRequestCustomerRoutes } from '../vendor-request/vendor-request.customer.routes.js';
import {
  addToCartSchema,
  addressSchema,
  checkoutSchema,
  couponSchema,
  profileSchema,
  reviewSchema,
  supportTicketSchema,
  updateCartSchema,
  wishlistSchema,
} from './customer.schemas.js';


export const customerRoutes = Router();

// Public routes with optional auth to get req.user
customerRoutes.use(optionalAuthenticate);
customerRoutes.post('/location', async (req, res, next) => {
  try {
    const { deviceId, displayName, latitude, longitude, districtId, areaId } = req.body;
    if (!deviceId || !displayName || latitude === undefined || longitude === undefined) {
      res.status(400).json({ success: false, error: { code: 'BAD_REQUEST', message: 'deviceId, displayName, latitude and longitude are required' }, data: null });
      return;
    }
    const customerId = req.user?.role === 'CUSTOMER' ? req.user.sub : undefined;
    const result = await svc.saveDeviceLocation({
      deviceId,
      displayName,
      latitude: parseFloat(latitude),
      longitude: parseFloat(longitude),
      districtId,
      areaId,
      customerId,
    });
    sendSuccess(res, result);
  } catch (e) { next(e); }
});
customerRoutes.get('/reverse-geocode', async (req, res, next) => {
  try {
    const lat = req.query.lat ? parseFloat(req.query.lat as string) : undefined;
    const lng = req.query.lng ? parseFloat(req.query.lng as string) : undefined;
    if (lat === undefined || lng === undefined || isNaN(lat) || isNaN(lng)) {
      res.status(400).json({ success: false, error: { code: 'BAD_REQUEST', message: 'lat and lng are required' }, data: null });
      return;
    }
    sendSuccess(res, await svc.reverseGeocodeLocation(lat, lng));
  } catch (e) { next(e); }
});
customerRoutes.get('/home/feed/bylocation', async (req, res, next) => {
  try {
    const lat = req.query.lat ? parseFloat(req.query.lat as string) : undefined;
    const lng = req.query.lng ? parseFloat(req.query.lng as string) : undefined;
    if (!Number.isFinite(lat) || !Number.isFinite(lng)) {
      res.status(400).json({ success: false, error: { code: 'BAD_REQUEST', message: 'lat and lng are required' }, data: null });
      return;
    }
    sendSuccess(res, await svc.getHomeFeedByLocation(lat as number, lng as number));
  } catch (e) { next(e); }
});
customerRoutes.get('/home/feed', async (req, res, next) => {
  try {
    const lat = req.query.lat ? parseFloat(req.query.lat as string) : undefined;
    const lng = req.query.lng ? parseFloat(req.query.lng as string) : undefined;
    sendSuccess(res, await svc.getHomeFeed(req.query.districtId as string, req.query.areaId as string, lat, lng));
  } catch (e) { next(e); }
});
customerRoutes.get('/districts', async (_req, res, next) => {
  try { sendSuccess(res, await svc.listPublicDistricts()); } catch (e) { next(e); }
});
customerRoutes.get('/app/version', async (_req, res, next) => {
  try {
    const { prisma } = await import('../../lib/prisma.js');
    const rows = await prisma.appSetting.findMany({ where: { key: { in: ['MIN_APP_VERSION', 'PLAY_STORE_URL'] } } });
    const settings = Object.fromEntries(rows.map((r: any) => [r.key, r.value]));
    sendSuccess(res, {
      minVersion: settings['MIN_APP_VERSION'] ?? '0.1.0',
      playStoreUrl: settings['PLAY_STORE_URL'] ?? 'https://play.google.com/store/apps/details?id=com.alltimemarket.app',
    });
  } catch (e) { next(e); }
});
customerRoutes.get('/areas', async (req, res, next) => {
  try {
    const districtId = req.query.districtId as string;
    if (!districtId) {
      sendSuccess(res, []);
      return;
    }
    sendSuccess(res, await svc.listPublicAreas(districtId));
  } catch (e) { next(e); }
});
customerRoutes.get('/categories', async (_req, res, next) => {
  try { sendSuccess(res, await svc.listCategories()); } catch (e) { next(e); }
});
customerRoutes.get('/shops', async (req, res, next) => {
  try {
    const lat = req.query.lat ? parseFloat(req.query.lat as string) : undefined;
    const lng = req.query.lng ? parseFloat(req.query.lng as string) : undefined;
    sendSuccess(res, await svc.listShops(req.query.districtId as string, req.query.areaId as string, req.query.categoryId as string, lat, lng));
  } catch (e) { next(e); }
});
customerRoutes.get('/shops/:id', async (req, res, next) => {
  try {
    const lat = req.query.lat ? parseFloat(req.query.lat as string) : undefined;
    const lng = req.query.lng ? parseFloat(req.query.lng as string) : undefined;
    sendSuccess(res, await svc.getShop(paramId(req), lat, lng));
  } catch (e) { next(e); }
});
customerRoutes.get('/shops/:id/products', async (req, res, next) => {
  try { sendSuccess(res, await svc.getShopProducts(paramId(req), req.query.categoryId as string)); } catch (e) { next(e); }
});
customerRoutes.get('/products', async (req, res, next) => {
  try {
    const { categoryId, districtId, sort, page, limit, lat, lng } = req.query as Record<string, string>;
    const latitude = lat ? parseFloat(lat) : undefined;
    const longitude = lng ? parseFloat(lng) : undefined;
    sendSuccess(res, await svc.listProducts(categoryId, districtId, sort, Number(page) || 1, Number(limit) || 20, latitude, longitude));
  } catch (e) { next(e); }
});
customerRoutes.get('/products/:id', async (req, res, next) => {
  try { sendSuccess(res, await svc.getProduct(paramId(req), req.user)); } catch (e) { next(e); }
});
customerRoutes.get('/search', async (req, res, next) => {
  try {
    const customerId = req.user?.role === 'CUSTOMER' ? req.user.sub : undefined;
    const lat = req.query.lat ? parseFloat(req.query.lat as string) : undefined;
    const lng = req.query.lng ? parseFloat(req.query.lng as string) : undefined;
    sendSuccess(res, await svc.search(req.query.q as string, req.query.districtId as string, req.query.scope as string, customerId, lat, lng));
  } catch (e) { next(e); }
});
customerRoutes.get('/search/trending', async (req, res, next) => {
  try { sendSuccess(res, await svc.getTrendingSearches(req.query.districtId as string)); } catch (e) { next(e); }
});
customerRoutes.get('/pages/:slug', async (req, res, next) => {
  try { sendSuccess(res, await svc.getStaticPage(req.params.slug)); } catch (e) { next(e); }
});

// Protected routes
const auth = [authenticate, authorize('CUSTOMER')] as const;
customerRoutes.get('/cart', ...auth, async (req, res, next) => {
  try { sendSuccess(res, await svc.getCart(req.user!.sub)); } catch (e) { next(e); }
});
customerRoutes.post('/cart', ...auth, async (req, res, next) => {
  try {
    const body = addToCartSchema.parse(req.body);
    sendSuccess(res, await svc.addToCart(req.user!.sub, body.productId, body.quantity), 201);
  } catch (e) { next(e); }
});
customerRoutes.put('/cart/:productId', ...auth, async (req, res, next) => {
  try {
    const body = updateCartSchema.parse(req.body);
    sendSuccess(res, await svc.updateCartItem(req.user!.sub, paramId(req, 'productId'), body.quantity));
  } catch (e) { next(e); }
});
customerRoutes.delete('/cart/:productId', ...auth, async (req, res, next) => {
  try { await svc.removeFromCart(req.user!.sub, paramId(req, 'productId')); sendSuccess(res, { deleted: true }); } catch (e) { next(e); }
});
customerRoutes.post('/cart/coupon', ...auth, async (req, res, next) => {
  try {
    const body = couponSchema.parse(req.body);
    sendSuccess(res, await svc.applyCartCoupon(req.user!.sub, body.code));
  } catch (e) { next(e); }
});
customerRoutes.delete('/cart/coupon', ...auth, async (req, res, next) => {
  try { sendSuccess(res, await svc.removeCartCoupon(req.user!.sub)); } catch (e) { next(e); }
});
customerRoutes.post('/checkout', ...auth, async (req, res, next) => {
  try {
    const body = checkoutSchema.parse(req.body);
    sendSuccess(res, await svc.checkout(req.user!.sub, body.addressId, body.paymentMethod, body.couponCode), 201);
  } catch (e) { next(e); }
});
customerRoutes.get('/orders', ...auth, async (req, res, next) => {
  try {
    const r = await svc.listCustomerOrders(req.user!.sub, Number(req.query.page) || 1);
    sendSuccess(res, r.items, 200, { page: r.page, limit: r.limit, total: r.total });
  } catch (e) { next(e); }
});
customerRoutes.get('/orders/:id', ...auth, async (req, res, next) => {
  try { sendSuccess(res, await svc.getOrder(req.user!.sub, paramId(req))); } catch (e) { next(e); }
});
customerRoutes.post('/orders/:id/cancel', ...auth, async (req, res, next) => {
  try { sendSuccess(res, await svc.cancelOrder(req.user!.sub, paramId(req), req.body.reason)); } catch (e) { next(e); }
});
customerRoutes.get('/profile', ...auth, async (req, res, next) => {
  try { sendSuccess(res, await svc.getProfile(req.user!.sub)); } catch (e) { next(e); }
});
customerRoutes.put('/profile', ...auth, async (req, res, next) => {
  try {
    const body = profileSchema.parse(req.body);
    sendSuccess(res, await svc.updateProfile(req.user!.sub, body));
  } catch (e) { next(e); }
});
customerRoutes.get('/addresses', ...auth, async (req, res, next) => {
  try { sendSuccess(res, await svc.listAddresses(req.user!.sub)); } catch (e) { next(e); }
});
customerRoutes.post('/addresses', ...auth, async (req, res, next) => {
  try {
    const body = addressSchema.parse(req.body);
    sendSuccess(res, await svc.createAddress(req.user!.sub, body), 201);
  } catch (e) { next(e); }
});
customerRoutes.put('/addresses/:id', ...auth, async (req, res, next) => {
  try {
    const body = addressSchema.partial().parse(req.body);
    sendSuccess(res, await svc.updateAddress(req.user!.sub, paramId(req), body));
  } catch (e) { next(e); }
});
customerRoutes.delete('/addresses/:id', ...auth, async (req, res, next) => {
  try { await svc.deleteAddress(req.user!.sub, paramId(req)); sendSuccess(res, { deleted: true }); } catch (e) { next(e); }
});
customerRoutes.get('/coupons', ...auth, async (req, res, next) => {
  try { sendSuccess(res, await svc.getCustomerCoupons(req.user!.sub)); } catch (e) { next(e); }
});
customerRoutes.get('/wishlist', ...auth, async (req, res, next) => {
  try { sendSuccess(res, await svc.getWishlist(req.user!.sub)); } catch (e) { next(e); }
});
customerRoutes.post('/wishlist', ...auth, async (req, res, next) => {
  try {
    const body = wishlistSchema.parse(req.body);
    sendSuccess(res, await svc.addWishlist(req.user!.sub, body.productId), 201);
  } catch (e) { next(e); }
});
customerRoutes.delete('/wishlist/:productId', ...auth, async (req, res, next) => {
  try { await svc.removeWishlist(req.user!.sub, paramId(req, 'productId')); sendSuccess(res, { deleted: true }); } catch (e) { next(e); }
});
customerRoutes.post('/reviews', ...auth, async (req, res, next) => {
  try {
    const body = reviewSchema.parse(req.body);
    sendSuccess(res, await svc.createReview(req.user!.sub, body.orderId, body.rating, body.comment, body.productId), 201);
  } catch (e) { next(e); }
});
customerRoutes.get('/notifications', ...auth, async (req, res, next) => {
  try { sendSuccess(res, await svc.getNotifications(req.user!.sub)); } catch (e) { next(e); }
});
customerRoutes.patch('/notifications/:id/read', ...auth, async (req, res, next) => {
  try { await svc.markNotificationRead(req.user!.sub, paramId(req)); sendSuccess(res, { read: true }); } catch (e) { next(e); }
});
customerRoutes.get('/wallet', ...auth, async (req, res, next) => {
  try { sendSuccess(res, await svc.getWallet(req.user!.sub)); } catch (e) { next(e); }
});
customerRoutes.post('/support/tickets', ...auth, async (req, res, next) => {
  try {
    const body = supportTicketSchema.parse(req.body);
    sendSuccess(res, await svc.createTicket(req.user!.sub, body.subject, body.message, body.orderId), 201);
  } catch (e) { next(e); }
});
customerRoutes.get('/support/tickets', ...auth, async (req, res, next) => {
  try { sendSuccess(res, await svc.listTickets(req.user!.sub)); } catch (e) { next(e); }
});
customerRoutes.get('/search/recent', ...auth, async (req, res, next) => {
  try { sendSuccess(res, await svc.getRecentSearches(req.user!.sub)); } catch (e) { next(e); }
});
customerRoutes.post('/search/recent', ...auth, async (req, res, next) => {
  try { sendSuccess(res, await svc.addRecentSearch(req.user!.sub, req.body.query)); } catch (e) { next(e); }
});
customerRoutes.delete('/search/recent', ...auth, async (req, res, next) => {
  try { await svc.clearRecentSearches(req.user!.sub); sendSuccess(res, { cleared: true }); } catch (e) { next(e); }
});

// Vendor onboarding request
customerRoutes.use('/vendor-request', vendorRequestCustomerRoutes);

// Pincode lookup
customerRoutes.get('/pincode/:pincode', ...auth, async (req, res, next) => {
  try { sendSuccess(res, await svc.lookupPincode(req.params.pincode as string)); } catch (e) { next(e); }
});
