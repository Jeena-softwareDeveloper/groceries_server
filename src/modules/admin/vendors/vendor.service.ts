import { prisma } from '../../../lib/prisma.js';
import { NotFoundError } from '../../../utils/errors.js';

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
        _count: { select: { products: true } },
        orders: { where: { status: { notIn: ['CANCELLED', 'RETURNED'] } }, select: { grandTotal: true } }
      },
    }),
    prisma.vendor.count({ where }),
  ]);
  const mappedItems = items.map((item: any) => {
    const turnover = item.orders.reduce((sum: number, order: any) => sum + Number(order.grandTotal || 0), 0);
    const { orders, _count, ...rest } = item;
    return {
      ...rest,
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
  return vendor;
}

export async function updateVendor(id: string, data: any) {
  await getVendor(id);
  
  const fieldMap: Record<string, string> = {
    ownerName: 'ownerName',
    mobileNumber: 'phone',
    accountNumber: 'bankAccountNo',
    ifscCode: 'bankIfsc',
  };

  const updatableFields = [
    'shopName', 'email', 'phone', 'description', 'address',
    'areaId', 'districtId', 'deliveryRadius', 'minOrderValue',
    'gstNumber', 'fssaiNumber', 'bankName', 'accountHolderName',
    'bankAccountNo', 'bankIfsc', 'upiId', 'logoUrl', 'bannerUrl',
    'ownerPhotoUrl', 'govtIdUrl', 'gstCertUrl', 'fssaiCertUrl',
    'latitude', 'longitude', 'isOpen', 'operatingHours',
  ];
  
  const updateData: any = {};

  for (const [inputKey, value] of Object.entries(data)) {
    const schemaKey = fieldMap[inputKey] ?? inputKey;
    if (updatableFields.includes(schemaKey) && value !== undefined) {
      updateData[schemaKey] = value;
    }
  }

  return prisma.vendor.update({
    where: { id },
    data: updateData,
  });
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
  await getVendor(id);
  return prisma.vendor.delete({ where: { id } });
}
