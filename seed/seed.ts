import { PrismaClient } from '@prisma/client';
import bcrypt from 'bcryptjs';

const prisma = new PrismaClient();

// ─── Tamil Nadu Districts with real center coordinates ────────────────────────
// lat/lng = district HQ centre; areas include real town coordinates
const TN_DATA = [
  {
    name: 'Chennai',
    code: 'CHN',
    lat: 13.0827,
    lng: 80.2707,
    areas: [
      { name: 'Anna Nagar',        lat: 13.0891, lng: 80.2109 },
      { name: 'T. Nagar',          lat: 13.0418, lng: 80.2341 },
      { name: 'Adyar',             lat: 13.0012, lng: 80.2565 },
      { name: 'Velachery',         lat: 12.9815, lng: 80.2180 },
      { name: 'Tambaram',          lat: 12.9249, lng: 80.1000 },
      { name: 'Porur',             lat: 13.0358, lng: 80.1572 },
      { name: 'Chromepet',         lat: 12.9516, lng: 80.1462 },
      { name: 'Guindy',            lat: 13.0067, lng: 80.2206 },
      { name: 'Nungambakkam',      lat: 13.0569, lng: 80.2425 },
      { name: 'Mylapore',          lat: 13.0368, lng: 80.2676 },
    ],
  },
  {
    name: 'Coimbatore',
    code: 'CBE',
    lat: 11.0168,
    lng: 76.9558,
    areas: [
      { name: 'RS Puram',          lat: 11.0103, lng: 76.9501 },
      { name: 'Gandhipuram',       lat: 11.0183, lng: 76.9725 },
      { name: 'Peelamedu',         lat: 11.0271, lng: 77.0130 },
      { name: 'Saibaba Colony',    lat: 11.0230, lng: 76.9430 },
      { name: 'Singanallur',       lat: 10.9989, lng: 77.0181 },
      { name: 'Vadavalli',         lat: 11.0434, lng: 76.9122 },
      { name: 'Podanur',           lat: 10.9666, lng: 76.9775 },
      { name: 'Thudiyalur',        lat: 11.0676, lng: 76.9434 },
      { name: 'Kuniyamuthur',      lat: 10.9826, lng: 76.9560 },
    ],
  },
  {
    name: 'Madurai',
    code: 'MDU',
    lat: 9.9252,
    lng: 78.1198,
    areas: [
      { name: 'Anna Nagar',        lat: 9.9390, lng: 78.1186 },
      { name: 'KK Nagar',          lat: 9.9218, lng: 78.1054 },
      { name: 'Tallakulam',        lat: 9.9382, lng: 78.1287 },
      { name: 'Bibi Kulam',        lat: 9.9490, lng: 78.1200 },
      { name: 'Palanganatham',     lat: 9.9016, lng: 78.1155 },
      { name: 'Vilangudi',         lat: 9.9603, lng: 78.1452 },
      { name: 'Arappalayam',       lat: 9.9285, lng: 78.1374 },
    ],
  },
  {
    name: 'Tiruchirappalli',
    code: 'TRI',
    lat: 10.7905,
    lng: 78.7047,
    areas: [
      { name: 'Thillai Nagar',     lat: 10.8105, lng: 78.6897 },
      { name: 'Srirangam',         lat: 10.8635, lng: 78.6931 },
      { name: 'Ariyamangalam',     lat: 10.7699, lng: 78.7562 },
      { name: 'Woraiyur',          lat: 10.8092, lng: 78.7254 },
      { name: 'Cantonment',        lat: 10.8019, lng: 78.6858 },
      { name: 'Puthur',            lat: 10.7751, lng: 78.7072 },
    ],
  },
  {
    name: 'Salem',
    code: 'SLM',
    lat: 11.6643,
    lng: 78.1460,
    areas: [
      { name: 'Fairlands',         lat: 11.6710, lng: 78.1390 },
      { name: 'Suramangalam',      lat: 11.6851, lng: 78.1589 },
      { name: 'Ammapet',           lat: 11.6547, lng: 78.1580 },
      { name: 'Hasthampatti',      lat: 11.6786, lng: 78.1102 },
      { name: 'Shevapet',          lat: 11.6556, lng: 78.1465 },
      { name: 'Gugai',             lat: 11.6499, lng: 78.1351 },
    ],
  },
  {
    name: 'Erode',
    code: 'ERD',
    lat: 11.3410,
    lng: 77.7172,
    areas: [
      { name: 'Perundurai',        lat: 11.2756, lng: 77.5868 },
      { name: 'Sathiyamangalam',   lat: 11.5024, lng: 77.2386 },
      { name: 'Bhavani',           lat: 11.4427, lng: 77.6858 },
      { name: 'Gobichettipalayam', lat: 11.4544, lng: 77.3606 },
      { name: 'Erode City',        lat: 11.3410, lng: 77.7172 },
      { name: 'Kangayam',          lat: 11.0049, lng: 77.5600 },
      { name: 'Anthiyur',          lat: 11.5768, lng: 77.5937 },
      { name: 'Nambiyur',          lat: 11.3933, lng: 77.3580 },
    ],
  },
  {
    name: 'Tiruppur',
    code: 'TPR',
    lat: 11.1085,
    lng: 77.3411,
    areas: [
      { name: 'Tiruppur City',     lat: 11.1085, lng: 77.3411 },
      { name: 'Avinashi',          lat: 11.1938, lng: 77.2658 },
      { name: 'Palladam',          lat: 10.9997, lng: 77.2847 },
      { name: 'Dharapuram',        lat: 10.7303, lng: 77.5125 },
      { name: 'Udumalpet',         lat: 10.5849, lng: 77.2452 },
    ],
  },
  {
    name: 'Vellore',
    code: 'VLR',
    lat: 12.9165,
    lng: 79.1325,
    areas: [
      { name: 'Vellore City',      lat: 12.9165, lng: 79.1325 },
      { name: 'Katpadi',           lat: 12.9714, lng: 79.1546 },
      { name: 'Ranipet',           lat: 12.9244, lng: 79.3318 },
      { name: 'Ambur',             lat: 12.7942, lng: 78.7160 },
      { name: 'Vaniyambadi',       lat: 12.6825, lng: 78.6188 },
    ],
  },
  {
    name: 'Tirunelveli',
    code: 'TNV',
    lat: 8.7139,
    lng: 77.7567,
    areas: [
      { name: 'Tirunelveli City',  lat: 8.7139, lng: 77.7567 },
      { name: 'Palayamkottai',     lat: 8.7180, lng: 77.7467 },
      { name: 'Tenkasi',           lat: 8.9597, lng: 77.3152 },
      { name: 'Nanguneri',         lat: 8.4946, lng: 77.6573 },
      { name: 'Cheranmahadevi',    lat: 8.6879, lng: 77.5908 },
    ],
  },
  {
    name: 'Thanjavur',
    code: 'TNJ',
    lat: 10.7870,
    lng: 79.1378,
    areas: [
      { name: 'Thanjavur City',    lat: 10.7870, lng: 79.1378 },
      { name: 'Kumbakonam',        lat: 10.9594, lng: 79.3858 },
      { name: 'Papanasam',         lat: 10.9307, lng: 79.2724 },
      { name: 'Pattukottai',       lat: 10.4220, lng: 79.3155 },
    ],
  },
  {
    name: 'Namakkal',
    code: 'NMK',
    lat: 11.2190,
    lng: 78.1676,
    areas: [
      { name: 'Namakkal City',     lat: 11.2190, lng: 78.1676 },
      { name: 'Rasipuram',         lat: 11.4595, lng: 78.1816 },
      { name: 'Tiruchengode',      lat: 11.3807, lng: 77.8952 },
      { name: 'Paramathi Velur',   lat: 11.1112, lng: 77.9866 },
    ],
  },
];

async function main() {
  console.log('Seeding database...');

  // 1. SuperAdmin
  const adminEmail = 'admin@districtmart.com';
  const adminPassword = await bcrypt.hash('Admin@123', 12);
  const admin = await prisma.superAdmin.upsert({
    where: { email: adminEmail },
    update: { passwordHash: adminPassword },
    create: { email: adminEmail, name: 'Super Admin', passwordHash: adminPassword },
  });
  console.log(`✓ SuperAdmin: ${admin.email} | Password: Admin@123`);

  // 2. Customer
  const customerPhone = '9876543210';
  const customer = await prisma.customer.upsert({
    where: { phone: customerPhone },
    update: {},
    create: { phone: customerPhone, name: 'Test Customer', wallet: { create: {} } },
  });
  console.log(`✓ Customer: ${customer.phone}`);

  // 3. OTP Session
  await prisma.otpSession.deleteMany({ where: { phone: customerPhone } });
  await prisma.otpSession.create({
    data: {
      phone: customerPhone,
      otp: '123456',
      expiresAt: new Date(Date.now() + 24 * 60 * 60 * 1000),
    },
  });
  console.log(`✓ OTP Session for ${customerPhone}: 123456`);

  // 4. Districts + Areas with coordinates (for GPS radius matching)
  for (const d of TN_DATA) {
    const district = await prisma.district.upsert({
      where: { code: d.code },
      update: { name: d.name, latitude: d.lat, longitude: d.lng },
      create: { name: d.name, code: d.code, latitude: d.lat, longitude: d.lng },
    });

    for (const area of d.areas) {
      const existing = await prisma.area.findFirst({
        where: { name: area.name, districtId: district.id },
      });
      if (existing) {
        await prisma.area.update({
          where: { id: existing.id },
          data: { latitude: area.lat, longitude: area.lng },
        });
      } else {
        await prisma.area.create({
          data: {
            name: area.name,
            districtId: district.id,
            latitude: area.lat,
            longitude: area.lng,
          },
        });
      }
    }
    console.log(`✓ District: ${d.name} (${d.lat}, ${d.lng}) — ${d.areas.length} areas`);
  }

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
