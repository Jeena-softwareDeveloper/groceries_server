import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  const vendors = await prisma.vendor.findMany({
    where: { code: null }
  });

  for (const vendor of vendors) {
    const code = `VND-${Math.random().toString(36).substring(2, 6).toUpperCase()}`;
    await prisma.vendor.update({
      where: { id: vendor.id },
      data: { code }
    });
    console.log(`Updated vendor ${vendor.shopName} with code ${code}`);
  }
}

main().catch(console.error).finally(() => prisma.$disconnect());
