import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export const ERODE_AREAS = [
  { name: 'PS Park (Periyar Park)', pincode: '638001', latitude: 11.3425, longitude: 77.7265 },
  { name: 'Brough Road', pincode: '638001', latitude: 11.3410, longitude: 77.7240 },
  { name: 'Manikoondu (Clock Tower)', pincode: '638001', latitude: 11.3435, longitude: 77.7280 },
  { name: 'Nethaji Market', pincode: '638001', latitude: 11.3440, longitude: 77.7270 },
  { name: 'Gandhiji Road', pincode: '638001', latitude: 11.3400, longitude: 77.7210 },
  { name: 'Marapalam', pincode: '638001', latitude: 11.3460, longitude: 77.7310 },
  { name: 'Erode Railway Station (Junction)', pincode: '638002', latitude: 11.3330, longitude: 77.7290 },
  { name: 'Kollampalayam', pincode: '638002', latitude: 11.3220, longitude: 77.7350 },
  { name: 'Moolapalayam', pincode: '638002', latitude: 11.3250, longitude: 77.7400 },
  { name: 'Vendipalayam', pincode: '638002', latitude: 11.3180, longitude: 77.7420 },
  { name: 'Solar (New Bus Stand)', pincode: '638002', latitude: 11.3150, longitude: 77.7480 },
  { name: 'Lakkapuram', pincode: '638002', latitude: 11.2980, longitude: 77.7550 },
  { name: 'Karungalpalayam', pincode: '638003', latitude: 11.3530, longitude: 77.7420 },
  { name: 'Cauvery Road', pincode: '638003', latitude: 11.3500, longitude: 77.7380 },
  { name: 'Sathy Road', pincode: '638003', latitude: 11.3580, longitude: 77.7120 },
  { name: 'Veerappanchatram', pincode: '638004', latitude: 11.3620, longitude: 77.7180 },
  { name: 'Kanirowther Kulam', pincode: '638004', latitude: 11.3550, longitude: 77.7150 },
  { name: 'BP Agraharam', pincode: '638005', latitude: 11.3720, longitude: 77.7190 },
  { name: 'Surampatti', pincode: '638009', latitude: 11.3280, longitude: 77.7050 },
  { name: 'Surampatti Valasu', pincode: '638009', latitude: 11.3270, longitude: 77.7030 },
  { name: 'Kasipalayam', pincode: '638009', latitude: 11.3210, longitude: 77.7200 },
  { name: 'Rangampalayam', pincode: '638009', latitude: 11.3120, longitude: 77.7100 },
  { name: 'Vettukattuvalasu', pincode: '638009', latitude: 11.3350, longitude: 77.6880 },
  { name: 'Perundurai Road', pincode: '638011', latitude: 11.3320, longitude: 77.6920 },
  { name: 'Sampath Nagar', pincode: '638011', latitude: 11.3390, longitude: 77.7020 },
  { name: 'Kumalan Kuttai', pincode: '638011', latitude: 11.3360, longitude: 77.6970 },
  { name: 'Palayapalayam', pincode: '638011', latitude: 11.3300, longitude: 77.6900 },
  { name: 'Teachers Colony', pincode: '638011', latitude: 11.3380, longitude: 77.6950 },
  { name: 'Collectorate Area', pincode: '638011', latitude: 11.3360, longitude: 77.7080 },
  { name: 'Thindal', pincode: '638012', latitude: 11.3250, longitude: 77.6750 },
  { name: 'Thindal Murugan Temple', pincode: '638012', latitude: 11.3240, longitude: 77.6720 },
  { name: 'Villarasampatti', pincode: '638107', latitude: 11.3480, longitude: 77.6800 },
  { name: 'Nasiyanur', pincode: '638107', latitude: 11.3650, longitude: 77.6320 },
  { name: 'Chithode', pincode: '638102', latitude: 11.4110, longitude: 77.6680 },
  { name: 'Bhavani', pincode: '638301', latitude: 11.4500, longitude: 77.6830 },
  { name: 'Perundurai', pincode: '638052', latitude: 11.2750, longitude: 77.5850 },
  { name: 'Modakkurichi', pincode: '638104', latitude: 11.2330, longitude: 77.7500 },
  { name: 'Avalpoondurai', pincode: '638115', latitude: 11.2150, longitude: 77.6800 },
  { name: 'Chennimalai', pincode: '638051', latitude: 11.1680, longitude: 77.6080 },
  { name: 'Kodumudi', pincode: '638151', latitude: 11.0800, longitude: 77.8850 },
  { name: 'Gobichettipalayam', pincode: '638452', latitude: 11.4550, longitude: 77.4350 },
  { name: 'Sathyamangalam', pincode: '638402', latitude: 11.5050, longitude: 77.2400 },
  { name: 'Anthiyur', pincode: '638501', latitude: 11.5800, longitude: 77.5900 },
];

async function seedErodeAreas() {
  console.log('📍 Seeding Erode District & Local Areas...');

  // 1. Upsert Erode District
  let district = await prisma.district.findFirst({
    where: {
      OR: [
        { code: 'ERO' },
        { code: 'ERD' },
        { name: 'Erode' },
      ],
    },
  });

  if (!district) {
    district = await prisma.district.create({
      data: {
        name: 'Erode',
        code: 'ERO',
        latitude: 11.3410,
        longitude: 77.7172,
        isActive: true,
      },
    });
    console.log(`✓ Created District: Erode (${district.id})`);
  } else {
    district = await prisma.district.update({
      where: { id: district.id },
      data: {
        name: 'Erode',
        latitude: 11.3410,
        longitude: 77.7172,
        isActive: true,
      },
    });
    console.log(`✓ Using existing District: Erode (${district.id})`);
  }

  // 2. Upsert each area
  let createdCount = 0;
  let updatedCount = 0;

  for (const area of ERODE_AREAS) {
    const existing = await prisma.area.findFirst({
      where: {
        districtId: district.id,
        name: area.name,
      },
    });

    if (existing) {
      await prisma.area.update({
        where: { id: existing.id },
        data: {
          pincode: area.pincode,
          latitude: area.latitude,
          longitude: area.longitude,
          isActive: true,
        },
      });
      updatedCount++;
    } else {
      await prisma.area.create({
        data: {
          districtId: district.id,
          name: area.name,
          pincode: area.pincode,
          latitude: area.latitude,
          longitude: area.longitude,
          isActive: true,
        },
      });
      createdCount++;
    }
  }

  console.log(`\n🎉 Erode Areas Seed Complete!`);
  console.log(`   - District: Erode (Code: ${district.code})`);
  console.log(`   - New Areas Created: ${createdCount}`);
  console.log(`   - Existing Areas Updated: ${updatedCount}`);
  console.log(`   - Total Erode Areas: ${ERODE_AREAS.length}`);
}

seedErodeAreas()
  .catch((e) => {
    console.error('❌ Error seeding Erode areas:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
