import { prisma } from '../../lib/prisma.js';

export interface NotificationPayload {
  customerId?: string;
  vendorId?: string;
  type: string;
  title: string;
  body: string;
  data?: Record<string, any>;
  channels?: Array<'IN_APP' | 'EMAIL' | 'WHATSAPP' | 'PUSH'>;
}

export async function sendNotification(payload: NotificationPayload) {
  const { customerId, vendorId, type, title, body, data } = payload;

  // 1. Create In-App Notification entry in DB
  const notif = await prisma.notification.create({
    data: {
      customerId: customerId || null,
      vendorId: vendorId || null,
      type,
      title,
      body,
      data: data ? (data as any) : null,
      isRead: false,
    },
  });

  // 2. Multi-channel dispatching simulation/adapters
  const channels = payload.channels || ['IN_APP', 'EMAIL', 'PUSH', 'WHATSAPP'];
  
  if (channels.includes('EMAIL')) {
    console.log(`[Notification Engine - EMAIL] Sent to ${customerId ? 'Customer ' + customerId : 'Vendor ' + vendorId}: "${title}" - ${body}`);
  }
  if (channels.includes('WHATSAPP')) {
    console.log(`[Notification Engine - WHATSAPP] Sent to ${customerId ? 'Customer ' + customerId : 'Vendor ' + vendorId}: "${title}" - ${body}`);
  }
  if (channels.includes('PUSH')) {
    console.log(`[Notification Engine - PUSH] Sent to ${customerId ? 'Customer ' + customerId : 'Vendor ' + vendorId}: "${title}" - ${body}`);
  }

  return notif;
}

// ─── Preset Multi-Party Workflow Triggers ───────────────────────────────────

export async function notifyVendorProductSubmitted(vendorId: string, productName: string) {
  await sendNotification({
    vendorId,
    type: 'PRODUCT_SUBMITTED',
    title: '📦 Product Submitted for Approval',
    body: `Your product "${productName}" has been submitted and is currently in review by Super Admin.`,
  });
}

export async function notifyVendorProductApproved(vendorId: string, productName: string) {
  await sendNotification({
    vendorId,
    type: 'PRODUCT_APPROVED',
    title: '✅ Product Approved',
    body: `Congratulations! Your product "${productName}" has been approved and is now live for customers.`,
  });
}

export async function notifyVendorProductRejected(vendorId: string, productName: string, reason: string) {
  await sendNotification({
    vendorId,
    type: 'PRODUCT_REJECTED',
    title: '❌ Product Rejected',
    body: `Your product "${productName}" was not approved. Reason: ${reason}`,
  });
}

export async function notifyNewOrderPlaced(order: any) {
  // Notify Customer
  await sendNotification({
    customerId: order.customerId,
    type: 'ORDER_PLACED',
    title: '🎉 Order Confirmed!',
    body: `Your order #${order.orderNumber} has been placed successfully.`,
    data: { orderId: order.id },
  });

  // Notify Vendor
  await sendNotification({
    vendorId: order.vendorId,
    type: 'NEW_ORDER',
    title: '🔔 New Order Received!',
    body: `You received a new order #${order.orderNumber} for ₹${order.grandTotal}. Please accept and pack it.`,
    data: { orderId: order.id },
  });
}

export async function notifyOrderStatusChanged(order: any, newStatus: string) {
  const statusMessages: Record<string, string> = {
    ACCEPTED: 'Your order has been accepted by the store.',
    PREPARING: 'Your order is being prepared.',
    PACKED: 'Your order has been packed and is ready for pickup.',
    OUT_FOR_DELIVERY: 'Your order is out for delivery!',
    DELIVERED: 'Your order has been delivered! Thank you for shopping with us.',
    CANCELLED: 'Your order has been cancelled.',
    RETURNED: 'Your order return has been processed.',
  };

  const message = statusMessages[newStatus] || `Your order status has been updated to ${newStatus}`;

  // Notify Customer
  await sendNotification({
    customerId: order.customerId,
    type: `ORDER_${newStatus}`,
    title: `Order #${order.orderNumber} Update`,
    body: message,
    data: { orderId: order.id, status: newStatus },
  });
}

export async function notifySettlementGenerated(settlement: any) {
  await sendNotification({
    vendorId: settlement.vendorId,
    type: 'SETTLEMENT_GENERATED',
    title: '💰 Weekly Settlement Generated',
    body: `Settlement #${settlement.settlementNo} for ₹${settlement.netAmount} has been generated and queued for payout.`,
    data: { settlementId: settlement.id },
  });
}
