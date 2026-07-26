import { PrismaClient } from '@prisma/client';
import bcrypt from 'bcryptjs';

const prisma = new PrismaClient();

async function main() {
  console.log('Seeding database...');

  // 1. Seed SuperAdmin
  const adminEmail = 'admin@districtmart.com';
  // Use bcryptjs to hash password as done in auth.service.ts (SALT_ROUNDS = 12)
  const adminPassword = await bcrypt.hash('Admin@123', 12);
  
  const admin = await prisma.superAdmin.upsert({
    where: { email: adminEmail },
    update: {
      passwordHash: adminPassword,
    },
    create: {
      email: adminEmail,
      name: 'Super Admin',
      passwordHash: adminPassword,
    },
  });
  console.log(`SuperAdmin seeded: Email - ${admin.email} | Password - Admin@123`);

  // 2. Seed Customer
  const customerPhone = '9876543210';
  const customer = await prisma.customer.upsert({
    where: { phone: customerPhone },
    update: {},
    create: {
      phone: customerPhone,
      name: 'Test Customer',
      wallet: { create: {} }
    },
  });
  console.log(`Customer seeded: ${customer.phone}`);

  // 3. Seed OtpSession for verification testing
  await prisma.otpSession.deleteMany({ where: { phone: customerPhone } });
  const otpSession = await prisma.otpSession.create({
    data: {
      phone: customerPhone,
      otp: '123456',
      expiresAt: new Date(Date.now() + 24 * 60 * 60 * 1000), // Valid for 24 hours for testing purposes
    },
  });
  console.log(`OTP Session seeded for ${customerPhone} with OTP ${otpSession.otp}`);
  
  console.log('Seeding completed successfully!');
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
