const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  const districts = await prisma.district.findMany({ include: { areas: true } });
  for (const d of districts) {
    if (d.areas.length === 0) {
      console.log(`Creating default area for ${d.name}...`);
      await prisma.area.create({
        data: {
          name: `${d.name} Main Area`,
          districtId: d.id,
          isActive: true
        }
      });
    }
  }
  console.log('Done ensuring all districts have at least one area.');
}

main().catch(console.error).finally(() => prisma.$disconnect());
