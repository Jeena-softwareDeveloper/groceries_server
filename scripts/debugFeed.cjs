const { PrismaClient } = require('@prisma/client');
const p = new PrismaClient();

async function main() {
  const vendor = await p.vendor.findFirst({ where: { shopName: 'test mart' } });
  console.log('Vendor:', JSON.stringify({
    id: vendor?.id,
    status: vendor?.status,
    isOpen: vendor?.isOpen,
    districtId: vendor?.districtId,
    areaId: vendor?.areaId
  }, null, 2));

  const product = await p.product.findFirst({ where: { name: 'banana' } });
  console.log('Product:', JSON.stringify({
    id: product?.id,
    status: product?.status,
    isActive: product?.isActive,
    vendorId: product?.vendorId
  }, null, 2));

  // Check what districts exist
  const districts = await p.district.findMany({ take: 5 });
  console.log('Districts:', JSON.stringify(districts.map(d => ({ id: d.id, name: d.name, isActive: d.isActive })), null, 2));
}

main().catch(console.error).finally(() => p.$disconnect());
