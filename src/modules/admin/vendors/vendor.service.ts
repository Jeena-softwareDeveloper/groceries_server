import { prisma } from '../../../lib/prisma.js';
import { NotFoundError, ConflictError, ValidationError } from '../../../utils/errors.js';
import bcrypt from 'bcryptjs';

export async function createVendor(data: { shopName: string, email: string, phone: string, address: string, areaId: string, districtId: string, staffReferralCode?: string, shopCategory?: string }, adminId: string) {
  const existingVendorByEmail = await prisma.vendor.findUnique({ where: { email: data.email } });
  if (existingVendorByEmail) {
    throw new ConflictError('A vendor with this email already exists.');
  }

  // 2. Validate Area and District
  const area = await prisma.area.findFirst({
    where: { id: data.areaId, districtId: data.districtId }
  });
  if (!area) {
    throw new NotFoundError('Selected area does not exist or does not belong to the selected district.');
  }

  // 3. Normalize and validate phone
  const normalizedPhone = data.phone.replace(/\D/g, '').slice(-10);
  if (!/^[6-9]\d{9}$/.test(normalizedPhone)) {
    throw new ValidationError('Enter a valid 10-digit Indian mobile number');
  }

  // 4. Check if vendor with this phone already exists
  const existingVendorByPhone = await prisma.vendor.findFirst({ where: { phone: normalizedPhone } });
  if (existingVendorByPhone) {
    throw new ConflictError('A vendor with this phone number already exists.');
  }

  let customer = await prisma.customer.findUnique({ where: { phone: normalizedPhone } });
  if (customer) {
    const existingVendorByCustomer = await prisma.vendor.findUnique({ where: { customerId: customer.id } });
    if (existingVendorByCustomer) {
      throw new ConflictError('A vendor profile is already associated with this customer phone number.');
    }
    if (!customer.name) {
      customer = await prisma.customer.update({
        where: { id: customer.id },
        data: { name: data.shopName },
      });
    }
  } else {
    customer = await prisma.customer.create({
      data: {
        phone: normalizedPhone,
        name: data.shopName,
        wallet: { create: {} },
      }
    });
  }

  const tempPassword = Math.random().toString(36).slice(-8) + 'V@1';
  const passwordHash = await bcrypt.hash(tempPassword, 10);

  const baseSlug = data.shopName.toLowerCase().replace(/[^a-z0-9]+/g, '-');
  let slug = baseSlug;
  let counter = 1;
  while (await prisma.vendor.findUnique({ where: { slug } })) {
    slug = `${baseSlug}-${counter++}`;
  }

  let vendorCode = `VND-${Math.random().toString(36).substring(2, 6).toUpperCase()}`;
  while (await prisma.vendor.findUnique({ where: { code: vendorCode } })) {
    vendorCode = `VND-${Math.random().toString(36).substring(2, 6).toUpperCase()}`;
  }

  let linkedStaffId: string | null = null;
  if (data.staffReferralCode && data.staffReferralCode.trim()) {
    const staff = await prisma.staff.findFirst({
      where: {
        OR: [
          { code: data.staffReferralCode.trim().toUpperCase() },
          { name: data.staffReferralCode.trim() },
        ]
      }
    });
    if (staff) linkedStaffId = staff.id;
  }

  const { shopCategory, ...vendorCreateData } = data;

  const vendor = await prisma.vendor.create({
    data: {
      ...vendorCreateData,
      shopCategory: shopCategory || null,
      phone: normalizedPhone,
      passwordHash,
      slug,
      code: vendorCode,
      status: 'APPROVED',
      approvedAt: new Date(),
      approvedBy: adminId,
      customerId: customer.id,
      staffReferralCode: data.staffReferralCode || null,
      staffId: linkedStaffId,
    }
  });

  if (linkedStaffId) {
    await prisma.staffAuditLog.create({
      data: {
        staffId: linkedStaffId,
        action: 'VENDOR_ONBOARDED',
        platform: 'Admin',
        metadata: JSON.stringify({ vendorId: vendor.id, shopName: vendor.shopName })
      }
    }).catch(() => {});
  }

  // Ensure linked VendorRequest exists and is marked APPROVED for the mobile app
  const existingRequest = await prisma.vendorRequest.findFirst({
    where: { customerId: customer.id },
    orderBy: { createdAt: 'desc' }
  });

  if (existingRequest) {
    await prisma.vendorRequest.update({
      where: { id: existingRequest.id },
      data: {
        status: 'APPROVED',
        shopName: data.shopName,
        shopCategory: shopCategory || existingRequest.shopCategory || null,
        mobileNumber: normalizedPhone,
        email: data.email,
        address: data.address,
        districtId: data.districtId,
        areaId: data.areaId,
        staffReferralCode: data.staffReferralCode || existingRequest.staffReferralCode || null,
        reviewedBy: adminId,
        reviewedAt: new Date(),
        submittedAt: existingRequest.submittedAt || new Date(),
      }
    });
  } else {
    await prisma.vendorRequest.create({
      data: {
        customerId: customer.id,
        status: 'APPROVED',
        shopName: data.shopName,
        shopCategory: shopCategory || null,
        mobileNumber: normalizedPhone,
        email: data.email,
        address: data.address,
        districtId: data.districtId,
        areaId: data.areaId,
        staffReferralCode: data.staffReferralCode || null,
        reviewedBy: adminId,
        reviewedAt: new Date(),
        submittedAt: new Date(),
      }
    });
  }

  return { vendor: { ...vendor, shopCategory: shopCategory || null }, tempPassword };
}
export async function listVendors(status?: string, page = 1, limit = 20) {
  const skip = (page - 1) * limit;
  const where = status ? { status: status as 'PENDING' | 'APPROVED' | 'REJECTED' | 'SUSPENDED' } : {};
  const [items, total] = await Promise.all([
    prisma.vendor.findMany({
      where,
      skip,
      take: limit,
      orderBy: { createdAt: 'desc' },
      include: { 
        area: { include: { district: true } },
        referredByStaff: { select: { id: true, name: true, code: true } },
        _count: { select: { products: true } },
        orders: { where: { status: { notIn: ['CANCELLED', 'RETURNED'] } }, select: { grandTotal: true } }
      },
    }),
    prisma.vendor.count({ where }),
  ]);

  const customerIds = items.map((item: any) => item.customerId).filter(Boolean) as string[];
  const requests = customerIds.length > 0
    ? await prisma.vendorRequest.findMany({
        where: { customerId: { in: customerIds } },
        orderBy: { createdAt: 'desc' },
        select: { customerId: true, shopCategory: true, ownerName: true },
      })
    : [];
  const reqMap = new Map<string, any>();
  for (const r of requests) {
    if (!reqMap.has(r.customerId)) {
      reqMap.set(r.customerId, r);
    }
  }

  const mappedItems = items.map((item: any) => {
    const turnover = item.orders.reduce((sum: number, order: any) => sum + Number(order.grandTotal || 0), 0);
    const { orders, _count, ...rest } = item;
    const req = item.customerId ? reqMap.get(item.customerId) : null;
    return {
      ...rest,
      shopCategory: item.shopCategory || req?.shopCategory || null,
      ownerName: req?.ownerName || null,
      productsCount: _count?.products || 0,
      turnover
    };
  });

  return { items: mappedItems, total, page, limit };
}

export async function getVendor(id: string) {
  const vendor = await prisma.vendor.findUnique({
    where: { id },
    include: { area: { include: { district: true } }, staff: true },
  });
  if (!vendor) throw new NotFoundError('Vendor not found');

  let shopCategory = vendor.shopCategory || null;
  let ownerName = null;
  if (vendor.customerId) {
    const req = await prisma.vendorRequest.findFirst({
      where: { customerId: vendor.customerId },
      orderBy: { createdAt: 'desc' },
      select: { shopCategory: true, ownerName: true },
    });
    if (req) {
      if (!shopCategory) shopCategory = req.shopCategory;
      ownerName = req.ownerName;
    }
  }

  return { ...vendor, shopCategory, ownerName };
}

export async function updateVendor(id: string, data: any) {
  const vendor = await getVendor(id);
  
  const fieldMap: Record<string, string> = {
    ownerName: 'ownerName',
    mobileNumber: 'phone',
    accountNumber: 'bankAccountNo',
    ifscCode: 'bankIfsc',
    // Frontend sends 'bankName' but schema field is 'bankHolderName'
    bankName: 'bankHolderName',
    accountHolderName: 'bankHolderName',
    // Frontend may send alternate cert/doc URL names
    fssaiCertUrl: 'fssaiDocUrl',
    gstCertUrl: 'gstDocUrl',
  };

  const updatableFields = [
    'shopName', 'shopCategory', 'email', 'phone', 'description', 'address',
    'areaId', 'districtId', 'deliveryRadius', 'minOrderValue',
    'gstNumber', 'fssaiNumber', 'bankHolderName',
    'bankAccountNo', 'bankIfsc', 'logoUrl', 'bannerUrl',
    'fssaiDocUrl', 'gstDocUrl',
    'latitude', 'longitude', 'isOpen', 'operatingHours',
    'staffReferralCode',
  ];

  
  const updateData: any = {};

  for (const [inputKey, value] of Object.entries(data)) {
    const schemaKey = fieldMap[inputKey] ?? inputKey;
    if (updatableFields.includes(schemaKey) && value !== undefined) {
      updateData[schemaKey] = value;
    }
  }

  const updatedVendor = await prisma.vendor.update({
    where: { id },
    data: updateData,
  });

  // Sync category and ownerName with linked VendorRequest & Customer
  if (vendor.customerId) {
    if (data.ownerName) {
      await prisma.customer.update({
        where: { id: vendor.customerId },
        data: { name: data.ownerName },
      }).catch(() => null);
    }
    const req = await prisma.vendorRequest.findFirst({
      where: { customerId: vendor.customerId },
      orderBy: { createdAt: 'desc' }
    });
    if (req) {
      await prisma.vendorRequest.update({
        where: { id: req.id },
        data: {
          ...(data.shopCategory !== undefined ? { shopCategory: data.shopCategory } : {}),
          ...(data.ownerName !== undefined ? { ownerName: data.ownerName } : {}),
          ...(data.shopName !== undefined ? { shopName: data.shopName } : {}),
        }
      }).catch(() => null);
    } else {
      await prisma.vendorRequest.create({
        data: {
          customerId: vendor.customerId,
          status: 'APPROVED',
          shopName: data.shopName || vendor.shopName,
          shopCategory: data.shopCategory || null,
          ownerName: data.ownerName || null,
          mobileNumber: data.phone || data.mobileNumber || vendor.phone,
          email: data.email || vendor.email,
          address: data.address || vendor.address,
          districtId: data.districtId || vendor.districtId,
          areaId: data.areaId || vendor.areaId,
        }
      }).catch(() => null);
    }
  }

  return { ...updatedVendor, shopCategory: data.shopCategory ?? (vendor as any).shopCategory };
}

export async function approveVendor(id: string, adminId: string) {
  await getVendor(id);
  return prisma.vendor.update({
    where: { id },
    data: { status: 'APPROVED', approvedAt: new Date(), approvedBy: adminId, rejectionReason: null },
  });
}

export async function rejectVendor(id: string, reason: string) {
  await getVendor(id);
  return prisma.vendor.update({
    where: { id },
    data: { status: 'REJECTED', rejectionReason: reason },
  });
}

export async function suspendVendor(id: string) {
  await getVendor(id);
  return prisma.vendor.update({ where: { id }, data: { status: 'SUSPENDED' } });
}

export async function removeVendor(id: string) {
  const vendor = await getVendor(id);
  try {
    const deleted = await prisma.vendor.delete({ where: { id } });

    // Reset the linked vendorRequest so the customer can re-apply from the app
    if (vendor.customerId) {
      await prisma.vendorRequest.updateMany({
        where: { customerId: vendor.customerId, status: 'APPROVED' },
        data: { status: 'REJECTED', rejectionReason: 'Vendor account was removed by admin.' },
      });
    }

    return deleted;
  } catch (error: any) {
    if (error.code === 'P2003') {
      throw new ConflictError('Cannot delete this vendor because they have associated records (e.g., orders, products). Please suspend them instead.');
    }
    throw error;
  }
}
