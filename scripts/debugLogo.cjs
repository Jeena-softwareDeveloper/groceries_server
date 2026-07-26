const { PrismaClient } = require('@prisma/client');
const p = new PrismaClient();
async function main() {
  const v = await p.vendor.findFirst({ where: { shopName: 'test mart' }, select: { logoUrl: true, bannerUrl: true } });
  console.log('logoUrl:', v?.logoUrl);
  console.log('bannerUrl:', v?.bannerUrl);
}
main().catch(console.error).finally(() => p.$disconnect());
