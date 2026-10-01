/**
 * Domain Migration Script
 * Updates all image URLs in the database from the old domain to the new domain.
 * Run this ONCE on the production server:
 *   node migrate-image-domain.cjs
 */

const { PrismaClient } = require('@prisma/client');

const OLD_DOMAIN = 'https://atmapi.ponnilamfincorp.com/uploads';
const NEW_DOMAIN = 'https://api.alltimemarket.in/uploads';

const prisma = new PrismaClient();

function fix(value) {
  if (typeof value === 'string' && value.includes(OLD_DOMAIN)) {
    return value.split(OLD_DOMAIN).join(NEW_DOMAIN);
  }
  return value;
}

async function main() {
  console.log('🔄 Starting domain migration...');
  console.log(`   Old: ${OLD_DOMAIN}`);
  console.log(`   New: ${NEW_DOMAIN}\n`);

  let totalUpdated = 0;

  // ── Vendor (logoUrl, bannerUrl) ─────────────────────────────────────────────
  const vendors = await prisma.vendor.findMany({
    where: {
      OR: [
        { logoUrl: { contains: OLD_DOMAIN } },
        { bannerUrl: { contains: OLD_DOMAIN } },
      ],
    },
    select: { id: true, logoUrl: true, bannerUrl: true },
  });
  console.log(`📦 Vendors with old URLs: ${vendors.length}`);
  for (const v of vendors) {
    await prisma.vendor.update({
      where: { id: v.id },
      data: {
        logoUrl: fix(v.logoUrl),
        bannerUrl: fix(v.bannerUrl),
      },
    });
    totalUpdated++;
    console.log(`   ✓ Vendor ${v.id}`);
  }

  // ── ProductImage (url) ──────────────────────────────────────────────────────
  const productImages = await prisma.productImage.findMany({
    where: { url: { contains: OLD_DOMAIN } },
    select: { id: true, url: true },
  });
  console.log(`\n🖼️  ProductImages with old URLs: ${productImages.length}`);
  for (const pi of productImages) {
    await prisma.productImage.update({
      where: { id: pi.id },
      data: { url: fix(pi.url) },
    });
    totalUpdated++;
    console.log(`   ✓ ProductImage ${pi.id}`);
  }

  // ── Category (imageUrl) ─────────────────────────────────────────────────────
  const categories = await prisma.category.findMany({
    where: { imageUrl: { contains: OLD_DOMAIN } },
    select: { id: true, imageUrl: true },
  });
  console.log(`\n🗂️  Categories with old URLs: ${categories.length}`);
  for (const c of categories) {
    await prisma.category.update({
      where: { id: c.id },
      data: { imageUrl: fix(c.imageUrl) },
    });
    totalUpdated++;
    console.log(`   ✓ Category ${c.id}`);
  }

  // ── Banner (imageUrl) ───────────────────────────────────────────────────────
  const banners = await prisma.banner.findMany({
    where: { imageUrl: { contains: OLD_DOMAIN } },
    select: { id: true, imageUrl: true },
  });
  console.log(`\n🖼️  Banners with old URLs: ${banners.length}`);
  for (const b of banners) {
    await prisma.banner.update({
      where: { id: b.id },
      data: { imageUrl: fix(b.imageUrl) },
    });
    totalUpdated++;
    console.log(`   ✓ Banner ${b.id}`);
  }

  // ── MicroBanner (imageUrl) ──────────────────────────────────────────────────
  const microBanners = await prisma.microBanner.findMany({
    where: { imageUrl: { contains: OLD_DOMAIN } },
    select: { id: true, imageUrl: true },
  });
  console.log(`\n📢 MicroBanners with old URLs: ${microBanners.length}`);
  for (const mb of microBanners) {
    await prisma.microBanner.update({
      where: { id: mb.id },
      data: { imageUrl: fix(mb.imageUrl) },
    });
    totalUpdated++;
    console.log(`   ✓ MicroBanner ${mb.id}`);
  }

  // ── Offer (imageUrl) ────────────────────────────────────────────────────────
  const offers = await prisma.offer.findMany({
    where: { imageUrl: { contains: OLD_DOMAIN } },
    select: { id: true, imageUrl: true },
  });
  console.log(`\n🎁 Offers with old URLs: ${offers.length}`);
  for (const o of offers) {
    await prisma.offer.update({
      where: { id: o.id },
      data: { imageUrl: fix(o.imageUrl) },
    });
    totalUpdated++;
    console.log(`   ✓ Offer ${o.id}`);
  }

  // ── Review (imageUrl) ───────────────────────────────────────────────────────
  const reviews = await prisma.review.findMany({
    where: { imageUrl: { contains: OLD_DOMAIN } },
    select: { id: true, imageUrl: true },
  });
  console.log(`\n⭐ Reviews with old URLs: ${reviews.length}`);
  for (const r of reviews) {
    await prisma.review.update({
      where: { id: r.id },
      data: { imageUrl: fix(r.imageUrl) },
    });
    totalUpdated++;
    console.log(`   ✓ Review ${r.id}`);
  }

  // ── VendorRequest (logoUrl, bannerUrl, govtIdUrl etc.) ─────────────────────
  try {
    const vendorRequests = await prisma.vendorRequest.findMany({
      where: {
        OR: [
          { logoUrl: { contains: OLD_DOMAIN } },
          { bannerUrl: { contains: OLD_DOMAIN } },
          { ownerPhotoUrl: { contains: OLD_DOMAIN } },
          { govtIdUrl: { contains: OLD_DOMAIN } },
          { gstCertUrl: { contains: OLD_DOMAIN } },
          { fssaiCertUrl: { contains: OLD_DOMAIN } },
        ],
      },
      select: { id: true, logoUrl: true, bannerUrl: true, ownerPhotoUrl: true, govtIdUrl: true, gstCertUrl: true, fssaiCertUrl: true },
    });
    console.log(`\n📋 VendorRequests with old URLs: ${vendorRequests.length}`);
    for (const vr of vendorRequests) {
      await prisma.vendorRequest.update({
        where: { id: vr.id },
        data: {
          logoUrl: fix(vr.logoUrl),
          bannerUrl: fix(vr.bannerUrl),
          ownerPhotoUrl: fix(vr.ownerPhotoUrl),
          govtIdUrl: fix(vr.govtIdUrl),
          gstCertUrl: fix(vr.gstCertUrl),
          fssaiCertUrl: fix(vr.fssaiCertUrl),
        },
      });
      totalUpdated++;
      console.log(`   ✓ VendorRequest ${vr.id}`);
    }
  } catch (e) {
    console.log('   (VendorRequest skipped:', e.message, ')');
  }

  console.log(`\n✅ Migration complete! Total records updated: ${totalUpdated}`);
}

main()
  .catch((e) => {
    console.error('\n❌ Migration failed:', e.message);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
