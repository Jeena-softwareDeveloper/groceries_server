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
      district: { select: { id: true, name: true } },
      area: { select: { id: true, name: true } },
      referredVendors: {
        select: {
          id: true,
          shopName: true,
          phone: true,
          code: true,
          status: true,
          createdAt: true,
          area: { select: { name: true } },
        },
        orderBy: { createdAt: 'desc' },
      },
      _count: { select: { referredVendors: true } },
    },
  });

  if (!staff) throw new NotFoundError('Staff not found');
  return { ...staff, vendorsCount: staff._count?.referredVendors || 0 };
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
