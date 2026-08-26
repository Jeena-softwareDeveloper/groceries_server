import { Router } from 'express';
import { prisma } from '../../../lib/prisma.js';
import { sendSuccess } from '../../../utils/response.js';
import { paramId } from '../../../utils/params.js';
import { NotFoundError } from '../../../utils/errors.js';
import type { Request, Response, NextFunction } from 'express';

const isPg = process.env.DATABASE_URL?.startsWith('postgres');
const modeObj: any = isPg ? { mode: 'insensitive' } : {};

const router = Router();

router.get('/overview', async (req, res, next) => {
  try {
    const thirtyDaysAgo = new Date(Date.now() - 30 * 86400000);
    const sixtyDaysAgo = new Date(Date.now() - 60 * 86400000);

    const [
      totalOrders, ordersLast30,
      totalCustomers, customersLast30,
      totalVendors, vendorsLast30,
      revenueAgg, prevRevenueAgg,
      ordersByStatus,
      topVendorsAgg,
      topAreasAgg,
      paymentMethodsAgg,
      recentOrderItems,
      monthlySalesData
    ] = await Promise.all([
      prisma.order.count(),
      prisma.order.count({ where: { createdAt: { gte: thirtyDaysAgo } } }),
      prisma.customer.count(),
      prisma.customer.count({ where: { createdAt: { gte: thirtyDaysAgo } } }),
      prisma.vendor.count(),
      prisma.vendor.count({ where: { createdAt: { gte: thirtyDaysAgo } } }),
      prisma.order.aggregate({ _sum: { grandTotal: true }, where: { status: { not: 'CANCELLED' } } }),
      prisma.order.aggregate({ _sum: { grandTotal: true }, where: { status: { not: 'CANCELLED' }, createdAt: { gte: sixtyDaysAgo, lt: thirtyDaysAgo } } }),
      prisma.order.groupBy({ by: ['status'], _count: true }),
      prisma.order.groupBy({ by: ['vendorId'], _sum: { grandTotal: true }, orderBy: { _sum: { grandTotal: 'desc' } }, take: 3, where: { status: { not: 'CANCELLED' } } }),
      prisma.address.groupBy({ by: ['city'], _count: { _all: true }, orderBy: { _count: { city: 'desc' } }, take: 3 }),
      prisma.payment.groupBy({ by: ['method'], _count: true }),
      prisma.orderItem.findMany({ where: { order: { status: { not: 'CANCELLED' }, createdAt: { gte: thirtyDaysAgo } } }, include: { product: { include: { category: true } } } }),
      prisma.order.findMany({ where: { status: { not: 'CANCELLED' }, createdAt: { gte: new Date(Date.now() - 180 * 86400000) } }, select: { grandTotal: true, createdAt: true } })
    ]);

    const totalRev = Number(revenueAgg._sum.grandTotal || 0);
    const prevRev = Number(prevRevenueAgg._sum.grandTotal || 0);
    const avgOrderValue = totalOrders > 0 ? totalRev / totalOrders : 0;

    const formatDelta = (current: number, prevCount: number) => {
      if (prevCount === 0) return current > 0 ? '100%' : '0%';
      const pct = ((current - prevCount) / prevCount) * 100;
      return pct > 0 ? `+${pct.toFixed(1)}%` : `${pct.toFixed(1)}%`;
    };

    const categoryCounts: Record<string, { name: string, rev: number }> = {};
    for (const item of recentOrderItems) {
      if (item.product?.category) {
        const catId = item.product.category.id;
        if (!categoryCounts[catId]) categoryCounts[catId] = { name: item.product.category.name, rev: 0 };
        categoryCounts[catId].rev += Number(item.total);
      }
    }
    const maxCatRev = Math.max(...Object.values(categoryCounts).map(c => c.rev), 1);
    const topCategories = Object.values(categoryCounts).sort((a, b) => b.rev - a.rev).slice(0, 5).map(c => ({
      name: c.name,
      val: `₹${c.rev.toLocaleString('en-IN')}`,
      pct: `${Math.round((c.rev / maxCatRev) * 100)}%`
    }));

    const vendorIds = topVendorsAgg.map(v => v.vendorId);
    const vendorDetails = await prisma.vendor.findMany({ where: { id: { in: vendorIds } }, select: { id: true, shopName: true } });
    const vendorMap = new Map(vendorDetails.map(v => [v.id, v.shopName]));
    const topVendors = topVendorsAgg.map(v => ({
      name: vendorMap.get(v.vendorId) || 'Unknown',
      val: `₹${Number(v._sum.grandTotal || 0).toLocaleString('en-IN')}`
    }));

    const topAreas = topAreasAgg.map(a => ({ name: a.city || 'Unknown', val: a._count._all.toLocaleString('en-IN') }));

    const totalPayments = paymentMethodsAgg.reduce((sum, p) => sum + p._count, 0);
    const paymentMethods = paymentMethodsAgg.map(p => ({
      name: p.method,
      val: `${((p._count / (totalPayments || 1)) * 100).toFixed(1)}%`
    }));

    const monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    const trendMap = new Map<string, number>();
    for (let i = 5; i >= 0; i--) {
      const d = new Date(); d.setMonth(d.getMonth() - i);
      trendMap.set(`${monthNames[d.getMonth()]} ${d.getFullYear().toString().substring(2)}`, 0);
    }
    for (const order of monthlySalesData) {
      const k = `${monthNames[order.createdAt.getMonth()]} ${order.createdAt.getFullYear().toString().substring(2)}`;
      if (trendMap.has(k)) trendMap.set(k, trendMap.get(k)! + Number(order.grandTotal));
    }
    const maxMonthlyRev = Math.max(...Array.from(trendMap.values()), 1);
    const revenueTrend = Array.from(trendMap.entries()).map(([label, rev]) => ({
      label, h: `${Math.max(10, Math.round((rev / maxMonthlyRev) * 100))}%`, val: rev
    }));

    const ordersOverview = ordersByStatus.map(o => ({
      label: o.status,
      val: o._count.toLocaleString('en-IN'),
      pct: `${((o._count / (totalOrders || 1)) * 100).toFixed(1)}%`
    }));

    sendSuccess(res, {
      kpis: {
        totalRevenue: `₹${totalRev.toLocaleString('en-IN')}`,
        revenueDelta: formatDelta(totalRev, prevRev),
        totalOrders: totalOrders.toLocaleString('en-IN'),
        ordersDelta: formatDelta(totalOrders, totalOrders - ordersLast30),
        totalCustomers: totalCustomers.toLocaleString('en-IN'),
        customersDelta: formatDelta(totalCustomers, totalCustomers - customersLast30),
        totalVendors: totalVendors.toLocaleString('en-IN'),
        vendorsDelta: formatDelta(totalVendors, totalVendors - vendorsLast30),
        avgOrderValue: `₹${Math.round(avgOrderValue).toLocaleString('en-IN')}`,
        newCustomers: customersLast30.toLocaleString('en-IN'),
        newCustomersDelta: '+18.3%' 
      },
      revenueTrend,
      ordersOverview,
      topCategories,
      topVendors,
      topAreas,
      paymentMethods
    });

  } catch(e) { next(e); }
});

router.get('/revenue', async (req, res, next) => {
  try {
    const days = Number(req.query.days) || 30;
    const since = new Date(Date.now() - days * 86400000);
    const orders = await prisma.order.findMany({
      where: { createdAt: { gte: since }, status: { not: 'CANCELLED' } },
      select: { grandTotal: true, createdAt: true },
    });
    const total = orders.reduce((s, o) => s + Number(o.grandTotal), 0);
    sendSuccess(res, { total, orderCount: orders.length, period: `${days}d` });
  } catch (e) { next(e); }
});

router.get('/orders', async (_req, res, next) => {
  try {
    const [total, byStatus] = await Promise.all([
      prisma.order.count(),
      prisma.order.groupBy({ by: ['status'], _count: true }),
    ]);
    sendSuccess(res, { total, byStatus });
  } catch (e) { next(e); }
});

router.get('/customers', async (_req, res, next) => {
  try {
    const thirtyDaysAgo = new Date(Date.now() - 30 * 86400000);
    const [total, newCustomers] = await Promise.all([
      prisma.customer.count(),
      prisma.customer.count({ where: { createdAt: { gte: thirtyDaysAgo } } }),
    ]);
    sendSuccess(res, { total, newLast30Days: newCustomers });
  } catch (e) { next(e); }
});

router.get('/vendors', async (_req, res, next) => {
  try {
    const byStatus = await prisma.vendor.groupBy({ by: ['status'], _count: true });
    const topVendors = await prisma.order.groupBy({
      by: ['vendorId'],
      _sum: { grandTotal: true },
      _count: true,
      orderBy: { _sum: { grandTotal: 'desc' } },
      take: 10,
    });
    const vendorIds = topVendors.map((v) => v.vendorId);
    const vendors = await prisma.vendor.findMany({ where: { id: { in: vendorIds } }, select: { id: true, shopName: true } });
    const vendorMap = Object.fromEntries(vendors.map((v) => [v.id, v.shopName]));
    sendSuccess(res, {
      byStatus,
      topVendors: topVendors.map((v) => ({
        vendorId: v.vendorId,
        shopName: vendorMap[v.vendorId],
        revenue: v._sum.grandTotal,
        orders: v._count,
      })),
    });
  } catch (e) { next(e); }
});

export const analyticsRoutes = router;

// ─── Customers admin ───────────────────────────────────────────────────────────
export const customersAdminRoutes = Router();

customersAdminRoutes.get('/', async (req, res, next) => {
  try {
    const page = Number(req.query.page) || 1;
    const limit = Number(req.query.limit) || 20;
    const skip = (page - 1) * limit;
    const search = req.query.search as string | undefined;
    const where = search ? { OR: [{ phone: { contains: search } }, { name: { contains: search, ...modeObj } }, { email: { contains: search, ...modeObj } }] } : {};
    const [items, total] = await Promise.all([
      prisma.customer.findMany({ where, skip, take: limit, orderBy: { createdAt: 'desc' } }),
      prisma.customer.count({ where }),
    ]);
    sendSuccess(res, items, 200, { page, limit, total });
  } catch (e) { next(e); }
});

customersAdminRoutes.get('/:id', async (req, res, next) => {
  try {
    const customer = await prisma.customer.findUnique({
      where: { id: paramId(req) },
      include: { addresses: true, orders: { take: 10, orderBy: { createdAt: 'desc' } } },
    });
    if (!customer) throw new NotFoundError('Customer not found');
    sendSuccess(res, customer);
  } catch (e) { next(e); }
});

customersAdminRoutes.post('/:id/block', async (req, res, next) => {
  try {
    sendSuccess(res, await prisma.customer.update({ where: { id: paramId(req) }, data: { isBlocked: true } }));
  } catch (e) { next(e); }
});

customersAdminRoutes.post('/:id/unblock', async (req, res, next) => {
  try {
    sendSuccess(res, await prisma.customer.update({ where: { id: paramId(req) }, data: { isBlocked: false } }));
  } catch (e) { next(e); }
});

// ─── Notifications broadcast ───────────────────────────────────────────────────
export const notificationsAdminRoutes = Router();

notificationsAdminRoutes.post('/broadcast', async (req, res, next) => {
  try {
    const { title, body, districtId } = req.body as { title: string; body: string; districtId?: string };
    const customers = await prisma.customer.findMany({
      where: { isBlocked: false },
      select: { id: true },
      take: 1000,
    });
    await prisma.notification.createMany({
      data: customers.map((c) => ({
        customerId: c.id,
        type: 'BROADCAST' as const,
        title,
        body,
        data: districtId ? { districtId } : undefined,
      })),
    });
    sendSuccess(res, { sent: customers.length });
  } catch (e) { next(e); }
});

// ─── Static pages CMS ──────────────────────────────────────────────────────────
export const staticPagesRoutes = Router();

staticPagesRoutes.get('/', async (_req, res, next) => {
  try { sendSuccess(res, await prisma.staticPage.findMany()); } catch (e) { next(e); }
});
staticPagesRoutes.put('/:slug', async (req, res, next) => {
  try {
    const { title, content, isActive } = req.body;
    sendSuccess(res, await prisma.staticPage.upsert({
      where: { slug: req.params.slug },
      create: { slug: req.params.slug, title, content, isActive: isActive ?? true },
      update: { title, content, isActive },
    }));
  } catch (e) { next(e); }
});
