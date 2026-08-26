import { PrismaClient } from '@prisma/client';
import { reverseGeocodeLocation } from './src/modules/customer/customer.service.js';

const prisma = new PrismaClient();

async function main() {
  const lat = 11.284893;
  const lng = 77.601841;
  
  console.log(`\nTesting reverse geocode for: ${lat}, ${lng}`);
  
  const key = 'AIzaSyA5yg-6rj5_CJN8L0N0on1RvZqFYcUrEPI';
  
  // Test Google Maps API
  const res = await fetch(`https://maps.googleapis.com/maps/api/geocode/json?latlng=${lat},${lng}&key=${key}`);
  const data = await res.json();
  if (data.status === 'OK' && data.results && data.results.length > 0) {
     console.log('Google Maps Result:', data.results[0].formatted_address);
     console.log('Address Components:', JSON.stringify(data.results[0].address_components, null, 2));
  } else {
     console.log('Google Maps API Failed or Error:', data);
  }
}

main().finally(() => prisma.$disconnect());
