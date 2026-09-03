import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

const categories = [
  { sortOrder: 1, name: 'Men\'s Clothing', slug: 'mens-clothing' },
  { sortOrder: 2, name: 'Ayurveda & Pooja', slug: 'ayurveda-pooja' },
  { sortOrder: 3, name: 'Water & Plates', slug: 'water-plates' },
  { sortOrder: 4, name: 'Flowers', slug: 'flowers' },
  { sortOrder: 5, name: 'Finance', slug: 'finance' },
  { sortOrder: 6, name: 'Women & Kids', slug: 'women-kids' },
  { sortOrder: 7, name: 'Beauty', slug: 'beauty' },
  { sortOrder: 8, name: 'Steel', slug: 'steel' },
  { sortOrder: 9, name: 'Wood', slug: 'wood' },
  { sortOrder: 10, name: 'Restaurants', slug: 'restaurants' },
  { sortOrder: 11, name: 'Groceries', slug: 'groceries' },
  { sortOrder: 12, name: 'Fruits & Veg', slug: 'fruits-veg' },
  { sortOrder: 13, name: 'Dairy & Bakery', slug: 'dairy-bakery' },
  { sortOrder: 14, name: 'Meat & Seafood', slug: 'meat-seafood' },
  { sortOrder: 15, name: 'Snacks & Drinks', slug: 'snacks-drinks' },
];

async function main() {
  console.log('Seeding Categories...');

  // Clear existing categories first to avoid duplicates
  await prisma.category.deleteMany({});

  for (const cat of categories) {
    const category = await prisma.category.upsert({
      where: { slug: cat.slug },
      update: { name: cat.name, sortOrder: cat.sortOrder },
      create: { name: cat.name, slug: cat.slug, sortOrder: cat.sortOrder },
    });
    console.log(`✓ Category: ${category.name}`);
  }

  console.log('\n✅ Category seeding completed successfully!');
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
