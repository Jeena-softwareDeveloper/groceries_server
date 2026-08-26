import { cacheDelPattern } from './src/lib/redis.ts';

async function main() {
  await cacheDelPattern('geo:rev:*');
  console.log('Cleared Geocode cache');
}

main();
