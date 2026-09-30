import { prisma } from '../../../lib/prisma.js';
import { NotFoundError, ConflictError, ValidationError } from '../../../utils/errors.js';

export async function listStaffs(search?: string, isActive?: boolean, page = 1, limit = 50) {
  const skip = (page - 1) * limit;
  const where: any = {};

  if (isActive !== undefined) {
    where.isActive = isActive;
  }

  if (search && search.trim()) {
    const q = search.trim();
    where.OR = [
      { name: { contains: q } },
      { phone: { contains: q } },
      { code: { contains: q } },
      { designation: { contains: q } },
      { email: { contains: q } },
    ];
  }

  const [items, total] = await Promise.all([
    prisma.staff.findMany({
      where,
      skip,
      take: limit,
      orderBy: { createdAt: 'desc' },
      include: {
        district: { select: { id: true, name: true } },
        area: { select: { id: true, name: true } },
        _count: { select: { referredVendors: true } },
      },
    }),
    prisma.staff.count({ where }),
  ]);

  const mapped = items.map(s => ({
    ...s,
    vendorsCount: s._count?.referredVendors || 0,
  }));

  return { items: mapped, total, page, limit };
}

export async function getStaff(id: string) {
  const staff = await prisma.staff.findUnique({
    where: { id },
    include: {
      district: { select: { id: true, name: true, code: true } },
      area: { select: { id: true, name: true, pincode: true } },
      referredVendors: {
        select: {
          id: true,
          shopName: true,
          phone: true,
          email: true,
          code: true,
          slug: true,
          status: true,
          address: true,
          latitude: true,
          longitude: true,
          deliveryRadius: true,
          rating: true,
          fssaiNumber: true,
          gstNumber: true,
          createdAt: true,
          area: { select: { id: true, name: true } },
          district: { select: { id: true, name: true } },
        },
        orderBy: { createdAt: 'desc' },
      },
      referredCustomers: {
        select: {
          id: true,
          name: true,
          phone: true,
          email: true,
          createdAt: true,
          isBlocked: true,
          currentLocation: true,
          _count: { select: { orders: true } },
          addresses: { select: { id: true, label: true, line1: true, line2: true, city: true, pincode: true, isDefault: true }, take: 2 },
        },
        orderBy: { createdAt: 'desc' },
      },
      auditLogs: {
        orderBy: { createdAt: 'desc' },
        take: 100,
      },
      _count: {
        select: {
          referredVendors: true,
          referredCustomers: true,
          auditLogs: true,
        },
      },
    },
  });

  if (!staff) throw new NotFoundError('Staff not found');

  const qrScans = await prisma.staffAuditLog.count({ where: { staffId: id, action: 'QR_SCAN' } });
  const linkClicks = await prisma.staffAuditLog.count({ where: { staffId: id, action: 'LINK_CLICK' } });
  const appInstalls = await prisma.staffAuditLog.count({ where: { staffId: id, action: 'APP_INSTALL' } });
  const totalVisitors = qrScans + linkClicks;
  const totalConversions = staff._count.referredVendors + staff._count.referredCustomers;
  const conversionRate = totalVisitors > 0 ? Number(((totalConversions / totalVisitors) * 100).toFixed(1)) : 0;

  const mappedCustomers = staff.referredCustomers.map(c => ({
    id: c.id,
    name: c.name || 'Customer (' + c.phone.slice(-4) + ')',
    phone: c.phone,
    email: c.email || 'N/A',
    createdAt: c.createdAt,
    isBlocked: c.isBlocked,
    ordersCount: c._count.orders,
    currentLocation: c.currentLocation,
    addresses: c.addresses.map(a => ({
      id: a.id,
      label: a.label,
      line1: a.line1,
      line2: a.line2,
      city: a.city,
      pincode: a.pincode,
      isDefault: a.isDefault,
    })),
  }));

  return {
    ...staff,
    referredCustomers: mappedCustomers,
    vendorsCount: staff._count.referredVendors,
    customersCount: staff._count.referredCustomers,
    analytics: {
      totalScans: qrScans,
      totalClicks: linkClicks,
      totalInstalls: appInstalls,
      totalVisitors,
      totalVendors: staff._count.referredVendors,
      totalCustomers: staff._count.referredCustomers,
      conversionRate,
    },
  };
}

export async function recordStaffAudit(staffCodeOrId: string, data: {
  action: 'QR_SCAN' | 'LINK_CLICK' | 'APP_INSTALL' | 'VENDOR_ONBOARDED' | 'CUSTOMER_ONBOARDED';
  platform?: string;
  deviceInfo?: string;
  ipAddress?: string;
  metadata?: any;
}) {
  const staff = await prisma.staff.findFirst({
    where: {
      OR: [
        { id: staffCodeOrId },
        { code: staffCodeOrId.toUpperCase() },
      ],
    },
  });

  if (!staff) throw new NotFoundError('Staff member not found');

  return prisma.staffAuditLog.create({
    data: {
      staffId: staff.id,
      action: data.action,
      platform: data.platform || 'Android',
      deviceInfo: data.deviceInfo || 'Mobile Browser',
      ipAddress: data.ipAddress || '127.0.0.1',
      metadata: typeof data.metadata === 'object' ? JSON.stringify(data.metadata) : data.metadata,
    },
  });
}

export async function createStaff(data: {
  name: string;
  phone: string;
  email?: string;
  designation?: string;
  districtId?: string;
  areaId?: string;
  code?: string;
}) {
  const normalizedPhone = data.phone.replace(/\D/g, '').slice(-10);
  if (!/^[6-9]\d{9}$/.test(normalizedPhone)) {
    throw new ValidationError('Enter a valid 10-digit Indian mobile number');
  }

  // Check phone uniqueness
  const existingByPhone = await prisma.staff.findUnique({ where: { phone: normalizedPhone } });
  if (existingByPhone) {
    throw new ConflictError('A staff member with this phone number already exists.');
  }

  // Code generation or validation
  let staffCode = (data.code || '').trim().toUpperCase();
  if (staffCode) {
    const existingByCode = await prisma.staff.findUnique({ where: { code: staffCode } });
    if (existingByCode) {
      throw new ConflictError('Staff code already taken. Please use a different code.');
    }
  } else {
    // Generate STF-XXXX
    let counter = (await prisma.staff.count()) + 1;
    staffCode = `STF-${String(counter).padStart(3, '0')}`;
    while (await prisma.staff.findUnique({ where: { code: staffCode } })) {
      counter++;
      staffCode = `STF-${String(counter).padStart(3, '0')}`;
    }
  }

  if (data.email && data.email.trim()) {
    const existingByEmail = await prisma.staff.findFirst({ where: { email: data.email.trim() } });
    if (existingByEmail) {
      throw new ConflictError('A staff member with this email already exists.');
    }
  }

  const staff = await prisma.staff.create({
    data: {
      name: data.name.trim(),
      phone: normalizedPhone,
      email: data.email?.trim() || null,
      designation: data.designation?.trim() || 'Field Marketing Executive',
      code: staffCode,
      districtId: data.districtId || null,
      areaId: data.areaId || null,
      isActive: true,
    },
    include: {
      district: { select: { id: true, name: true } },
      area: { select: { id: true, name: true } },
      _count: { select: { referredVendors: true } },
    },
  });

  return { ...staff, vendorsCount: 0 };
}

export async function updateStaff(id: string, data: {
  name?: string;
  phone?: string;
  email?: string;
  designation?: string;
  districtId?: string;
  areaId?: string;
  code?: string;
  isActive?: boolean;
}) {
  const existing = await prisma.staff.findUnique({ where: { id } });
  if (!existing) throw new NotFoundError('Staff not found');

  const updateData: any = {};
  if (data.name !== undefined) updateData.name = data.name.trim();
  if (data.designation !== undefined) updateData.designation = data.designation.trim();
  if (data.districtId !== undefined) updateData.districtId = data.districtId || null;
  if (data.areaId !== undefined) updateData.areaId = data.areaId || null;
  if (data.isActive !== undefined) updateData.isActive = Boolean(data.isActive);

  if (data.phone && data.phone !== existing.phone) {
    const normalizedPhone = data.phone.replace(/\D/g, '').slice(-10);
    if (!/^[6-9]\d{9}$/.test(normalizedPhone)) {
      throw new ValidationError('Enter a valid 10-digit Indian mobile number');
    }
    const phoneExists = await prisma.staff.findUnique({ where: { phone: normalizedPhone } });
    if (phoneExists && phoneExists.id !== id) {
      throw new ConflictError('Phone number already in use by another staff.');
    }
    updateData.phone = normalizedPhone;
  }

  if (data.code && data.code.trim().toUpperCase() !== existing.code) {
    const newCode = data.code.trim().toUpperCase();
    const codeExists = await prisma.staff.findUnique({ where: { code: newCode } });
    if (codeExists && codeExists.id !== id) {
      throw new ConflictError('Staff code already in use.');
    }
    updateData.code = newCode;
  }

  if (data.email !== undefined) {
    const emailVal = data.email?.trim() || null;
    if (emailVal && emailVal !== existing.email) {
      const emailExists = await prisma.staff.findFirst({ where: { email: emailVal } });
      if (emailExists && emailExists.id !== id) {
        throw new ConflictError('Email already in use by another staff.');
      }
    }
    updateData.email = emailVal;
  }

  return prisma.staff.update({
    where: { id },
    data: updateData,
    include: {
      district: { select: { id: true, name: true } },
      area: { select: { id: true, name: true } },
      _count: { select: { referredVendors: true } },
    },
  });
}

export async function deleteStaff(id: string) {
  const staff = await prisma.staff.findUnique({
    where: { id },
    include: { _count: { select: { referredVendors: true } } },
  });
  if (!staff) throw new NotFoundError('Staff not found');

  // If staff has referred vendors, soft delete by deactivating to preserve audit trail
  if (staff._count.referredVendors > 0) {
    return prisma.staff.update({
      where: { id },
      data: { isActive: false },
    });
  }

  return prisma.staff.delete({ where: { id } });
}
