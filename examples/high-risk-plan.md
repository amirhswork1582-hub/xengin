# Example: High-Risk Architectural Plan (`/xengin-plan`)

This example demonstrates how Xengin analyzes a complex, high-risk change (zero-downtime database migration and inventory deduction) without modifying code prematurely.

---

## User Prompt

> "/xengin-plan We need to rename `company_name` to `organization_name` in the production accounts table with 5 million records, and add an atomic workshop assembly deduction endpoint that deducts raw materials and increases finished product stock."

---

## Output from `/xengin-plan`

```markdown
# Architectural Implementation Plan: Schema Migration & Assembly Deduction

**Risk Level:** HIGH (Production Data Migration + Financial/Inventory Concurrency)
**Blast Radius:** Multi-service (Auth, Billing, Inventory, ERP, Cardex)

---

### Phase 1: Database Migration (Expand-Migrate-Contract)

Executing `ALTER TABLE accounts RENAME COLUMN` on a 5M row live table causes long-running table locks and breaks running application pods reading `company_name`.

1. **Expand Phase (Non-breaking additive change)**:
   - Migration adds `organization_name VARCHAR(255) NULL`.
   - Update application code to write to BOTH `company_name` and `organization_name` (dual-write).
   - Read with fallback: `organization_name ?? company_name`.
   - Deploy Phase 1 application code.

2. **Migrate Phase (Background Backfill)**:
   - Run chunked background worker/script:
     `UPDATE accounts SET organization_name = company_name WHERE organization_name IS NULL LIMIT 1000;`
   - Monitor replication lag and database CPU load.

3. **Contract Phase (Deprecation & Cleanup)**:
   - Switch application code to read and write exclusively from `organization_name`.
   - After verification period, drop old `company_name` column in a scheduled maintenance window.

---

### Phase 2: Atomic Assembly Deduction Engine

**Concurrency Invariants:**
1. **Deterministic Lock Ordering**: When locking multiple raw materials for deduction (`SELECT ... FOR UPDATE`), sort material IDs deterministically (e.g. `ORDER BY id ASC`) to eliminate deadlock risk between concurrent assemblies.
2. **Atomic Rollback**: If any raw material quantity is insufficient, immediately rollback the entire transaction.
3. **Cardex Ledger Audit**: Every material deduction and finished good addition must record corresponding cardex log entries within the same database transaction.
4. **Side Effect Boundary**: Notifications to workshop managers must be dispatched via a background queue outside the database transaction.

---

### Verification Strategy

- **Negative Path 1**: Insufficient stock test $\rightarrow$ Verify transaction aborts and zero stock or cardex changes persist.
- **Negative Path 2**: Concurrent requests test $\rightarrow$ Verify no negative inventory or deadlock exceptions occur.
- **Contract Test**: Verify old and new application pods can both query accounts concurrently during the migration window.
```
