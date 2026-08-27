import { prisma } from '../../lib/prisma.js';
import { cacheGet, cacheSet, cacheDel, cacheDelPattern } from '../../lib/redis.js';
import { NotFoundError, ValidationError, ForbiddenError } from '../../utils/errors.js';
import { env } from '../../config/env.js';
import { randomBytes } from 'crypto';

const memCartCoupons = new Map<string, string>();

async function resolveDistrictId(districtId?: string) {
  if (districtId && districtId !== 'default') return districtId;
  const d = await prisma.district.findFirst({ where: { isActive: true }, orderBy: { createdAt: 'asc' } });
  if (!d) throw new NotFoundError('No district configured — ask admin to create one');
  return d.id;
}

async function getAppSettings() {
  const rows = await prisma.appSetting.findMany();
  return Object.fromEntries(rows.map((r) => [r.key, r.value]));
}

async function validateCoupon(code: string, customerId: string, subtotal: number, vendorIds?: string[], categoryIds?: string[]) {
  const coupon = await prisma.coupon.findFirst({
    where: { code: code.toUpperCase(), isActive: true },
  });
  if (!coupon) throw new ValidationError('Invalid coupon code');
  const now = new Date();
  if (coupon.startsAt && coupon.startsAt > now) throw new ValidationError('Coupon not active yet');
  if (coupon.endsAt && coupon.endsAt < now) throw new ValidationError('Coupon expired');
  if (coupon.minOrder && subtotal < Number(coupon.minOrder)) {
    throw new ValidationError(`Minimum order ₹${coupon.minOrder} required for this coupon`);
  }
  if (coupon.usageLimit != null && coupon.usedCount >= coupon.usageLimit) {
    throw new ValidationError('Coupon usage limit reached');
  }

  const scope = (coupon as any).scope as string | null | undefined;
  if (scope === 'VENDOR' && (coupon as any).vendorId) {
    if (vendorIds && !vendorIds.includes((coupon as any).vendorId)) {
      throw new ValidationError('This coupon is not valid for items in your cart');
    }
  }
  if (scope === 'CATEGORY' && (coupon as any).categoryId) {
    if (categoryIds && !categoryIds.includes((coupon as any).categoryId)) {
      throw new ValidationError('This coupon is not valid for the categories in your cart');
    }
  }

  const userUses = await prisma.customerCoupon.count({ where: { customerId, couponId: coupon.id } });
  if (userUses >= coupon.perUserLimit) throw new ValidationError('You have already used this coupon');

  let discount = 0;
  if (coupon.discountAmt) discount = Number(coupon.discountAmt);
  else if (coupon.discountPct) {
    discount = (subtotal * Number(coupon.discountPct)) / 100;
    if (coupon.maxDiscount) discount = Math.min(discount, Number(coupon.maxDiscount));
  }
  return { coupon, discount: Math.min(discount, subtotal) };
}

async function getDeliveryCharge(districtId: string, subtotal: number) {
  const rule = await prisma.deliveryChargeRule.findFirst({
    where: { districtId, isActive: true },
    orderBy: { minDistance: 'asc' },
  });
  if (!rule) return 0;
  if (rule.freeAbove && subtotal >= Number(rule.freeAbove)) return 0;
  return Number(rule.charge);
}

async function getCartCouponCode(customerId: string) {
  const cached = await cacheGet<string>(`cart:coupon:${customerId}`);
  return cached ?? memCartCoupons.get(customerId) ?? null;
}

async function setCartCouponCode(customerId: string, code: string | null) {
  if (code) {
    memCartCoupons.set(customerId, code);
    await cacheSet(`cart:coupon:${customerId}`, code, 3600);
  } else {
    memCartCoupons.delete(customerId);
    await cacheDel(`cart:coupon:${customerId}`);
  }
}

// ─── Home Feed ─────────────────────────────────────────────────────────────────
function calculateDistance(lat1: number, lon1: number, lat2: number, lon2: number) {
  const R = 6371; // km
  const dLat = (lat2 - lat1) * Math.PI / 180;
  const dLon = (lon2 - lon1) * Math.PI / 180;
  const a = Math.sin(dLat/2) * Math.sin(dLat/2) +
            Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
            Math.sin(dLon/2) * Math.sin(dLon/2);
  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
  return R * c;
}

export async function getHomeFeed(districtIdInput: string, areaId?: string, lat?: number, lng?: number) {
  const districtId = await resolveDistrictId(districtIdInput);
  const cacheKey = `home:feed:${districtId}:${areaId ?? 'all'}:${lat ?? 0}:${lng ?? 0}`;
  
  const cached = await cacheGet<unknown>(cacheKey);
  if (cached) return cached;
  
  const allVendors = await prisma.vendor.findMany({
    where: { districtId, status: 'APPROVED', isOpen: true },
    select: { id: true, shopName: true, slug: true, logoUrl: true, bannerUrl: true, rating: true, minOrderValue: true, latitude: true, longitude: true, deliveryRadius: true, areaId: true },
  });

  let filteredVendors = allVendors;
  if (lat && lng) {
    filteredVendors = allVendors.filter(v => {
      if (v.latitude == null || v.longitude == null) return false;
      const distance = calculateDistance(lat, lng, v.latitude, v.longitude);
      return distance <= v.deliveryRadius;
    });
  } else if (areaId) {
    filteredVendors = allVendors.filter(v => v.areaId === areaId);
  }

  const vendors = filteredVendors.slice(0, 10);
  const vendorIds = vendors.map(v => v.id);

  const now = new Date();
  const [banners, categories, layoutSetting, deliveryRules] = await Promise.all([
    prisma.banner.findMany({ where: { OR: [{ districtId }, { districtId: null }], isActive: true }, orderBy: { sortOrder: 'asc' }, take: 5 }),
    prisma.category.findMany({ where: { parentId: null, isActive: true }, orderBy: { sortOrder: 'asc' }, take: 12 }),
    prisma.appSetting.findUnique({ where: { key: 'HOME_PAGE_LAYOUT' } }),
    prisma.deliveryChargeRule.findFirst({ where: { OR: [{ districtId }, { districtId: null }], isActive: true } })
  ]);

  const feed = {
    banners,
    categories,
    layout: layoutSetting?.value || null,
    deliveryRule: deliveryRules || null,
  };
  await cacheSet(cacheKey, feed, 120);
  return feed;
}

/** GPS-first home feed — no districtId needed. Finds all vendors within deliveryRadius of user coords.
 *  Returns { serviced: false } when no vendors cover the user's location. */
export async function getHomeFeedByLocation(lat: number, lng: number) {
  const cacheKey = `home:feed:gps:${lat.toFixed(4)}:${lng.toFixed(4)}`;
  const cached = await cacheGet<unknown>(cacheKey);
  if (cached) return cached;

  // Find ALL approved, open vendors that have coordinates + deliveryRadius
  const allVendors = await prisma.vendor.findMany({
    where: { status: 'APPROVED', isOpen: true },
    select: {
      id: true, shopName: true, slug: true, logoUrl: true, bannerUrl: true,
      rating: true, minOrderValue: true, latitude: true, longitude: true,
      deliveryRadius: true, areaId: true, districtId: true,
    },
  });

  // Filter to vendors whose deliveryRadius covers the user's GPS position
  const nearbyVendors = allVendors.filter((v) => {
    if (v.latitude == null || v.longitude == null) return false;
    return calculateDistance(lat, lng, v.latitude, v.longitude) <= v.deliveryRadius;
  }).slice(0, 10);

  // If no vendors serve this location → tell the app
  if (nearbyVendors.length === 0) {
    const feed = { serviced: false, banners: [], categories: [], layout: null, deliveryRule: null };
    await cacheSet(cacheKey, feed, 60);
    return feed;
  }

  const vendorIds = nearbyVendors.map((v) => v.id);
  const now = new Date();

  const [banners, categories, layoutSetting, deliveryRules] = await Promise.all([
    prisma.banner.findMany({ where: { isActive: true }, orderBy: { sortOrder: 'asc' }, take: 5 }),
    prisma.category.findMany({ where: { parentId: null, isActive: true }, orderBy: { sortOrder: 'asc' }, take: 12 }),
    prisma.appSetting.findUnique({ where: { key: 'HOME_PAGE_LAYOUT' } }),
    prisma.deliveryChargeRule.findFirst({ where: { isActive: true } }),
  ]);

  const feed = {
    serviced: true,
    banners, 
    categories,
    layout: layoutSetting?.value || null,
    deliveryRule: deliveryRules || null,
  };
  await cacheSet(cacheKey, feed, 120);
  return feed;
}

/** Reverse geocode lat/lng to real town, area & district names */
export async function reverseGeocodeLocation(lat: number, lng: number) {
  const cacheKey = `geo:rev:${lat.toFixed(4)}:${lng.toFixed(4)}`;
  const cached = await cacheGet<{ displayName: string; locality: string; district: string }>(cacheKey);
  if (cached) return cached;

  let local = '';
  let district = '';

  // Strategy 1: Google Maps API (Highest Accuracy if Key available)
  if (env.GOOGLE_MAP_API_KEY) {
    try {
      const controller = new AbortController();
      const timeout = setTimeout(() => controller.abort(), 4000);
      const res = await fetch(`https://maps.googleapis.com/maps/api/geocode/json?latlng=${lat},${lng}&key=${env.GOOGLE_MAP_API_KEY}`, { signal: controller.signal });
      clearTimeout(timeout);
      
      if (res.ok) {
        const data: any = await res.json();
        if (data.status === 'OK' && data.results && data.results.length > 0) {
           const result = data.results.find((r: any) => !r.types.includes('plus_code')) || data.results[0];
           
           const getC = (t: string) => result.address_components.find((c: any) => c.types.includes(t))?.short_name;
           const sub2 = getC('sublocality_level_2') || getC('neighborhood');
           const sub1 = getC('sublocality_level_1');
           const loc = getC('locality');
           const route = getC('route');
           
           gLocal = [sub2, sub1, loc].filter(Boolean).filter((v, i, a) => a.indexOf(v) === i).join(', ') || route || result.formatted_address.split(',')[0];
           gDistrict = getC('administrative_area_level_3') || getC('administrative_area_level_2') || '';
           
           local = gLocal || '';
           district = gDistrict || '';
        }
      }
    } catch (e) {
       console.warn('[Server Geocode] Google Maps failed, falling back...', e);
    }
  }

  // Strategy 2: OpenStreetMap Nominatim (High Accuracy Fallback)
  if (!local || !district) {
    try {
      const controller = new AbortController();
      const timeout = setTimeout(() => controller.abort(), 4000);
      const res = await fetch(
        `https://nominatim.openstreetmap.org/reverse?format=json&lat=${lat}&lon=${lng}&zoom=18&addressdetails=1`,
        {
          headers: { 'User-Agent': 'DistrictMart-Server/1.0 (contact@districtmart.com)' },
          signal: controller.signal,
        }
      );
      clearTimeout(timeout);
      if (res.ok) {
        const data: any = await res.json();
        const addr = data.address || {};
        const suburb = addr.suburb || addr.neighbourhood || addr.village || addr.city_district || addr.road || '';
        const town = addr.town || addr.city || '';
        
        if (suburb && town && suburb !== town) {
          local = `${suburb}, ${town}`;
        } else {
          local = suburb || town || '';
        }
        district = (addr.state_district || addr.county || addr.city || '').replace(/ district/i, '').replace(/ taluk/i, '').trim();
      }
    } catch (e) {
      console.warn('[Server Geocode] Nominatim failed, falling back to BigDataCloud...', e);
    }
  }

  // Strategy 2: BigDataCloud API (Town/City level Fallback)
  if (!local || !district) {
    try {
      const controller = new AbortController();
      const timeout = setTimeout(() => controller.abort(), 4000);
      const res = await fetch(
        `https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=${lat}&longitude=${lng}&localityLanguage=en`,
        { signal: controller.signal }
      );
      clearTimeout(timeout);
      if (res.ok) {
        const data: any = await res.json();
        const adminList = Array.isArray(data.localityInfo?.administrative)
          ? [...data.localityInfo.administrative].sort((a, b) => (b.order || 0) - (a.order || 0))
          : [];

        if (!local) {
          for (const a of adminList) {
            if (a.adminLevel >= 6 && a.name && !a.name.toLowerCase().includes('taluk') && !a.name.toLowerCase().includes('district')) {
              local = a.name.trim();
              break;
            }
          }
          if (!local) local = data.locality || data.city || '';
        }

        if (!district) {
          const distObj = adminList.find(
            (a: any) => a.adminLevel === 5 || a.name?.toLowerCase().includes('district')
          );
          if (distObj) {
            district = distObj.name.replace(/ district/i, '').replace(/ taluk/i, '').trim();
          }
          if (!district) district = (data.principalSubdivision || '').trim();
        }
      }
    } catch (e) {
      console.warn('[Server Geocode] BigDataCloud failed...', e);
    }
  }

  // Strategy 3: Database nearest district/area coordinate match fallback
  if (!local || !district) {
    const districts = await prisma.district.findMany({ where: { isActive: true, latitude: { not: null } } });
    if (districts.length > 0) {
      const nearestDist = districts.reduce((best, d) => {
        const d1 = calculateDistance(lat, lng, d.latitude!, d.longitude!);
        const d2 = calculateDistance(lat, lng, best.latitude!, best.longitude!);
        return d1 < d2 ? d : best;
      });
      district = nearestDist.name;

      const areas = await prisma.area.findMany({ where: { districtId: nearestDist.id, isActive: true, latitude: { not: null } } });
      if (areas.length > 0) {
        const nearestArea = areas.reduce((best, a) => {
          const d1 = calculateDistance(lat, lng, a.latitude!, a.longitude!);
          const d2 = calculateDistance(lat, lng, best.latitude!, best.longitude!);
          return d1 < d2 ? a : best;
        });
        local = nearestArea.name;
      }
    }
  }

  const displayName = local && district && local.toLowerCase() !== district.toLowerCase()
    ? `${local}, ${district}`
    : (local || district || 'Your Location');

  const result = { displayName, locality: local, district };
  await cacheSet(cacheKey, result, 86400); // 24hr cache
  return result;
}

/** Save or update device location in DeviceLocation and Customer tables */
export async function saveDeviceLocation(data: {
  deviceId: string;
  displayName: string;
  latitude: number;
  longitude: number;
  districtId?: string;
  areaId?: string;
  customerId?: string;
}) {
  const result = await prisma.deviceLocation.upsert({
    where: { deviceId: data.deviceId },
    update: {
      displayName: data.displayName,
      latitude: data.latitude,
      longitude: data.longitude,
      districtId: data.districtId,
      areaId: data.areaId,
      customerId: data.customerId,
      updatedAt: new Date(),
    },
    create: {
      deviceId: data.deviceId,
      displayName: data.displayName,
      latitude: data.latitude,
      longitude: data.longitude,
      districtId: data.districtId,
      areaId: data.areaId,
      customerId: data.customerId,
    },
  });

  if (data.customerId) {
    await prisma.customer.update({
      where: { id: data.customerId },
      data: {
        currentLatitude: data.latitude,
        currentLongitude: data.longitude,
        currentLocation: data.displayName,
      },
    }).catch((err) => {
      console.warn('[saveDeviceLocation] Customer update error:', err);
    });
  }

  return result;
}


export async function listPublicDistricts() {

  return prisma.district.findMany({ where: { isActive: true }, orderBy: { name: 'asc' } });
}


export async function listPublicAreas(districtId: string) {
  return prisma.area.findMany({ where: { districtId, isActive: true }, orderBy: { name: 'asc' } });
}

export async function listCategories() {
  return prisma.category.findMany({
    where: { parentId: null, isActive: true },
    select: {
      id: true,
      name: true,
      imageUrl: true,
      children: { 
        where: { isActive: true }, 
        orderBy: { sortOrder: 'asc' },
        select: { id: true, name: true, imageUrl: true, parentId: true }
      }
    },
    orderBy: { sortOrder: 'asc' },
  });
}

export async function listShops(districtIdInput: string, areaId?: string, categoryId?: string, lat?: number, lng?: number) {
  const districtId = await resolveDistrictId(districtIdInput);
  const allVendors = await prisma.vendor.findMany({
    where: {
      districtId, status: 'APPROVED',
      ...(categoryId ? { products: { some: { categoryId, status: 'PUBLISHED' } } } : {}),
    },
    select: {
      id: true, shopName: true, logoUrl: true, bannerUrl: true, rating: true, minOrderValue: true, address: true,
      areaId: true, area: { select: { name: true } }, latitude: true, longitude: true, deliveryRadius: true,
      _count: { select: { products: { where: { status: 'PUBLISHED', isActive: true } } } }
    },
    orderBy: { rating: 'desc' },
  });

  let processedVendors = allVendors.map(v => {
    let distance = -1;
    let inDeliveryRadius = true;
    if (lat && lng && v.latitude != null && v.longitude != null) {
      distance = calculateDistance(lat, lng, v.latitude, v.longitude);
      inDeliveryRadius = distance <= v.deliveryRadius;
    } else if (areaId && v.areaId !== areaId) {
      inDeliveryRadius = false;
    }
    return { ...v, distance: distance !== -1 ? distance : undefined, inDeliveryRadius };
  });

  if (lat && lng) {
    processedVendors.sort((a, b) => {
      if (a.distance === undefined && b.distance !== undefined) return 1;
      if (b.distance === undefined && a.distance !== undefined) return -1;
      if (a.distance !== undefined && b.distance !== undefined) return a.distance - b.distance;
      return 0;
    });
  }

  return processedVendors;
}

export async function getShop(vendorId: string) {
  const vendor = await prisma.vendor.findFirst({
    where: { id: vendorId, status: 'APPROVED' },
    select: {
      id: true,
      shopName: true,
      phone: true,
      logoUrl: true,
      bannerUrl: true,
      rating: true,
      ratingCount: true,
      minOrderValue: true,
      address: true,
      fssaiNumber: true,
      isOpen: true,
      districtId: true,
      area: { select: { name: true, district: { select: { name: true } } } },
      reviews: { select: { id: true, rating: true, comment: true, createdAt: true, customer: { select: { name: true } } } },
    },
  });
  if (!vendor) throw new NotFoundError('Shop not found');
  return vendor;
}

export async function getShopProducts(vendorId: string, categoryId?: string) {
  return prisma.product.findMany({
    where: { vendorId, status: 'PUBLISHED', isActive: true, ...(categoryId ? { categoryId } : {}) },
    select: {
      id: true,
      name: true,
      mrp: true,
      sellingPrice: true,
      unit: true,
      weight: true,
      images: { take: 1, select: { url: true } },
      inventory: { select: { stock: true } },
      category: { select: { name: true } }
    },
    orderBy: { name: 'asc' },
  });
}

export async function getProduct(productId: string, user?: { role: string; sub: string }) {
  const product = await prisma.product.findUnique({
    where: { id: productId },
    select: {
      id: true,
      name: true,
      description: true,
      brand: true,
      sellingPrice: true,
      mrp: true,
      unit: true,
      weight: true,
      tags: true,
      status: true,
      vendorId: true,
      categoryId: true,
      images: { select: { url: true, isPrimary: true } },
      inventory: { select: { stock: true } },
      category: { select: { name: true } },
      subCategory: { select: { name: true } },
      vendor: { select: { id: true, shopName: true, slug: true } },
      reviews: { where: { isVisible: true }, take: 10, select: { rating: true, comment: true, createdAt: true, customer: { select: { name: true } } } }
    }
  });
  if (!product) throw new NotFoundError('Product not found');

  if (product.status !== 'PUBLISHED') {
    if (user?.role !== 'VENDOR' || user.sub !== product.vendorId) {
      throw new NotFoundError('Product not found');
    }
  }

  const relatedProducts = await prisma.product.findMany({
    where: { 
      categoryId: product.categoryId, 
      id: { not: productId },
      status: 'PUBLISHED'
    },
    take: 6,
    select: {
      id: true,
      name: true,
      mrp: true,
      sellingPrice: true,
      unit: true,
      weight: true,
      images: { take: 1, select: { url: true } },
      vendor: { select: { shopName: true } }
    }
  });

  return { ...product, relatedProducts };
}

// ─── Product List ───────────────────────────────────────────────────────────────
export async function listProducts(categoryId?: string, districtIdInput?: string, sort?: string, page = 1, limit = 20, lat?: number, lng?: number) {
  const districtId = districtIdInput ? await resolveDistrictId(districtIdInput) : undefined;
  const skip = (page - 1) * limit;
  const orderBy: any =
    sort === 'price_asc' ? { sellingPrice: 'asc' } :
    sort === 'price_desc' ? { sellingPrice: 'desc' } :
    sort === 'name' ? { name: 'asc' } :
    { createdAt: 'desc' };

  let allowedVendorIds: string[] | undefined;
  if (lat !== undefined && lng !== undefined) {
    const vendors = await prisma.vendor.findMany({
      where: { status: 'APPROVED', isOpen: true, ...(districtId ? { districtId } : {}) },
      select: { id: true, latitude: true, longitude: true, deliveryRadius: true }
    });
    allowedVendorIds = vendors
      .filter(v => v.latitude != null && v.longitude != null && calculateDistance(lat, lng, v.latitude, v.longitude) <= v.deliveryRadius)
      .map(v => v.id);
      
    if (allowedVendorIds.length === 0) {
      return { products: [], total: 0, page, limit, totalPages: 0 };
    }
  }

  const where: any = {
    status: 'PUBLISHED',
    isActive: true,
    ...(allowedVendorIds ? { vendorId: { in: allowedVendorIds } } : districtId ? { vendor: { districtId, status: 'APPROVED' } } : {}),
    ...(categoryId ? { categoryId } : {}),
  };

  const [products, total] = await Promise.all([
    prisma.product.findMany({
      where,
      select: {
        id: true,
        name: true,
        mrp: true,
        sellingPrice: true,
        unit: true,
        weight: true,
        categoryId: true,
        images: { where: { isPrimary: true }, take: 1, select: { url: true } },
        vendor: { select: { shopName: true, id: true } },
        category: { select: { name: true } },
      },
      orderBy,
      skip,
      take: limit,
    }),
    prisma.product.count({ where }),
  ]);

  return { products, total, page, limit, totalPages: Math.ceil(total / limit) };
}

// ─── Search ────────────────────────────────────────────────────────────────────
export async function search(q: string, districtIdInput?: string, scope?: string, customerId?: string, lat?: number, lng?: number) {
  const query = q.trim();
  if (!query) return { products: [], shops: [], categories: [] };
  const districtId = districtIdInput ? await resolveDistrictId(districtIdInput) : undefined;
  await prisma.searchLog.create({ data: { query, districtId, customerId } });

  const isPg = process.env.DATABASE_URL?.startsWith('postgres');
  const modeObj = isPg ? { mode: 'insensitive' } : {};

  let allowedVendorIds: string[] | undefined;
  if (lat !== undefined && lng !== undefined) {
    const vendors = await prisma.vendor.findMany({
      where: { status: 'APPROVED', isOpen: true, ...(districtId ? { districtId } : {}) },
      select: { id: true, latitude: true, longitude: true, deliveryRadius: true }
    });
    allowedVendorIds = vendors
      .filter(v => v.latitude != null && v.longitude != null && calculateDistance(lat, lng, v.latitude, v.longitude) <= v.deliveryRadius)
      .map(v => v.id);
  }

  const productWhere = {
    status: 'PUBLISHED' as const,
    OR: [
      { name: { contains: query, ...modeObj } },
      { brand: { contains: query, ...modeObj } },
    ],
    ...(allowedVendorIds ? { vendorId: { in: allowedVendorIds } } : districtId ? { vendor: { districtId } } : {}),
  } as any;
  
  const shopWhere = {
    shopName: { contains: query, ...modeObj },
    status: 'APPROVED',
    ...(districtId ? { districtId } : {})
  } as any;

  const [products, shops, categories] = await Promise.all([
    scope === 'shops' ? [] : prisma.product.findMany({ 
      where: productWhere, 
      take: 20, 
      select: {
        id: true,
        name: true,
        mrp: true,
        sellingPrice: true,
        unit: true,
        images: { take: 1, select: { url: true } },
        vendor: { select: { shopName: true } }
      }
    }),
    scope === 'products' ? [] : prisma.vendor.findMany({ 
      where: shopWhere, 
      take: 20,
      select: {
        id: true,
        shopName: true,
        logoUrl: true,
        rating: true,
        latitude: true,
        longitude: true,
        deliveryRadius: true,
        area: { select: { name: true } }
      }
    }),
    scope === 'products' || scope === 'shops' ? [] : prisma.category.findMany({ 
      where: { name: { contains: query, ...modeObj } } as any, 
      take: 5,
      select: { id: true, name: true, imageUrl: true }
    }),
  ]);

  const processedShops = (shops as any[]).map(v => {
    let distance = -1;
    let inDeliveryRadius = true;
    if (lat !== undefined && lng !== undefined && v.latitude != null && v.longitude != null) {
      distance = calculateDistance(lat, lng, v.latitude, v.longitude);
      inDeliveryRadius = distance <= v.deliveryRadius;
    }
    return { 
      id: v.id, shopName: v.shopName, logoUrl: v.logoUrl, rating: v.rating, area: v.area,
      distance: distance !== -1 ? distance : undefined, 
      inDeliveryRadius 
    };
  });

  if (lat !== undefined && lng !== undefined) {
    processedShops.sort((a, b) => {
      if (a.distance === undefined && b.distance !== undefined) return 1;
      if (b.distance === undefined && a.distance !== undefined) return -1;
      if (a.distance !== undefined && b.distance !== undefined) return a.distance - b.distance;
      return 0;
    });
  }

  return { products, shops: processedShops.slice(0, 10), categories };
}

export async function getTrendingSearches(districtIdInput?: string) {
  const districtId = districtIdInput ? await resolveDistrictId(districtIdInput) : undefined;
  const since = new Date(Date.now() - 7 * 86400000);
  const logs = await prisma.searchLog.groupBy({
    by: ['query'],
    where: { createdAt: { gte: since }, ...(districtId ? { districtId } : {}) },
    _count: true,
    orderBy: { _count: { query: 'desc' } },
    take: 10,
  });
  return logs.map((l) => ({ query: l.query, count: l._count }));
}

export async function getRecentSearches(customerId: string) {
  const logs = await prisma.searchLog.findMany({
    where: { customerId },
    orderBy: { createdAt: 'desc' },
    take: 20,
    distinct: ['query'],
  });
  return logs.map((l) => l.query);
}

export async function addRecentSearch(customerId: string, query: string) {
  const q = query.trim();
  if (!q) return [];
  await prisma.searchLog.create({ data: { customerId, query: q } });
  return getRecentSearches(customerId);
}

export async function clearRecentSearches(customerId: string) {
  await prisma.searchLog.deleteMany({ where: { customerId } });
}
// ─── Cart ──────────────────────────────────────────────────────────────────────
export async function getCart(customerId: string) {
  const items = await prisma.cartItem.findMany({
    where: { customerId },
    select: {
      id: true,
      productId: true,
      quantity: true,
      vendorId: true,
      vendor: { select: { id: true, shopName: true, minOrderValue: true, districtId: true } },
      product: {
        select: {
          id: true,
          name: true,
          sellingPrice: true,
          mrp: true,
          unit: true,
          weight: true,
          images: { take: 1, select: { url: true } },
          inventory: { select: { stock: true } }
        }
      }
    }
  });
  const subtotal = items.reduce((s, i) => s + Number(i.product.sellingPrice) * i.quantity, 0);
  const couponCode = await getCartCouponCode(customerId);
  let couponPreview: { code: string; discount: number } | null = null;
  if (couponCode && subtotal > 0) {
    try {
      const { coupon, discount } = await validateCoupon(couponCode, customerId, subtotal);
      couponPreview = { code: coupon.code, discount };
    } catch {
      await setCartCouponCode(customerId, null);
    }
  }
  const districtId = items[0]?.vendor?.districtId;
  const deliveryCharge = districtId ? await getDeliveryCharge(districtId, subtotal) : 0;
  const settings = await getAppSettings();
  const taxPercent = Number(settings.taxPercent ?? 0);
  const discount = couponPreview?.discount ?? 0;
  const taxable = Math.max(0, subtotal - discount);
  const tax = (taxable * taxPercent) / 100;
  const grandTotal = taxable + deliveryCharge + tax;

  const byVendor: Record<string, typeof items> = {};
  for (const item of items) {
    if (!byVendor[item.vendorId]) byVendor[item.vendorId] = [];
    byVendor[item.vendorId].push(item);
  }
  return {
    items,
    byVendor: Object.entries(byVendor).map(([vendorId, vendorItems]) => ({ vendorId, vendor: vendorItems[0].vendor, items: vendorItems })),
    summary: { subtotal, discount, deliveryCharge, tax, taxPercent, grandTotal, couponCode: couponPreview?.code ?? null },
  };
}
export async function addToCart(customerId: string, productId: string, quantity = 1) {
  const product = await prisma.product.findFirst({
    where: { id: productId, status: 'PUBLISHED', isActive: true },
    include: { inventory: true },
  });
  if (!product) throw new NotFoundError('Product not found');

  const existing = await prisma.cartItem.findUnique({
    where: { customerId_productId: { customerId, productId } },
  });
  const nextQty = (existing?.quantity ?? 0) + quantity;
  if (!product.inventory || product.inventory.stock < nextQty) {
    throw new ValidationError('Insufficient stock');
  }

  return prisma.cartItem.upsert({
    where: { customerId_productId: { customerId, productId } },
    create: { customerId, productId, vendorId: product.vendorId, quantity },
    update: { quantity: nextQty },
    include: { product: true },
  });
}

export async function updateCartItem(customerId: string, productId: string, quantity: number) {
  if (quantity <= 0) {
    await prisma.cartItem.deleteMany({ where: { customerId, productId } });
    return { deleted: true };
  }
  const product = await prisma.product.findFirst({ where: { id: productId }, include: { inventory: true } });
  if (!product?.inventory || product.inventory.stock < quantity) throw new ValidationError('Insufficient stock');
  return prisma.cartItem.update({ where: { customerId_productId: { customerId, productId } }, data: { quantity } });
}

export async function removeFromCart(customerId: string, productId: string) {
  await prisma.cartItem.deleteMany({ where: { customerId, productId } });
}

export async function applyCartCoupon(customerId: string, code: string) {
  const cartItems = await prisma.cartItem.findMany({ where: { customerId }, include: { product: true } });
  if (cartItems.length === 0) throw new ValidationError('Cart is empty');
  const subtotal = cartItems.reduce((s, i) => s + Number(i.product.sellingPrice) * i.quantity, 0);
  const { coupon, discount } = await validateCoupon(code, customerId, subtotal);
  await setCartCouponCode(customerId, coupon.code);
  return { code: coupon.code, discount, message: `Coupon applied — you save ₹${discount.toFixed(0)}` };
}

export async function removeCartCoupon(customerId: string) {
  await setCartCouponCode(customerId, null);
  return { removed: true };
}

// ─── Checkout (split orders per vendor) ────────────────────────────────────────
export async function checkout(customerId: string, addressId: string, paymentMethod: 'COD' | 'RAZORPAY' = 'COD', couponCode?: string) {
  if (paymentMethod !== 'COD') {
    throw new ValidationError('Only Cash on Delivery is available right now');
  }

  const address = await prisma.address.findFirst({ where: { id: addressId, customerId } });
  if (!address) throw new NotFoundError('Address not found');

  const cartItems = await prisma.cartItem.findMany({
    where: { customerId },
    include: { product: { include: { inventory: true } }, vendor: true },
  });
  if (cartItems.length === 0) throw new ValidationError('Cart is empty');

  for (const item of cartItems) {
    if (!item.product.isActive || item.product.status !== 'PUBLISHED') {
      throw new ValidationError(`${item.product.name} is no longer available`);
    }
    if (!item.product.inventory || item.product.inventory.stock < item.quantity) {
      throw new ValidationError(`Insufficient stock for ${item.product.name}`);
    }
  }

  const byVendor = new Map<string, typeof cartItems>();
  for (const item of cartItems) {
    const list = byVendor.get(item.vendorId) ?? [];
    list.push(item);
    byVendor.set(item.vendorId, list);
  }

  for (const items of byVendor.values()) {
    const vendorSubtotal = items.reduce((s, i) => s + Number(i.product.sellingPrice) * i.quantity, 0);
    const minOrder = Number(items[0].vendor.minOrderValue ?? 0);
    if (minOrder > 0 && vendorSubtotal < minOrder) {
      throw new ValidationError(
        `Minimum order for ${items[0].vendor.shopName} is ₹${minOrder.toFixed(0)}. Add ₹${(minOrder - vendorSubtotal).toFixed(0)} more.`
      );
    }
  }

  const cartSubtotal = cartItems.reduce((s, i) => s + Number(i.product.sellingPrice) * i.quantity, 0);
  const appliedCode = couponCode ?? (await getCartCouponCode(customerId)) ?? undefined;
  let totalDiscount = 0;
  let couponRecord: { id: string; code: string } | null = null;
  if (appliedCode) {
    const validated = await validateCoupon(appliedCode, customerId, cartSubtotal);
    totalDiscount = validated.discount;
    couponRecord = { id: validated.coupon.id, code: validated.coupon.code };
  }

  const districtId = cartItems[0].vendor.districtId;
  const deliveryChargeTotal = await getDeliveryCharge(districtId, cartSubtotal);
  const settings = await getAppSettings();
  const taxPercent = Number(settings.taxPercent ?? 0);
  const taxable = Math.max(0, cartSubtotal - totalDiscount);
  const taxTotal = (taxable * taxPercent) / 100;
  const grandTotalAll = taxable + deliveryChargeTotal + taxTotal;

  const paymentRef = `pay_${randomBytes(8).toString('hex')}`;

  const result = await prisma.$transaction(async (tx) => {
    const payment = await tx.payment.create({
      data: {
        reference: paymentRef,
        customerId,
        amount: grandTotalAll,
        method: paymentMethod,
        status: paymentMethod === 'COD' ? 'PENDING' : 'PENDING',
      },
    });

    const orders = [];
    let vendorIndex = 0;
    const vendorCount = byVendor.size;

    for (const [vendorId, items] of byVendor) {
      const subtotal = items.reduce((s, i) => s + Number(i.product.sellingPrice) * i.quantity, 0);
      const share = cartSubtotal > 0 ? subtotal / cartSubtotal : 1 / vendorCount;
      const discount = totalDiscount * share;
      const deliveryCharge = deliveryChargeTotal * share;
      const tax = taxTotal * share;
      const grandTotal = subtotal - discount + deliveryCharge + tax;
      const orderNumber = `ORD-${Date.now()}-${randomBytes(3).toString('hex')}`;
      vendorIndex++;

      const order = await tx.order.create({
        data: {
          orderNumber,
          customerId,
          vendorId,
          addressId,
          paymentId: payment.id,
          subtotal,
          discount,
          deliveryCharge,
          tax,
          grandTotal,
          couponCode: couponRecord?.code,
          status: 'PLACED',
          items: {
            create: items.map((i) => ({
              productId: i.productId,
              name: i.product.name,
              quantity: i.quantity,
              unitPrice: i.product.sellingPrice,
              total: Number(i.product.sellingPrice) * i.quantity,
            })),
          },
        },
        include: { items: true, vendor: { select: { shopName: true } } },
      });

      for (const item of items) {
        const stockUpdate = await tx.inventory.updateMany({
          where: { productId: item.productId, stock: { gte: item.quantity } },
          data: { stock: { decrement: item.quantity } },
        });
        if (stockUpdate.count === 0) {
          throw new ValidationError(`Insufficient stock for ${item.product.name}`);
        }
      }

      await tx.notification.create({
        data: {
          vendorId,
          type: 'ORDER',
          title: 'New order received',
          body: `Order ${orderNumber} — ₹${Number(grandTotal).toFixed(0)}`,
          data: { orderId: order.id },
        },
      });

      orders.push(order);
    }

    if (couponRecord) {
      await tx.coupon.update({ where: { id: couponRecord.id }, data: { usedCount: { increment: 1 } } });
      await tx.customerCoupon.create({ data: { customerId, couponId: couponRecord.id } });
    }

    await tx.cartItem.deleteMany({ where: { customerId } });
    await setCartCouponCode(customerId, null);
    return { payment, orders, summary: { subtotal: cartSubtotal, discount: totalDiscount, deliveryCharge: deliveryChargeTotal, tax: taxTotal, grandTotal: grandTotalAll } };
  });

  await cacheDelPattern('home:feed:*');
  return result;
}
// ─── Orders ────────────────────────────────────────────────────────────────────
export async function listCustomerOrders(customerId: string, page = 1, limit = 20) {
  const skip = (page - 1) * limit;
  const [items, total] = await Promise.all([
    prisma.order.findMany({ 
      where: { customerId }, 
      skip, 
      take: limit, 
      select: {
        id: true,
        orderNumber: true,
        status: true,
        grandTotal: true,
        createdAt: true,
        vendor: { select: { shopName: true } }, 
        items: { select: { id: true, name: true, quantity: true, unitPrice: true, total: true } }
      }, 
      orderBy: { createdAt: 'desc' } 
    }),
    prisma.order.count({ where: { customerId } }),
  ]);
  return { items, total, page, limit };
}

export async function getOrder(customerId: string, orderId: string) {
  const order = await prisma.order.findFirst({ 
    where: { id: orderId, customerId }, 
    select: {
      id: true,
      orderNumber: true,
      status: true,
      subtotal: true,
      deliveryCharge: true,
      tax: true,
      discount: true,
      grandTotal: true,
      createdAt: true,
      cancelReason: true,
      cancelledAt: true,
      vendor: { select: { shopName: true, logoUrl: true, address: true } },
      address: { select: { label: true, line1: true, city: true, pincode: true } },
      items: { select: { id: true, name: true, quantity: true, unitPrice: true, total: true, productId: true } }
    } 
  });
  if (!order) throw new NotFoundError('Order not found');
  return order;
}

export async function cancelOrder(customerId: string, orderId: string, reason?: string) {
  const order = await prisma.order.findFirst({
    where: { id: orderId, customerId, status: { in: ['PLACED', 'CONFIRMED'] } },
    include: { items: true },
  });
  if (!order) throw new ValidationError('Order cannot be cancelled');

  return prisma.$transaction(async (tx) => {
    for (const item of order.items) {
      await tx.inventory.update({
        where: { productId: item.productId },
        data: { stock: { increment: item.quantity } },
      });
    }
    return tx.order.update({
      where: { id: orderId },
      data: { status: 'CANCELLED', cancelledAt: new Date(), cancelReason: reason },
    });
  });
}
// ─── Profile & Addresses ───────────────────────────────────────────────────────
export async function getProfile(customerId: string) {
  return prisma.customer.findUnique({ 
    where: { id: customerId }, 
    select: {
      id: true,
      name: true,
      email: true,
      phone: true,
      avatarUrl: true,
      addresses: { select: { id: true, label: true, line1: true, city: true, pincode: true, isDefault: true } },
      wallet: { select: { balance: true } }
    } 
  });
}

export async function updateProfile(customerId: string, data: { name?: string; email?: string }) {
  const payload: { name?: string; email?: string | null } = {};
  if (data.name !== undefined) payload.name = data.name.trim();
  if (data.email !== undefined) payload.email = data.email.trim() || null;
  return prisma.customer.update({ where: { id: customerId }, data: payload });
}

export async function listAddresses(customerId: string) {
  return prisma.address.findMany({ where: { customerId } });
}

export async function createAddress(
  customerId: string,
  data: {
    label: string;
    line1: string;
    line2?: string | null;
    city: string;
    state: string;
    pincode: string;
    lat?: number | null;
    lng?: number | null;
    isDefault?: boolean;
  }
) {
  if (data.isDefault) {
    await prisma.address.updateMany({ where: { customerId }, data: { isDefault: false } });
  }
  return prisma.address.create({
    data: {
      customerId,
      label: data.label.trim(),
      line1: data.line1.trim(),
      line2: data.line2?.trim() || null,
      city: data.city.trim(),
      state: data.state.trim(),
      pincode: data.pincode.trim(),
      latitude: data.lat ?? null,
      longitude: data.lng ?? null,
      isDefault: data.isDefault ?? false,
    },
  });
}

export async function updateAddress(
  customerId: string,
  addressId: string,
  data: {
    label?: string;
    line1?: string;
    line2?: string | null;
    city?: string;
    state?: string;
    pincode?: string;
    lat?: number | null;
    lng?: number | null;
    isDefault?: boolean;
  }
) {
  const existing = await prisma.address.findFirst({ where: { id: addressId, customerId } });
  if (!existing) throw new NotFoundError('Address not found');
  if (data.isDefault) {
    await prisma.address.updateMany({ where: { customerId }, data: { isDefault: false } });
  }
  return prisma.address.update({
    where: { id: addressId },
    data: {
      ...(data.label !== undefined && { label: data.label.trim() }),
      ...(data.line1 !== undefined && { line1: data.line1.trim() }),
      ...(data.line2 !== undefined && { line2: data.line2?.trim() || null }),
      ...(data.city !== undefined && { city: data.city.trim() }),
      ...(data.state !== undefined && { state: data.state.trim() }),
      ...(data.pincode !== undefined && { pincode: data.pincode.trim() }),
      ...(data.lat !== undefined && { latitude: data.lat }),
      ...(data.lng !== undefined && { longitude: data.lng }),
      ...(data.isDefault !== undefined && { isDefault: data.isDefault }),
    },
  });
}

export async function deleteAddress(customerId: string, addressId: string) {
  const existing = await prisma.address.findFirst({ where: { id: addressId, customerId } });
  if (!existing) throw new NotFoundError('Address not found');
  await prisma.address.delete({ where: { id: addressId } });
}

export async function lookupPincode(pincode: string) {
  try {
    const res = await fetch(`https://api.postalpincode.in/pincode/${pincode}`);
    const data = await res.json() as any[];
    if (data && data[0] && data[0].Status === 'Success' && data[0].PostOffice?.length > 0) {
      const po = data[0].PostOffice[0];
      return { district: po.District, state: po.State };
    }
  } catch (err) {
    // Fallback if API fails
  }
  return { district: 'Unknown', state: 'Tamil Nadu' };
}
// ─── Wishlist ──────────────────────────────────────────────────────────────────
export async function getWishlist(customerId: string) {
  return prisma.wishlist.findMany({ 
    where: { customerId }, 
    select: {
      id: true,
      productId: true,
      product: { 
        select: { 
          id: true, 
          name: true, 
          sellingPrice: true, 
          mrp: true, 
          images: { take: 1, select: { url: true } } 
        } 
      }
    } 
  });
}

export async function addWishlist(customerId: string, productId: string) {
  return prisma.wishlist.upsert({ where: { customerId_productId: { customerId, productId } }, create: { customerId, productId }, update: {} });
}

export async function removeWishlist(customerId: string, productId: string) {
  await prisma.wishlist.deleteMany({ where: { customerId, productId } });
}

// ─── Reviews ───────────────────────────────────────────────────────────────────
export async function createReview(customerId: string, orderId: string, rating: number, comment?: string, productId?: string) {
  const order = await prisma.order.findFirst({ where: { id: orderId, customerId, status: 'DELIVERED' } });
  if (!order) throw new ValidationError('Can only review delivered orders');
  const existing = await prisma.review.findFirst({ where: { orderId, customerId } });
  if (existing) throw new ValidationError('Already reviewed');
  return prisma.review.create({ data: { customerId, orderId, rating, comment, productId, vendorId: order.vendorId } });
}

// ─── Notifications ─────────────────────────────────────────────────────────────
export async function getNotifications(customerId: string) {
  return prisma.notification.findMany({ where: { customerId }, orderBy: { createdAt: 'desc' }, take: 50 });
}

export async function markNotificationRead(customerId: string, id: string) {
  return prisma.notification.updateMany({ where: { id, customerId }, data: { isRead: true } });
}

// ─── Support ───────────────────────────────────────────────────────────────────
export async function createTicket(customerId: string, subject: string, message: string, orderId?: string) {
  return prisma.supportTicket.create({ data: { customerId, subject, message, orderId } });
}

export async function listTickets(customerId: string) {
  return prisma.supportTicket.findMany({ where: { customerId }, orderBy: { createdAt: 'desc' } });
}

export async function getCustomerCoupons(customerId: string) {
  const coupons = await prisma.coupon.findMany({ where: { isActive: true }, take: 20 });
  const used = await prisma.customerCoupon.findMany({ where: { customerId }, select: { couponId: true } });
  const usedIds = new Set(used.map((u) => u.couponId));
  return coupons.map((c) => ({ ...c, alreadyUsed: usedIds.has(c.id) }));
}
// ─── Wallet ────────────────────────────────────────────────────────────────────
export async function getWallet(customerId: string) {
  const wallet = await prisma.wallet.findUnique({ 
    where: { customerId }, 
    select: {
      id: true,
      balance: true,
      transactions: { 
        orderBy: { createdAt: 'desc' }, 
        take: 20,
        select: { id: true, type: true, amount: true, reference: true, description: true, createdAt: true }
      }
    } 
  });
  return wallet ?? { balance: 0, transactions: [] };
}

// ─── Static pages ──────────────────────────────────────────────────────────────
export async function getStaticPage(slug: string) {
  const page = await prisma.staticPage.findUnique({ where: { slug, isActive: true } });
  if (!page) throw new NotFoundError('Page not found');
  return page;
}

// ─── Payment webhook (Razorpay stub) ─────────────────────────────────────────────
export async function handlePaymentWebhook(payload: { reference?: string; razorpayPayId?: string; status?: string }) {
  const { reference, razorpayPayId, status } = payload;
  if (!reference) throw new ValidationError('Missing payment reference');
  const payment = await prisma.payment.findUnique({ where: { reference } });
  if (!payment) throw new NotFoundError('Payment not found');
  if (payment.status === 'PAID') return payment;
  return prisma.payment.update({
    where: { reference },
    data: {
      status: status === 'failed' ? 'FAILED' : 'PAID',
      razorpayPayId: razorpayPayId ?? payment.razorpayPayId,
    },
  });
}
