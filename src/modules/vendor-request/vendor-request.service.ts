import { prisma } from '../../lib/prisma.js';
import { AppError, NotFoundError } from '../../utils/errors.js';
import bcrypt from 'bcryptjs';

type VendorRequestStatus = 'DRAFT' | 'PENDING' | 'MORE_INFO_REQUIRED' | 'APPROVED' | 'REJECTED';

export async function getMyRequest(customerId: string) {
  return prisma.vendorRequest.findFirst({
    where: { customerId },
    orderBy: { createdAt: 'desc' },
    include: { district: { select: { id: true, name: true } }, area: { select: { id: true, name: true } } },
  });
}

export async function upsertDraft(customerId: string, data: Record<string, unknown>) {
  const cleanData = { ...data };
  if (cleanData.districtId === '') cleanData.districtId = null;
  if (cleanData.areaId === '') cleanData.areaId = null;

  const restrictedFields = [
    'id', 'customerId', 'status', 'createdAt', 'updatedAt',
    'district', 'area', 'customer', 'adminRemarks', 'rejectionReason',
    'reviewedBy', 'reviewedAt', 'submittedAt'
  ];
  restrictedFields.forEach(f => delete cleanData[f]);


  const existing = await prisma.vendorRequest.findFirst({
    where: { customerId, status: { in: ['DRAFT', 'MORE_INFO_REQUIRED'] } },
  });
  if (existing) {
    return prisma.vendorRequest.update({ where: { id: existing.id }, data: cleanData });
  }
  const blocking = await prisma.vendorRequest.findFirst({
    where: { customerId, status: { in: ['PENDING', 'APPROVED'] } },
  });
  if (blocking) {
    throw new AppError('CONFLICT', `Your application is already ${blocking.status.toLowerCase()}. You cannot submit a new one.`, 409);
  }
  return prisma.vendorRequest.create({ data: { customerId, ...cleanData } });
}

export async function submitApplication(customerId: string) {
  const request = await prisma.vendorRequest.findFirst({
    where: { customerId, status: { in: ['DRAFT', 'MORE_INFO_REQUIRED'] } },
  });
  if (!request) throw new NotFoundError('No draft application found');

  // Check if customer already has a vendor account
  const existingVendorByCustomer = await prisma.vendor.findUnique({ where: { customerId } });
  if (existingVendorByCustomer) {
    throw new AppError('BAD_REQUEST', 'You already have an active Vendor account.', 400);
  }

  // Check if email is already used by another vendor
  const vendorEmail = request.email ?? `vendor_${request.id}@districtmart.com`;
  const existingVendorByEmail = await prisma.vendor.findUnique({ where: { email: vendorEmail } });
  if (existingVendorByEmail) {
    throw new AppError('BAD_REQUEST', 'The email associated with this request is already used by another vendor.', 400);
  }

  const required = ['shopName', 'ownerName', 'mobileNumber', 'address', 'shopCategory', 'accountHolderName', 'accountNumber', 'ifscCode'];
  const missing = required.filter((k) => !request[k as keyof typeof request]);
  if (missing.length) throw new AppError('VALIDATION_ERROR', `Missing required fields: ${missing.join(', ')}`, 422);

  const mobile = String(request.mobileNumber ?? '').replace(/\D/g, '');
  if (!/^[6-9]\d{9}$/.test(mobile)) {
    throw new AppError('VALIDATION_ERROR', 'Enter a valid 10-digit Indian mobile number', 422);
  }

  const ifsc = String(request.ifscCode ?? '').trim().toUpperCase();
  if (!/^[A-Z]{4}0[A-Z0-9]{6}$/.test(ifsc)) {
    throw new AppError('VALIDATION_ERROR', 'Enter a valid IFSC code', 422);
  }

  const accountNumber = String(request.accountNumber ?? '').replace(/\s/g, '');
  if (!/^\d{9,18}$/.test(accountNumber)) {
    throw new AppError('VALIDATION_ERROR', 'Enter a valid bank account number (9-18 digits)', 422);
  }



  const updatedReq = await prisma.vendorRequest.update({
    where: { id: request.id },
    data: {
      status: 'PENDING',
      submittedAt: new Date(),
      adminRemarks: null,
      mobileNumber: mobile,
      ifscCode: ifsc,
      accountNumber,
    },
  });

  // Auto-approve if the feature flag requires NO manual approval
  const { getSettings } = await import('../admin/settings/settings.service.js');
  const settings = await getSettings();
  const featureFlags = settings.featureFlags as Record<string, boolean>;
  if (featureFlags && featureFlags.vendorApprovalRequired === false) {
    // We must call approveRequest. We also need an adminId, but since it's system auto-approve, we use 'SYSTEM'
    await approveRequest(request.id, 'SYSTEM_AUTO_APPROVE').catch(e => console.error('Auto approve failed', e));
  }

  return updatedReq;
}

// ─── Admin-facing service ──────────────────────────────────────────────────────

export async function listRequests(status?: string, page = 1, limit = 20) {
  const skip = (page - 1) * limit;
  const where = status ? { status: status as VendorRequestStatus } : {};
  const [items, total] = await Promise.all([
    prisma.vendorRequest.findMany({
      where,
      skip,
      take: limit,
      orderBy: { createdAt: 'desc' },
      include: {
        customer: { select: { id: true, name: true, phone: true, email: true } },
        district: { select: { id: true, name: true } },
        area: { select: { id: true, name: true } },
      },
    }),
    prisma.vendorRequest.count({ where }),
  ]);
  return { items, total, page, limit };
}

export async function getRequest(id: string) {
  const req = await prisma.vendorRequest.findUnique({
    where: { id },
    include: {
      customer: { select: { id: true, name: true, phone: true, email: true } },
      district: { select: { id: true, name: true } },
      area: { select: { id: true, name: true } },
    },
  });
  if (!req) throw new NotFoundError('Vendor request not found');
  return req;
}

export async function approveRequest(id: string, adminId: string) {
  const req = await getRequest(id);
  if (req.status !== 'PENDING') throw new AppError('BAD_REQUEST', 'Only PENDING requests can be approved', 400);

  // Check if customer already has a vendor account
  const existingVendorByCustomer = await prisma.vendor.findUnique({ where: { customerId: req.customerId } });
  if (existingVendorByCustomer) {
    throw new AppError('BAD_REQUEST', 'This customer already has an active Vendor account.', 400);
  }

  // Check if email is already used by another vendor
  const vendorEmail = req.email ?? `vendor_${id}@districtmart.com`;
  const existingVendorByEmail = await prisma.vendor.findUnique({ where: { email: vendorEmail } });
  if (existingVendorByEmail) {
    throw new AppError('BAD_REQUEST', 'The email associated with this request is already used by another vendor.', 400);
  }

  // Generate a temporary password for the vendor
  const tempPassword = Math.random().toString(36).slice(-8) + 'V@1';
  const passwordHash = await bcrypt.hash(tempPassword, 10);

  // Build a unique slug from shop name
  const baseSlug = (req.shopName ?? 'shop').toLowerCase().replace(/[^a-z0-9]+/g, '-');
  let slug = baseSlug;
  let counter = 1;
  while (await prisma.vendor.findUnique({ where: { slug } })) {
    slug = `${baseSlug}-${counter++}`;
  }

  // Find area with district
  let targetDistrictId = req.districtId;
  if (!targetDistrictId) {
    let fallbackDistrict = await prisma.district.findFirst();
    if (!fallbackDistrict) {
      fallbackDistrict = await prisma.district.create({
        data: { name: 'Default District', code: 'DEFAULT' }
      });
    }
    targetDistrictId = fallbackDistrict.id;
  }

  let targetAreaId = req.areaId;
  if (!targetAreaId) {
    let fallbackArea = await prisma.area.findFirst({ where: { districtId: targetDistrictId } });
    if (!fallbackArea) {
      fallbackArea = await prisma.area.create({
        data: { name: 'Main Area', districtId: targetDistrictId, isActive: true }
      });
    }
    targetAreaId = fallbackArea.id;
  }
  const area = await prisma.area.findUnique({ where: { id: targetAreaId }, include: { district: true } });
  if (!area) throw new AppError('BAD_REQUEST', 'Area not found for this request', 400);

  const vendorCode = `VND-${Math.random().toString(36).substring(2, 6).toUpperCase()}`;
  const vendor = await prisma.vendor.create({
    data: {
      areaId: area.id,
      districtId: area.districtId,
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
      approvedBy: adminId,
    },
  });

  // Update the request
  await prisma.vendorRequest.update({
    where: { id },
    data: { status: 'APPROVED', reviewedBy: adminId, reviewedAt: new Date() },
  });

  // Notify the customer — never persist plaintext passwords in notifications
  await prisma.notification.create({
    data: {
      customerId: req.customerId,
      type: 'VENDOR_APPROVED',
      title: 'Vendor Application Approved!',
      body: `Congratulations! Your shop "${req.shopName}" has been approved. Use your registered email to log in to the Vendor Panel. Check your email/SMS for temporary login details.`,
      data: { vendorId: vendor.id },
    },
  });

  // tempPassword returned only to admin API response (send via secure channel once)
  return { vendor, tempPassword };
}

export async function rejectRequest(id: string, adminId: string, reason: string) {
  const req = await getRequest(id);
  if (!['PENDING', 'MORE_INFO_REQUIRED'].includes(req.status)) {
    throw new AppError('BAD_REQUEST', 'Only PENDING or MORE_INFO_REQUIRED requests can be rejected', 400);
  }
  const updated = await prisma.vendorRequest.update({
    where: { id },
    data: { status: 'REJECTED', rejectionReason: reason, reviewedBy: adminId, reviewedAt: new Date() },
  });
  await prisma.notification.create({
    data: {
      customerId: req.customerId,
      type: 'VENDOR_REJECTED',
      title: 'Vendor Application Update',
      body: `Your vendor application for "${req.shopName}" was not approved. Reason: ${reason}`,
      data: { requestId: id },
    },
  });
  return updated;
}

export async function requestMoreInfo(id: string, adminId: string, remarks: string) {
  const req = await getRequest(id);
  if (req.status !== 'PENDING') throw new AppError('BAD_REQUEST', 'Only PENDING requests can be flagged for more info', 400);
  const updated = await prisma.vendorRequest.update({
    where: { id },
    data: { status: 'MORE_INFO_REQUIRED', adminRemarks: remarks, reviewedBy: adminId, reviewedAt: new Date() },
  });
  await prisma.notification.create({
    data: {
      customerId: req.customerId,
      type: 'VENDOR_MORE_INFO',
      title: 'Action Required — Vendor Application',
      body: `More information is needed for your vendor application. Admin note: ${remarks}`,
      data: { requestId: id },
    },
  });
  return updated;
}

export async function getPendingCount() {
  return prisma.vendorRequest.count({ where: { status: 'PENDING' } });
}
