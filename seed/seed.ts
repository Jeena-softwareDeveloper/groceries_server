import { PrismaClient } from '@prisma/client';
import bcrypt from 'bcryptjs';

const prisma = new PrismaClient();

async function main() {
  console.log('Seeding database...');

  // 1. SuperAdmin
  const adminEmail = 'admin@alltimemarket.com';
  const adminPassword = await bcrypt.hash('Admin@123', 12);
  const admin = await prisma.superAdmin.upsert({
    where: { email: adminEmail },
    update: { passwordHash: adminPassword },
    create: { email: adminEmail, name: 'Super Admin', passwordHash: adminPassword },
  });
  console.log(`✓ SuperAdmin: ${admin.email} | Password: Admin@123`);

  console.log('\n✅ Seeding completed successfully!');
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
