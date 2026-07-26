const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  const p = await prisma.product.findFirst({ where: { name: 'banana' }, include: { images: true } });
  console.log(JSON.stringify(p.images, null, 2));
}

main().catch(console.error).finally(() => prisma.$disconnect());
