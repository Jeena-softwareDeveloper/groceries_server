import { prisma } from '../../lib/prisma.js';

export interface CreateAuditLogParams {
  actorType: 'SUPER_ADMIN' | 'VENDOR' | 'CUSTOMER' | 'SYSTEM';
  actorId?: string;
  actorName?: string;
  action: string;
  entityType: string;
  entityId: string;
  details?: Record<string, any>;
  ipAddress?: string;
}

export async function createAuditLog(params: CreateAuditLogParams) {
  try {
    return await prisma.auditLog.create({
      data: {
        actorType: params.actorType,
        actorId: params.actorId || null,
        actorName: params.actorName || null,
        action: params.action,
        entityType: params.entityType,
        entityId: params.entityId,
        details: params.details ? (params.details as any) : null,
        ipAddress: params.ipAddress || null,
      },
    });
  } catch (err) {
    console.error('Failed to write audit log:', err);
  }
}

export async function listAuditLogs(
  page = 1,
  limit = 20,
  entityType?: string,
  action?: string,
  search?: string
) {
  const skip = (page - 1) * limit;
  const where: any = {};
  if (entityType) where.entityType = entityType;
  if (action) where.action = action;
  if (search) {
    where.OR = [
      { action: { contains: search, mode: 'insensitive' } },
      { actorName: { contains: search, mode: 'insensitive' } },
      { entityId: { contains: search } },
    ];
  }

  const [items, total] = await Promise.all([
    prisma.auditLog.findMany({
      where,
      skip,
      take: limit,
      orderBy: { createdAt: 'desc' },
    }),
    prisma.auditLog.count({ where }),
  ]);

  return { items, total, page, limit };
}
