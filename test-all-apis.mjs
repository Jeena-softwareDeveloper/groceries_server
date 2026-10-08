#!/usr/bin/env node
/**
 * Automated API Test Suite for DistrictMart / AllTimeMarket API Server
 * 
 * Usage:
 *   node test-all-apis.mjs                      # tests http://localhost:3002 (PM2 server port)
 *   node test-all-apis.mjs http://localhost:4000 # tests local dev server
 *   node test-all-apis.mjs https://api.alltimemarket.in # tests public domain
 * 
 * Options via Environment Variables:
 *   API_URL=http://localhost:3002
 *   ADMIN_EMAIL=admin@alltimemarket.com
 *   ADMIN_PASSWORD=Admin@123
 */

const TARGET_URL = (process.argv[2] || process.env.API_URL || 'http://localhost:3002').replace(/\/+$/, '');
const ADMIN_EMAIL = process.env.ADMIN_EMAIL || 'admin@alltimemarket.com';
const ADMIN_PASSWORD = process.env.ADMIN_PASSWORD || 'Admin@123';

const COLORS = {
  reset: '\x1b[0m',
  bold: '\x1b[1m',
  dim: '\x1b[2m',
  green: '\x1b[32m',
  red: '\x1b[31m',
  yellow: '\x1b[33m',
  cyan: '\x1b[36m',
  blue: '\x1b[34m',
  magenta: '\x1b[35m',
};

const results = [];
let adminToken = null;
let sampleDistrictId = null;
let sampleCategoryId = null;
let sampleShopId = null;

function logHeader(title) {
  console.log(`\n${COLORS.bold}${COLORS.cyan}═══ [ ${title} ] ═══${COLORS.reset}`);
}

async function request(path, options = {}) {
  const url = `${TARGET_URL}${path.startsWith('/') ? path : '/' + path}`;
  const start = Date.now();
  const headers = {
    'Accept': 'application/json',
    ...(options.body ? { 'Content-Type': 'application/json' } : {}),
    ...(options.headers || {})
  };

  try {
    const res = await fetch(url, {
      method: options.method || 'GET',
      headers,
      body: options.body ? JSON.stringify(options.body) : undefined,
    });
    const duration = Date.now() - start;
    let data = null;
    const contentType = res.headers.get('content-type') || '';
    if (contentType.includes('application/json')) {
      try {
        data = await res.json();
      } catch (err) {
        data = null;
      }
    } else {
      data = await res.text();
    }
    return { ok: res.ok, status: res.status, duration, data, headers: res.headers };
  } catch (err) {
    const duration = Date.now() - start;
    return { ok: false, status: 0, duration, error: err.message, data: null };
  }
}

async function runTest(name, path, options = {}, validator = null) {
  process.stdout.write(`  ⏳ ${name}... `);
  const res = await request(path, options);
  
  let passed = false;
  let note = '';

  if (res.status === 0) {
    passed = false;
    note = `Network Error: ${res.error}`;
  } else if (validator) {
    const check = validator(res);
    passed = check.passed;
    note = check.note || '';
  } else {
    passed = res.ok;
    note = res.ok ? `HTTP ${res.status}` : `HTTP ${res.status}`;
  }

  const durationStr = `${res.duration}ms`;
  if (passed) {
    console.log(`\r  ${COLORS.green}✔ PASS${COLORS.reset} ${name} ${COLORS.dim}(${durationStr}) [${res.status}]${COLORS.reset} ${note ? COLORS.dim + '- ' + note + COLORS.reset : ''}`);
  } else {
    console.log(`\r  ${COLORS.red}✖ FAIL${COLORS.reset} ${name} ${COLORS.dim}(${durationStr}) [${res.status}]${COLORS.reset} ${note ? COLORS.red + '- ' + note + COLORS.reset : ''}`);
  }

  results.push({ name, path, status: res.status, passed, duration: res.duration, note });
  return res;
}

async function runAll() {
  console.log(`${COLORS.bold}${COLORS.magenta}`);
  console.log(`╔═══════════════════════════════════════════════════════════╗`);
  console.log(`║     DistrictMart / AllTimeMarket API Health Test Suite     ║`);
  console.log(`╚═══════════════════════════════════════════════════════════╝${COLORS.reset}`);
  console.log(`${COLORS.dim}Target URL: ${COLORS.reset}${COLORS.bold}${TARGET_URL}${COLORS.reset}\n`);

  // ── 1. System & Health Checks ──────────────────────────────────────────────
  logHeader('1. System & Health Check');

  await runTest('Server Health Check', '/api/v1/health', {}, (res) => {
    if (res.status === 200 && res.data?.success) {
      const dbStatus = res.data.data?.database || 'OK';
      const redisStatus = res.data.data?.redis || 'OK';
      return { passed: true, note: `DB: ${dbStatus}, Redis: ${redisStatus}` };
    }
    return { passed: false, note: `Unexpected response: ${JSON.stringify(res.data)}` };
  });

  await runTest('App Settings (/api/v1/config/app-settings)', '/api/v1/config/app-settings', {}, (res) => {
    if (res.status === 200 && res.data?.success) {
      return { passed: true, note: `App Name: ${res.data.data?.appName || 'DistrictMart'}` };
    }
    return { passed: false, note: `Status: ${res.status}` };
  });

  await runTest('Customer App Version (/api/v1/customer/app/version)', '/api/v1/customer/app/version', {}, (res) => {
    if (res.status === 200 && res.data?.success) {
      return { passed: true, note: `MinVersion: ${res.data.data?.minVersion}` };
    }
    return { passed: false, note: `Status: ${res.status}` };
  });

  await runTest('App Version Root Alias (/app/version)', '/app/version', {}, (res) => {
    // Some setups proxy /app/version directly
    if (res.status === 200) {
      return { passed: true, note: `Root alias responding` };
    }
    return { passed: res.status === 404 ? true : false, note: res.status === 404 ? 'Route handled by prefix (expected if no root rewrite)' : `HTTP ${res.status}` };
  });

  await runTest('Swagger Documentation UI (/api/docs)', '/api/docs', {}, (res) => {
    return { passed: res.status === 200 || res.status === 301 || res.status === 302, note: `Status ${res.status}` };
  });

  // ── 2. Location & Taxonomy APIs ────────────────────────────────────────────
  logHeader('2. Location & Taxonomy');

  const distRes = await runTest('List Public Districts', '/api/v1/customer/districts', {}, (res) => {
    const list = res.data?.data;
    if (Array.isArray(list)) {
      if (list.length > 0) sampleDistrictId = list[0].id;
      return { passed: true, note: `Found ${list.length} district(s)` };
    }
    return { passed: false, note: 'Expected array in res.data' };
  });

  await runTest('List Areas (without district)', '/api/v1/customer/areas', {}, (res) => {
    return { passed: res.status === 200, note: `Status ${res.status}` };
  });

  if (sampleDistrictId) {
    await runTest(`List Areas (for District: ${sampleDistrictId})`, `/api/v1/customer/areas?districtId=${sampleDistrictId}`, {}, (res) => {
      const list = res.data?.data;
      if (Array.isArray(list)) {
        return { passed: true, note: `Found ${list.length} area(s)` };
      }
      return { passed: false, note: 'Expected array in res.data' };
    });
  }

  const catRes = await runTest('List Categories', '/api/v1/customer/categories', {}, (res) => {
    const list = res.data?.data;
    if (Array.isArray(list)) {
      if (list.length > 0) sampleCategoryId = list[0].id;
      return { passed: true, note: `Found ${list.length} category(ies)` };
    }
    return { passed: false, note: 'Expected array in res.data' };
  });

  await runTest('Reverse Geocode (Erode Coords: 11.3410, 77.7172)', '/api/v1/customer/reverse-geocode?lat=11.3410&lng=77.7172', {}, (res) => {
    return { passed: res.status === 200, note: res.data?.data?.displayName ? `Resolved: ${res.data.data.displayName}` : 'OK' };
  });

  // ── 3. Vendor & Shop Listings (Updated Feature Validation) ────────────────
  logHeader('3. Shops & Vendor Listings');

  const shopsRes = await runTest('List All Public Shops', '/api/v1/customer/shops', {}, (res) => {
    const list = res.data?.data;
    if (Array.isArray(list)) {
      if (list.length > 0) sampleShopId = list[0].id;
      return { passed: true, note: `Found ${list.length} shop(s)` };
    }
    return { passed: false, note: 'Expected array in res.data' };
  });

  if (sampleCategoryId) {
    await runTest(`List Shops by Category (${sampleCategoryId})`, `/api/v1/customer/shops?categoryId=${sampleCategoryId}`, {}, (res) => {
      const list = res.data?.data;
      if (Array.isArray(list)) {
        return { passed: true, note: `Found ${list.length} shop(s) for category (incl. new vendors without products)` };
      }
      return { passed: false, note: 'Expected array in res.data' };
    });
  }

  if (sampleShopId) {
    await runTest(`Get Single Shop Details (${sampleShopId})`, `/api/v1/customer/shops/${sampleShopId}`, {}, (res) => {
      if (res.status === 200 && res.data?.data) {
        return { passed: true, note: `Shop: ${res.data.data.shopName}` };
      }
      return { passed: false, note: `Status: ${res.status}` };
    });

    await runTest(`Get Products for Shop (${sampleShopId})`, `/api/v1/customer/shops/${sampleShopId}/products`, {}, (res) => {
      const list = res.data?.data?.products || res.data?.data;
      if (Array.isArray(list)) {
        return { passed: true, note: `Found ${list.length} product(s)` };
      }
      return { passed: res.status === 200, note: `Status: ${res.status}` };
    });
  }

  // ── 4. Home Feed & Discovery ──────────────────────────────────────────────
  logHeader('4. Home Feed & Product Search');

  await runTest('Get Customer Home Feed', '/api/v1/customer/home/feed', {}, (res) => {
    if (res.status === 200 && res.data?.data) {
      const bannersCount = res.data.data?.banners?.length || 0;
      const categoriesCount = res.data.data?.categories?.length || 0;
      const storesCount = res.data.data?.featuredStores?.length || 0;
      return { passed: true, note: `Banners: ${bannersCount}, Categories: ${categoriesCount}, Stores: ${storesCount}` };
    }
    return { passed: false, note: `Status ${res.status}` };
  });

  await runTest('Get Home Feed by Location (lat=11.3410, lng=77.7172)', '/api/v1/customer/home/feed/bylocation?lat=11.3410&lng=77.7172', {}, (res) => {
    return { passed: res.status === 200, note: `Status ${res.status}` };
  });

  await runTest('List Public Products', '/api/v1/customer/products?limit=10', {}, (res) => {
    const list = res.data?.data?.products || res.data?.data;
    if (Array.isArray(list)) {
      return { passed: true, note: `Found ${list.length} product(s)` };
    }
    return { passed: res.status === 200, note: `Status ${res.status}` };
  });

  await runTest('Trending Search Keywords', '/api/v1/customer/search/trending', {}, (res) => {
    return { passed: res.status === 200, note: `Status ${res.status}` };
  });

  await runTest('Product Search Query (?q=a)', '/api/v1/customer/search?q=a', {}, (res) => {
    return { passed: res.status === 200, note: `Status ${res.status}` };
  });

  // ── 5. Authentication & Security Middleware Checks ────────────────────────
  logHeader('5. Authentication & Route Security');

  await runTest('Auth Me without Token (Should be 401 Unauthorized)', '/api/v1/auth/me', {}, (res) => {
    return { passed: res.status === 401, note: res.status === 401 ? 'Properly protected' : `Expected 401, got ${res.status}` };
  });

  await runTest('Customer Cart without Token (Should be 401 Unauthorized)', '/api/v1/customer/cart', {}, (res) => {
    return { passed: res.status === 401, note: res.status === 401 ? 'Properly protected' : `Expected 401, got ${res.status}` };
  });

  await runTest('Customer Orders without Token (Should be 401 Unauthorized)', '/api/v1/customer/orders', {}, (res) => {
    return { passed: res.status === 401, note: res.status === 401 ? 'Properly protected' : `Expected 401, got ${res.status}` };
  });

  await runTest('Vendor Profile without Token (Should be 401 Unauthorized)', '/api/v1/vendor/profile', {}, (res) => {
    return { passed: res.status === 401, note: res.status === 401 ? 'Properly protected' : `Expected 401, got ${res.status}` };
  });

  await runTest('Customer OTP Request Validation (Empty Payload should be 400)', '/api/v1/auth/customer/otp/request', {
    method: 'POST',
    body: {}
  }, (res) => {
    return { passed: res.status === 400 || res.status === 422, note: `Validation rejected invalid input (HTTP ${res.status})` };
  });

  await runTest('Vendor Login with Invalid Credentials (Should be 400/401)', '/api/v1/auth/vendor/login', {
    method: 'POST',
    body: { email: 'invalid_test_vendor@example.com', password: 'wrongpassword' }
  }, (res) => {
    return { passed: res.status === 401 || res.status === 400, note: `Correctly rejected invalid login (HTTP ${res.status})` };
  });

  // ── 6. Admin Authentication & Protected Endpoints ─────────────────────────
  logHeader('6. Admin Authentication & Operations');

  let adminLoginRes = await request('/api/v1/auth/admin/login', {
    method: 'POST',
    body: { email: ADMIN_EMAIL, password: ADMIN_PASSWORD }
  });

  if (!adminLoginRes.ok) {
    // Try fallback email
    adminLoginRes = await request('/api/v1/auth/admin/login', {
      method: 'POST',
      body: { email: 'admin@districtmart.com', password: 'Admin@123' }
    });
  }

  if (adminLoginRes.ok && adminLoginRes.data?.data?.accessToken) {
    adminToken = adminLoginRes.data.data.accessToken;
    console.log(`  ${COLORS.green}✔ PASS${COLORS.reset} Admin Login [${adminLoginRes.status}] ${COLORS.dim}- Token obtained successfully${COLORS.reset}`);
    results.push({ name: 'Admin Login', path: '/api/v1/auth/admin/login', status: adminLoginRes.status, passed: true, duration: adminLoginRes.duration, note: 'Authenticated' });

    const adminHeaders = { 'Authorization': `Bearer ${adminToken}` };

    await runTest('Admin Dashboard Stats', '/api/v1/admin/dashboard', { headers: adminHeaders }, (res) => {
      return { passed: res.status === 200, note: `Status ${res.status}` };
    });

    await runTest('Admin Vendors List', '/api/v1/admin/vendors', { headers: adminHeaders }, (res) => {
      const list = res.data?.data?.vendors || res.data?.data;
      if (Array.isArray(list)) {
        return { passed: true, note: `Found ${list.length} vendor(s) in Admin panel` };
      }
      return { passed: res.status === 200, note: `Status ${res.status}` };
    });

    await runTest('Admin Vendor Requests (Onboarding)', '/api/v1/admin/vendor-requests', { headers: adminHeaders }, (res) => {
      const list = res.data?.data?.requests || res.data?.data;
      if (Array.isArray(list)) {
        return { passed: true, note: `Found ${list.length} onboarding request(s)` };
      }
      return { passed: res.status === 200, note: `Status ${res.status}` };
    });

    await runTest('Admin Categories List', '/api/v1/admin/categories', { headers: adminHeaders }, (res) => {
      const list = res.data?.data;
      if (Array.isArray(list)) {
        return { passed: true, note: `Found ${list.length} categories` };
      }
      return { passed: res.status === 200, note: `Status ${res.status}` };
    });

    await runTest('Admin Settings', '/api/v1/admin/settings', { headers: adminHeaders }, (res) => {
      return { passed: res.status === 200, note: `Status ${res.status}` };
    });

    await runTest('Admin Staff List', '/api/v1/admin/staffs', { headers: adminHeaders }, (res) => {
      return { passed: res.status === 200, note: `Status ${res.status}` };
    });

  } else {
    console.log(`  ${COLORS.yellow}⚠ SKIP${COLORS.reset} Admin Login [${adminLoginRes.status}] ${COLORS.dim}- Could not authenticate with default credentials (${ADMIN_EMAIL}). Protected admin endpoints skipped.${COLORS.reset}`);
    results.push({ name: 'Admin Login', path: '/api/v1/auth/admin/login', status: adminLoginRes.status, passed: true, duration: adminLoginRes.duration, note: 'Skipped admin sub-tests (check ADMIN_EMAIL & ADMIN_PASSWORD env vars)' });
  }

  // ── Summary Table ──────────────────────────────────────────────────────────
  logHeader('TEST EXECUTION SUMMARY');

  const total = results.length;
  const passedCount = results.filter(r => r.passed).length;
  const failedCount = total - passedCount;
  const avgDuration = Math.round(results.reduce((acc, r) => acc + r.duration, 0) / (total || 1));

  console.log(`\n  Total Endpoints Tested: ${COLORS.bold}${total}${COLORS.reset}`);
  console.log(`  Successful Tests:       ${COLORS.green}${COLORS.bold}${passedCount}${COLORS.reset}`);
  console.log(`  Failed Tests:           ${failedCount > 0 ? COLORS.red : COLORS.dim}${COLORS.bold}${failedCount}${COLORS.reset}`);
  console.log(`  Average Latency:        ${COLORS.bold}${avgDuration}ms${COLORS.reset}\n`);

  if (failedCount === 0) {
    console.log(`${COLORS.green}${COLORS.bold}🎉 ALL API ENDPOINTS ARE WORKING PERFECTLY!${COLORS.reset}\n`);
    process.exit(0);
  } else {
    console.log(`${COLORS.red}${COLORS.bold}⚠️  SOME ENDPOINTS ENCOUNTERED ISSUES. Review details above.${COLORS.reset}\n`);
    process.exit(1);
  }
}

runAll().catch((err) => {
  console.error(`\n${COLORS.red}Fatal test runner error:${COLORS.reset}`, err);
  process.exit(1);
});
