import { Request, Response, NextFunction } from 'express';
import { sendSuccess } from '../../utils/response.js';

export async function getAppSettings(_req: Request, res: Response, next: NextFunction) {
  try {
    const config = {
      roles: {
        CUSTOMER: {
          defaultRoute: '/(tabs)',
          allowedRoutes: ['/(tabs)', '/product', '/profile', '/cart'],
          features: {
            canAddToCart: true,
            canCheckout: true,
            canManageProducts: false,
            showWishlist: true,
          }
        },
        VENDOR: {
          defaultRoute: '/(vendor)',
          allowedRoutes: ['/(vendor)', '/product', '/profile'],
          features: {
            canAddToCart: false,
            canCheckout: false,
            canManageProducts: true,
            showWishlist: false,
          }
        },
        GUEST: {
          defaultRoute: '/(tabs)',
          allowedRoutes: ['/(tabs)', '/product'],
          features: {
            canAddToCart: false,
            canCheckout: false,
            canManageProducts: false,
            showWishlist: false,
          }
        }
      }
    };

    sendSuccess(res, config);
  } catch (e) {
    next(e);
  }
}
