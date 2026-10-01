/**
 * API Seeder for Erode Local Areas
 * This script seeds all local areas in Erode via the Admin API.
 * Usage:
 *   node seed-erode-areas-api.cjs                (defaults to remote API: https://api.alltimemarket.in)
 *   node seed-erode-areas-api.cjs http://localhost:3000   (for local server)
 */

const ERODE_AREAS = [
  { name: 'PS Park (Periyar Park)', pincode: '638001' },
  { name: 'Brough Road', pincode: '638001' },
  { name: 'Manikoondu (Clock Tower)', pincode: '638001' },
  { name: 'Nethaji Market', pincode: '638001' },
  { name: 'Gandhiji Road', pincode: '638001' },
  { name: 'Marapalam', pincode: '638001' },
  { name: 'Erode Railway Station (Junction)', pincode: '638002' },
  { name: 'Kollampalayam', pincode: '638002' },
  { name: 'Moolapalayam', pincode: '638002' },
  { name: 'Vendipalayam', pincode: '638002' },
  { name: 'Solar (New Bus Stand)', pincode: '638002' },
  { name: 'Lakkapuram', pincode: '638002' },
  { name: 'Karungalpalayam', pincode: '638003' },
  { name: 'Cauvery Road', pincode: '638003' },
  { name: 'Sathy Road', pincode: '638003' },
  { name: 'Veerappanchatram', pincode: '638004' },
  { name: 'Kanirowther Kulam', pincode: '638004' },
  { name: 'BP Agraharam', pincode: '638005' },
  { name: 'Surampatti', pincode: '638009' },
  { name: 'Surampatti Valasu', pincode: '638009' },
  { name: 'Kasipalayam', pincode: '638009' },
  { name: 'Rangampalayam', pincode: '638009' },
  { name: 'Vettukattuvalasu', pincode: '638009' },
  { name: 'Perundurai Road', pincode: '638011' },
  { name: 'Sampath Nagar', pincode: '638011' },
  { name: 'Kumalan Kuttai', pincode: '638011' },
  { name: 'Palayapalayam', pincode: '638011' },
  { name: 'Teachers Colony', pincode: '638011' },
  { name: 'Collectorate Area', pincode: '638011' },
  { name: 'Thindal', pincode: '638012' },
  { name: 'Thindal Murugan Temple', pincode: '638012' },
  { name: 'Villarasampatti', pincode: '638107' },
  { name: 'Nasiyanur', pincode: '638107' },
  { name: 'Chithode', pincode: '638102' },
  { name: 'Bhavani', pincode: '638301' },
  { name: 'Perundurai', pincode: '638052' },
  { name: 'Modakkurichi', pincode: '638104' },
  { name: 'Avalpoondurai', pincode: '638115' },
  { name: 'Chennimalai', pincode: '638051' },
  { name: 'Kodumudi', pincode: '638151' },
  { name: 'Gobichettipalayam', pincode: '638452' },
  { name: 'Sathyamangalam', pincode: '638402' },
  { name: 'Anthiyur', pincode: '638501' },
];

async function run() {
  const targetUrl = process.argv[2] || 'https://api.alltimemarket.in';
  console.log(`🌐 Target API: ${targetUrl}`);

  // 1. Admin login
  console.log('1. Logging in as Admin...');
  let loginRes = await fetch(`${targetUrl}/api/v1/auth/admin/login`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ email: 'admin@alltimemarket.com', password: 'Admin@123' })
  });

  if (!loginRes.ok) {
    // Try fallback email
    loginRes = await fetch(`${targetUrl}/api/v1/auth/admin/login`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ email: 'admin@districtmart.com', password: 'Admin@123' })
    });
  }

  const loginData = await loginRes.json();
  if (!loginRes.ok || !loginData?.data?.accessToken) {
    console.error('❌ Failed to login to admin:', loginData);
    process.exit(1);
  }

  const token = loginData.data.accessToken;
  const headers = {
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${token}`
  };
  console.log('✓ Admin logged in successfully.');

  // 2. Fetch or create Erode district
  console.log('2. Finding Erode District...');
  const distRes = await fetch(`${targetUrl}/api/v1/admin/districts`, { headers });
  const distData = await distRes.json();
  const districts = distData?.data || [];
  let erodeDistrict = districts.find(d => 
    d.name?.toLowerCase().includes('erode') || 
    d.code?.toUpperCase() === 'ERO' || 
    d.code?.toUpperCase() === 'ERD'
  );

  if (!erodeDistrict) {
    console.log('Creating Erode District...');
    const createDistRes = await fetch(`${targetUrl}/api/v1/admin/districts`, {
      method: 'POST',
      headers,
      body: JSON.stringify({ name: 'Erode', code: 'ERO', isActive: true })
    });
    const created = await createDistRes.json();
    erodeDistrict = created?.data;
  }

  if (!erodeDistrict?.id) {
    console.error('❌ Could not find or create Erode District.');
    process.exit(1);
  }
  console.log(`✓ Using District: ${erodeDistrict.name} (ID: ${erodeDistrict.id})`);

  // 3. Fetch existing areas for Erode
  const areasRes = await fetch(`${targetUrl}/api/v1/admin/areas?limit=500`, { headers });
  const areasData = await areasRes.json();
  const existingAreas = (areasData?.data || []).filter(a => a.districtId === erodeDistrict.id);
  const existingNames = new Set(existingAreas.map(a => a.name.toLowerCase().trim()));
  console.log(`Found ${existingAreas.length} existing area(s) for Erode.`);

  // 4. Seed all areas
  console.log(`3. Seeding ${ERODE_AREAS.length} local areas...`);
  let createdCount = 0;
  let skippedCount = 0;

  for (const area of ERODE_AREAS) {
    if (existingNames.has(area.name.toLowerCase().trim())) {
      skippedCount++;
      continue;
    }

    try {
      const res = await fetch(`${targetUrl}/api/v1/admin/areas`, {
        method: 'POST',
        headers,
        body: JSON.stringify({
          districtId: erodeDistrict.id,
          name: area.name,
          pincode: area.pincode,
          isActive: true
        })
      });

      if (res.ok) {
        console.log(`   + Added: ${area.name} (${area.pincode})`);
        createdCount++;
      } else {
        const errJson = await res.json();
        console.log(`   ! Failed: ${area.name} ->`, errJson?.error?.message || res.statusText);
      }
    } catch (e) {
      console.log(`   ! Error: ${area.name} ->`, e.message);
    }
  }

  console.log('\n========================================');
  console.log(`🎉 Seeding Finished on ${targetUrl}!`);
  console.log(`   - Newly Created: ${createdCount}`);
  console.log(`   - Already Existed: ${skippedCount}`);
  console.log(`   - Total Areas Now: ${existingAreas.length + createdCount}`);
  console.log('========================================');
}

run();
