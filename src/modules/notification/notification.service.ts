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

/**
 * Dispatches push notifications to Expo Push Service
 */
export async function sendExpoPushNotifications(
  tokens: string[],
  title: string,
  body: string,
  data?: Record<string, any>
) {
  const validTokens = [...new Set(tokens.filter((t) => typeof t === 'string' && t.trim().length > 0))];
  if (validTokens.length === 0) return;

  const messages = validTokens.map((token) => ({
    to: token,
    sound: 'default',
    title,
    body,
    data: data || {},
    priority: 'high',
    channelId: 'default',
  }));

  try {
    const res = await fetch('https://exp.host/--/api/v2/push/send', {
      method: 'POST',
      headers: {
        'Accept': 'application/json',
        'Accept-Encoding': 'gzip, deflate',
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(messages),
    });
    const result = await res.json();
    console.log(`[Push Notification] Dispatched to ${validTokens.length} device(s):`, JSON.stringify(result));
    return result;
  } catch (err) {
    console.error('[Push Notification] Failed to send via Expo:', err);
  }
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

  // 2. Multi-channel dispatching
  const channels = payload.channels || ['IN_APP', 'PUSH'];

  if (channels.includes('PUSH')) {
    const pushTokens: string[] = [];

    // Find customer push tokens
    if (customerId) {
      const customer = await (prisma as any).customer.findUnique({
        where: { id: customerId },
        select: { pushToken: true },
      });
      if (customer?.pushToken) pushTokens.push(customer.pushToken);

      // Also check device locations associated with customer
      const deviceLocations = await (prisma as any).deviceLocation.findMany({
        where: { customerId, pushToken: { not: null } },
        select: { pushToken: true },
      });
      for (const dl of deviceLocations) {
        if (dl.pushToken) pushTokens.push(dl.pushToken);
      }
    }

    // Find vendor push tokens
    if (vendorId) {
      const vendor = await (prisma as any).vendor.findUnique({
        where: { id: vendorId },
        select: { pushToken: true },
      });
      if (vendor?.pushToken) pushTokens.push(vendor.pushToken);
    }

    if (pushTokens.length > 0) {
      await sendExpoPushNotifications(pushTokens, title, body, {
        notificationId: notif.id,
        type,
        ...(data || {}),
      });
    } else {
      console.log(`[Notification Engine - PUSH] No registered push tokens for ${customerId ? 'Customer ' + customerId : 'Vendor ' + vendorId}`);
    }
  }

  if (channels.includes('EMAIL')) {
    console.log(`[Notification Engine - EMAIL] Sent: "${title}" - ${body}`);
  }
  if (channels.includes('WHATSAPP')) {
    console.log(`[Notification Engine - WHATSAPP] Sent: "${title}" - ${body}`);
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
  // 1. Notify Customer
  await sendNotification({
    customerId: order.customerId,
    type: 'ORDER_PLACED',
    title: '🎉 Order Placed Successfully!',
    body: `Your order #${order.orderNumber} for ₹${Number(order.grandTotal).toFixed(0)} has been placed. We will notify you once confirmed.`,
    data: { orderId: order.id, orderNumber: order.orderNumber },
  });

  // 2. Notify Vendor
  await sendNotification({
    vendorId: order.vendorId,
    type: 'NEW_ORDER',
    title: '🔔 New Order Received!',
    body: `You received a new order #${order.orderNumber} for ₹${Number(order.grandTotal).toFixed(0)}. Please accept and pack it.`,
    data: { orderId: order.id, orderNumber: order.orderNumber },
  });
}

export async function notifyOrderStatusChanged(order: any, newStatus: string) {
  const statusConfig: Record<string, { title: string; message: string }> = {
    CONFIRMED: {
      title: '✅ Order Confirmed!',
      message: `The store has confirmed your order #${order.orderNumber}. It is now being processed.`,
    },
    PACKED: {
      title: '📦 Order Packed!',
      message: `Your order #${order.orderNumber} has been packed and is ready for pickup/delivery.`,
    },
    OUT_FOR_DELIVERY: {
      title: '🚀 Out for Delivery!',
      message: `Your order #${order.orderNumber} is on the way to your delivery address!`,
    },
    DELIVERED: {
      title: '🎉 Order Delivered!',
      message: `Your order #${order.orderNumber} has been delivered. Thank you for shopping with us!`,
    },
    CANCELLED: {
      title: '❌ Order Cancelled',
      message: `Your order #${order.orderNumber} has been cancelled.`,
    },
    RETURNED: {
      title: '↩️ Order Returned',
      message: `Your order #${order.orderNumber} return has been processed.`,
    },
  };

  const config = statusConfig[newStatus] || {
    title: `Order #${order.orderNumber} Update`,
    message: `Your order status has been updated to ${newStatus}.`,
  };

  // Notify Customer
  await sendNotification({
    customerId: order.customerId,
    type: `ORDER_${newStatus}`,
    title: config.title,
    body: config.message,
    data: { orderId: order.id, orderNumber: order.orderNumber, status: newStatus },
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
