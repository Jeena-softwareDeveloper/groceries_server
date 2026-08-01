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
  
  // Clean up data to only include valid updatable fields
  const updatableFields = [
    'shopName', 'ownerName', 'email', 'mobileNumber', 'shopCategory',
    'description', 'address', 'areaId', 'districtId', 'deliveryRadius',
    'gstNumber', 'fssaiNumber', 'bankName', 'accountHolderName', 
    'accountNumber', 'ifscCode', 'upiId', 'logoUrl', 'bannerUrl',
    'ownerPhotoUrl', 'govtIdUrl', 'gstCertUrl', 'fssaiCertUrl'
  ];
  
  const updateData: any = {};
  for (const key of updatableFields) {
    if (data[key] !== undefined) {
      updateData[key] = data[key];
    }
  }

  // Handle phone separately if needed, since schema might use `phone` instead of `mobileNumber`
  if (data.mobileNumber !== undefined) updateData.phone = data.mobileNumber;

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
