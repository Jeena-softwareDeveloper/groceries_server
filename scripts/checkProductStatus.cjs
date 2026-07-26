const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  const p = await prisma.product.findFirst({ where: { name: 'banana' } });
  const a = await prisma.productApproval.findMany({ where: { productId: p.id } });
  console.log('Product status:', p.status);
  console.log('Approvals:', a.map(x => x.status));
}

main().catch(console.error).finally(() => prisma.$disconnect());
