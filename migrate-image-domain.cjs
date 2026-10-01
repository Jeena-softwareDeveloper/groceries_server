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

function replaceUrl(value) {
  if (typeof value === 'string' && value.includes(OLD_DOMAIN)) {
    return value.replace(new RegExp(OLD_DOMAIN.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'), 'g'), NEW_DOMAIN);
  }
  return value;
}

async function main() {
  console.log('🔄 Starting domain migration...');
  console.log(`   Old: ${OLD_DOMAIN}`);
  console.log(`   New: ${NEW_DOMAIN}\n`);

  let totalUpdated = 0;

  // ── Vendors (logoUrl, bannerUrl) ────────────────────────────────────────────
  const vendors = await prisma.vendor.findMany({
    where: {
      OR: [
        { logoUrl: { contains: OLD_DOMAIN } },
        { bannerUrl: { contains: OLD_DOMAIN } },
      ],
    },
  });
  console.log(`📦 Vendors with old URLs: ${vendors.length}`);
  for (const v of vendors) {
    await prisma.vendor.update({
      where: { id: v.id },
      data: {
        logoUrl: replaceUrl(v.logoUrl),
        bannerUrl: replaceUrl(v.bannerUrl),
      },
    });
    totalUpdated++;
  }

  // ── Products (imageUrl, images array) ──────────────────────────────────────
  const products = await prisma.product.findMany({
    where: {
      OR: [
        { imageUrl: { contains: OLD_DOMAIN } },
      ],
    },
  });
  console.log(`🛍️  Products with old URLs: ${products.length}`);
  for (const p of products) {
    // Handle images JSON array if it exists
    let newImages = p.images;
    if (Array.isArray(p.images)) {
      newImages = p.images.map((img) => replaceUrl(img));
    }
    await prisma.product.update({
      where: { id: p.id },
      data: {
        imageUrl: replaceUrl(p.imageUrl),
        images: newImages,
      },
    });
    totalUpdated++;
  }

  // ── Categories (imageUrl) ──────────────────────────────────────────────────
  const categories = await prisma.category.findMany({
    where: { imageUrl: { contains: OLD_DOMAIN } },
  });
  console.log(`🗂️  Categories with old URLs: ${categories.length}`);
  for (const c of categories) {
    await prisma.category.update({
      where: { id: c.id },
      data: { imageUrl: replaceUrl(c.imageUrl) },
    });
    totalUpdated++;
  }

  // ── Banners (imageUrl) ─────────────────────────────────────────────────────
  const banners = await prisma.banner.findMany({
    where: { imageUrl: { contains: OLD_DOMAIN } },
  });
  console.log(`🖼️  Banners with old URLs: ${banners.length}`);
  for (const b of banners) {
    await prisma.banner.update({
      where: { id: b.id },
      data: { imageUrl: replaceUrl(b.imageUrl) },
    });
    totalUpdated++;
  }

  // ── Staff (avatarUrl / photoUrl) ───────────────────────────────────────────
  try {
    const staffList = await prisma.staff.findMany({
      where: { photoUrl: { contains: OLD_DOMAIN } },
    });
    console.log(`👤 Staff with old URLs: ${staffList.length}`);
    for (const s of staffList) {
      await prisma.staff.update({
        where: { id: s.id },
        data: { photoUrl: replaceUrl(s.photoUrl) },
      });
      totalUpdated++;
    }
  } catch (e) {
    console.log('   (Staff table skipped — photoUrl field may not exist)');
  }

  console.log(`\n✅ Migration complete! Total records updated: ${totalUpdated}`);
}

main()
  .catch((e) => {
    console.error('❌ Migration failed:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
