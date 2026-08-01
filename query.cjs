const { PrismaClient } = require('./node_modules/@prisma/client');
const prisma = new PrismaClient();
async function main() {
  const vendors = await prisma.vendor.findMany({
    select: { id: true, customerId: true, status: true, shopName: true }
  });
  console.log('VENDORS:', vendors);
  const requests = await prisma.vendorRequest.findMany({
    select: { id: true, customerId: true, status: true, shopName: true }
  });
  console.log('REQUESTS:', requests);
}
main().finally(() => prisma.$disconnect());
