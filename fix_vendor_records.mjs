/**
 * Emergency fix script: Re-creates vendor records for VendorRequests
 * that are APPROVED but don't have a corresponding Vendor record.
 * 
 * Run: node fix_vendor_records.mjs
 */
import { PrismaClient } from '@prisma/client';
import bcrypt from 'bcryptjs';

const p = new PrismaClient();

async function fix() {
  // Find all APPROVED vendor requests
  const approvedRequests = await p.vendorRequest.findMany({
    where: { status: 'APPROVED' },
  });

  console.log(`Found ${approvedRequests.length} APPROVED vendor requests`);

  for (const req of approvedRequests) {
    // Check if vendor record exists
    const existingVendor = await p.vendor.findFirst({
      where: { customerId: req.customerId },
    });

    if (existingVendor) {
      console.log(`✅ Vendor already exists for request ${req.id} (${req.shopName})`);
      continue;
    }

    console.log(`❌ No vendor found for APPROVED request ${req.id} (${req.shopName}) - creating...`);

    // Find/create district and area
    let targetDistrictId = req.districtId;
    if (!targetDistrictId) {
      let fallbackDistrict = await p.district.findFirst();
      if (!fallbackDistrict) {
        fallbackDistrict = await p.district.create({ data: { name: 'Default District', code: 'DEFAULT' } });
      }
      targetDistrictId = fallbackDistrict.id;
    }

    let targetAreaId = req.areaId;
    if (!targetAreaId) {
      let fallbackArea = await p.area.findFirst({ where: { districtId: targetDistrictId } });
      if (!fallbackArea) {
        fallbackArea = await p.area.create({ data: { name: 'Main Area', districtId: targetDistrictId, isActive: true } });
      }
      targetAreaId = fallbackArea.id;
    }

    const vendorEmail = req.email ?? `vendor_${req.id}@districtmart.com`;
    
    // Check email conflict
    const emailConflict = await p.vendor.findUnique({ where: { email: vendorEmail } });
    if (emailConflict) {
      console.warn(`  ⚠️  Email ${vendorEmail} already used by another vendor, skipping...`);
      continue;
    }

    const tempPassword = Math.random().toString(36).slice(-8) + 'V@1';
    const passwordHash = await bcrypt.hash(tempPassword, 10);

    const baseSlug = (req.shopName ?? 'shop').toLowerCase().replace(/[^a-z0-9]+/g, '-');
    let slug = baseSlug;
    let counter = 1;
    while (await p.vendor.findUnique({ where: { slug } })) {
      slug = `${baseSlug}-${counter++}`;
    }

    const vendorCode = `VND-${Math.random().toString(36).substring(2, 6).toUpperCase()}`;

    try {
      const vendor = await p.vendor.create({
        data: {
          areaId: targetAreaId,
          districtId: targetDistrictId,
          customerId: req.customerId,
          email: vendorEmail,
          passwordHash,
          shopName: req.shopName ?? 'My Shop',
          code: vendorCode,
          slug,
          description: req.description,
          logoUrl: req.logoUrl,
          bannerUrl: req.bannerUrl,
          address: req.address ?? '',
          landmark: req.landmark,
          latitude: req.latitude,
          longitude: req.longitude,
          phone: req.mobileNumber ?? '',
          fssaiNumber: req.fssaiNumber,
          gstNumber: req.gstNumber,
          fssaiDocUrl: req.fssaiCertUrl,
          gstDocUrl: req.gstCertUrl,
          bankAccountNo: req.accountNumber,
          bankIfsc: req.ifscCode,
          bankHolderName: req.accountHolderName,
          deliveryRadius: req.deliveryRadius ?? 5,
          status: 'APPROVED',
          approvedAt: new Date(),
          approvedBy: 'FIX_SCRIPT',
        },
      });
      console.log(`  ✅ Created vendor ${vendor.id} for ${req.shopName}`);
      console.log(`  🔑 Temp password (save this!): ${tempPassword}`);
    } catch (e) {
      console.error(`  ❌ Failed to create vendor for request ${req.id}:`, e.message);
    }
  }

  await p.$disconnect();
  console.log('\nDone!');
}

fix().catch(console.error);
