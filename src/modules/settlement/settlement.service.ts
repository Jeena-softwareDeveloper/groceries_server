import { prisma } from '../../lib/prisma.js';
import { NotFoundError, ValidationError } from '../../utils/errors.js';
import { createAuditLog } from '../audit/audit.service.js';
import { notifySettlementGenerated, sendNotification } from '../notification/notification.service.js';

export async function generateVendorSettlement(vendorId: string, startDate?: Date, endDate?: Date) {
  const periodEnd = endDate || new Date();
  const periodStart = startDate || new Date(periodEnd.getTime() - 7 * 24 * 60 * 60 * 1000); // last 7 days

  const existingSettlements = await prisma.vendorSettlement.findMany({
    where: { vendorId, status: { in: ['PENDING', 'APPROVED'] } },
    select: { periodStart: true, periodEnd: true },
  });

  const deliveredOrders = await prisma.order.findMany({
    where: {
      vendorId,
      status: 'DELIVERED',
      settlementId: null,
      deliveredAt: {
        gte: periodStart,
        lte: periodEnd,
      },
    },
  });

  if (deliveredOrders.length === 0) {
    throw new ValidationError('No eligible delivered orders found for settlement in this time period.');
  }

  const totalOrders = deliveredOrders.length;
  const grossAmount = deliveredOrders.reduce((sum, o) => sum + Number(o.grandTotal), 0);

  const commissionRate = 0.05; // 5% platform commission
  const commissionAmount = grossAmount * commissionRate;
  const gstRate = 0.18; // 18% GST on platform commission
  const gstAmount = commissionAmount * gstRate;
  const platformFee = 0; // standard platform fee
  const netAmount = grossAmount - (commissionAmount + gstAmount + platformFee);

  const settlementNo = `SETL-${Date.now().toString(36).toUpperCase()}-${Math.floor(100 + Math.random() * 900)}`;

  const settlement = await prisma.vendorSettlement.create({
    data: {
      vendorId,
      settlementNo,
      periodStart,
      periodEnd,
      totalOrders,
      grossAmount,
      commissionAmount,
      gstAmount,
      platformFee,
      netAmount,
      status: 'PENDING',
    },
  });

  await prisma.order.updateMany({
    where: { id: { in: deliveredOrders.map(o => o.id) } },
    data: { settlementId: settlement.id },
  });

  await createAuditLog({
    actorType: 'SYSTEM',
    action: 'SETTLEMENT_GENERATED',
    entityType: 'SETTLEMENT',
    entityId: settlement.id,
    details: { settlementNo, grossAmount, netAmount, totalOrders, vendorId },
  });

  await notifySettlementGenerated(settlement);

  return settlement;
}

export async function listSettlements(vendorId?: string, status?: string, page = 1, limit = 20) {
  const skip = (page - 1) * limit;
  const where: any = {};
  if (vendorId) where.vendorId = vendorId;
  if (status) where.status = status;

  const [items, total] = await Promise.all([
    prisma.vendorSettlement.findMany({
      where,
      skip,
      take: limit,
      orderBy: { createdAt: 'desc' },
    }),
    prisma.vendorSettlement.count({ where }),
  ]);

  return { items, total, page, limit };
}

export async function approveSettlement(settlementId: string, adminId: string, bankReference?: string) {
  const settlement = await prisma.vendorSettlement.findUnique({ where: { id: settlementId } });
  if (!settlement) throw new NotFoundError('Settlement not found');
  if (settlement.status !== 'PENDING') throw new ValidationError('Settlement is not in PENDING state.');

  const updatedSettlement = await prisma.vendorSettlement.update({
    where: { id: settlementId },
    data: {
      status: 'APPROVED',
      bankReference: bankReference || `BANK-TXN-${Date.now()}`,
      approvedBy: adminId,
      approvedAt: new Date(),
      paidAt: new Date(),
    },
  });

  // Update Vendor Wallet
  const wallet = await prisma.vendorWallet.upsert({
    where: { vendorId: settlement.vendorId },
    create: {
      vendorId: settlement.vendorId,
      balance: settlement.netAmount,
      totalEarned: settlement.netAmount,
    },
    update: {
      balance: { increment: settlement.netAmount },
      totalEarned: { increment: settlement.netAmount },
    },
  });

  // Write Ledger Transaction
  await prisma.vendorWalletTransaction.create({
    data: {
      vendorId: settlement.vendorId,
      settlementId: settlement.id,
      type: 'CREDIT',
      amount: settlement.netAmount,
      balanceAfter: wallet.balance,
      description: `Settlement #${settlement.settlementNo} payout credited to wallet.`,
      reference: bankReference || `BANK-TXN-${Date.now()}`,
    },
  });

  await createAuditLog({
    actorType: 'SUPER_ADMIN',
    actorId: adminId,
    action: 'SETTLEMENT_APPROVED',
    entityType: 'SETTLEMENT',
    entityId: settlement.id,
    details: { netAmount: Number(settlement.netAmount), bankReference },
  });

  await sendNotification({
    vendorId: settlement.vendorId,
    type: 'SETTLEMENT_PAID',
    title: '💸 Payout Credited!',
    body: `Settlement #${settlement.settlementNo} of ₹${settlement.netAmount} has been approved and credited to your account.`,
  });

  return updatedSettlement;
}

export async function rejectSettlement(settlementId: string, adminId: string, reason: string) {
  const settlement = await prisma.vendorSettlement.findUnique({ where: { id: settlementId } });
  if (!settlement) throw new NotFoundError('Settlement not found');

  const updated = await prisma.vendorSettlement.update({
    where: { id: settlementId },
    data: {
      status: 'REJECTED',
      rejectionReason: reason,
      approvedBy: adminId,
      approvedAt: new Date(),
    },
  });

  await createAuditLog({
    actorType: 'SUPER_ADMIN',
    actorId: adminId,
    action: 'SETTLEMENT_REJECTED',
    entityType: 'SETTLEMENT',
    entityId: settlement.id,
    details: { reason },
  });

  return updated;
}
