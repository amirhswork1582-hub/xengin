# Example: Secure Backend API Implementation

This example demonstrates how Xengin implements a high-risk backend API endpoint with tenant scoping, mass assignment protection, atomic transaction, and out-of-transaction durable side effects.

---

## User Prompt

> "Add an endpoint `PATCH /api/tenants/:id` where team admins can update their company name and support email. When updated, log the change and notify the team members."

---

## Xengin 10-Step Execution

### 1. Classification & Risk Assessment
- **Scope**: Backend (`Node.js` / `TypeScript` / `Prisma` / `Express`).
- **Risk Level**: High (Multi-tenant boundary, security boundary, authorization check).

### 2. Pre-flight Discovery
- Inspect existing authentication middleware in `backend/src/middleware/auth.ts`: discovers `authenticate` middleware and `req.user.tenantId`.
- Inspect existing validation schema library: discovers `zod`.
- Invariant: NEVER invent middleware names like `requireAdmin` or bypass `tenantId` checks.

### 3. Implementation Patterns

#### Invariant A: Strict Tenant Scoping & IDOR Immunity
Never rely on route parameter `:id` without verifying tenant ownership:

```typescript
import { Router, Response } from 'express';
import { z } from 'zod';
import { authenticate, AuthenticatedRequest } from '../middleware/auth';
import { prisma } from '../lib/prisma';

const router = Router();

const updateTenantSchema = z.object({
  name: z.string().min(2).max(100).optional(),
  supportEmail: z.string().email().optional(),
}).strict(); // Disallow unknown fields

router.patch('/tenants/:id', authenticate, async (req: AuthenticatedRequest, res: Response) => {
  const { id } = req.params;

  // IDOR & Scope Protection: User can only modify their own tenant
  if (req.user.tenantId !== id || req.user.role !== 'ADMIN') {
    return res.status(403).json({ error: 'Forbidden: Insufficient tenant permissions' });
  }

  const parseResult = updateTenantSchema.safeParse(req.body);
  if (!parseResult.success) {
    return res.status(400).json({ errors: parseResult.error.flatten() });
  }

  const { name, supportEmail } = parseResult.data;

  // Atomicity: Database mutations inside transaction
  const updatedTenant = await prisma.$transaction(async (tx) => {
    const tenant = await tx.tenant.update({
      where: { id },
      data: {
        ...(name && { name }),
        ...(supportEmail && { supportEmail }),
      },
    });

    await tx.activityLog.create({
      data: {
        tenantId: id,
        userId: req.user.id,
        action: 'TENANT_SETTINGS_UPDATED',
      },
    });

    return tenant;
  });

  // Durable Side Effect: External notification dispatched OUTSIDE the DB transaction
  await notificationService.queueTenantUpdateNotification({
    tenantId: id,
    updatedBy: req.user.id,
  });

  return res.json({
    id: updatedTenant.id,
    name: updatedTenant.name,
    supportEmail: updatedTenant.supportEmail,
  });
});
```

### 4. Final Enforcement Gate Self-Audit
- [x] **Authentication**: Verified mounted with `authenticate`.
- [x] **Authorization**: Restricted to `req.user.tenantId === id` and `ADMIN` role.
- [x] **Mass Assignment**: Stripped via `z.object().strict()`; raw `req.body` never passed to ORM.
- [x] **Atomicity**: Tenant update and activity log wrapped in `prisma.$transaction`.
- [x] **Side Effects**: Notification queued outside the database transaction.
- [x] **Data Safety**: No internal tokens or password hashes in response.

### 5. Risk-Proportional Verification
- Mandatory behavioral feature tests:
  1. `401 Unauthorized` for unauthenticated requests.
  2. `403 Forbidden` when attempting to edit a different tenant's ID (cross-tenant IDOR negative path).
  3. `400 Bad Request` on invalid payload or unexpected fields.
  4. `200 OK` on valid payload with atomic log entry verified in test DB.
