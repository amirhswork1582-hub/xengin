# Final Enforcement Gate v2 (Generic & Risk-Based)

The **Final Enforcement Gate** is a mandatory self-inspection audit executed before declaring any software task complete. It prevents regressions, security vulnerabilities, and architectural drift from reaching production.

> **Guiding Principle:** Rules are risk controls, not dogmatic checklists. Apply gates proportionally to the actual risk and domain of the task.

---

## 1. Security & Input Boundaries

For every new or modified route, controller, API endpoint, or public action:
- [ ] **Endpoint Intent & Authentication**:
  - *Public Endpoints* (e.g. login, registration, public health check, webhooks, guest catalog): Explicitly verify that public access is intended and that no private tenant or user-scoped data is exposed without authorization.
  - *Protected Endpoints*: Route is mounted behind the project's actual authentication mechanism (discovered by inspecting existing routes/middleware, never invented).
- [ ] **Authorization & Scope**: Access to user-owned or tenant-owned resources is strictly scoped to the authenticated identity (`req.user.id`, `$request->user()->id`, `tenant_id`).
- [ ] **No IDOR / BOLA**: Client cannot modify or view another entity's data simply by tampering with an ID parameter in the URL or payload.
- [ ] **Input Validation**: Boundaries are guarded by schema or request validation (Zod, Joi, FormRequest, Pydantic, etc.).
- [ ] **No Mass Assignment**: Payloads are strictly whitelisted or mapped to DTOs; never pass raw unvalidated request bodies directly to ORM persistence methods (`Model::create($request->all())` or `prisma.update({ data: req.body })`).
- [ ] **Response Sanitization**: Internal secrets, password hashes, foreign tenant data, and sensitive tokens are stripped from all API responses.

---

## 2. Data Integrity & Concurrency

For operations involving multiple data mutations, database schema, or external communication:
- [ ] **Transactional Atomicity**: Dependent database writes that represent a cohesive business operation MUST be wrapped in a database transaction with full rollback on failure.
- [ ] **Concurrency & Lock Ordering**: In concurrency-sensitive multi-row writes (e.g. inventory decrements, balance updates), employ an appropriate concurrency control strategy (such as deterministic lock acquisition order or optimistic locking) to mitigate deadlock risks.
- [ ] **Side Effect Isolation & Delivery Safety**:
  - External network calls (SMS, Email, Webhooks, Push Notifications, third-party payment calls) MUST NOT be executed inside database transactions. Complete DB commit first, then execute or dispatch side effects.
  - *Business-Critical Side Effects* (e.g., invitations, order confirmations, billing webhooks): Must use durable delivery mechanisms (outbox table, durable queue, or database status flag) so failed attempts can be retried without losing intent.
  - *Non-Critical Side Effects* (e.g., analytics, telemetry, cache warm): Transient fire-and-forget with non-blocking error handling is acceptable.
- [ ] **Database Migrations (Expand-Migrate-Contract)**:
  - *Production / Zero-Downtime*: Modifying existing schemas with active traffic or distributed consumers must follow the Expand-Migrate-Contract pattern. Avoid destructive column renames or locks on live tables.
  - *Greenfield / Isolated Development*: For brand-new tables or local isolated setups, direct migrations are permissible if documented.

---

## 3. Frontend Architecture & Reactivity

For user interfaces and client-side logic:
- [ ] **State Taxonomy**:
  - *Navigable / Shareable UI State* (filters, search queries, pagination, active tab): MUST live in URL query/params as the single source of truth.
  - *Private Persistent Client State* (theme preference, collapsed sidebar, dismissed announcements): Stored in client storage (`localStorage` or cookies).
  - *Transient UI State* (dropdown open, modal open/close, hover state, local form input): Managed via local component state (`useState`).
  - *Derived Values* (filtered lists, item counts, computed sums): Computed during render or memoized with `useMemo`. Never duplicate into `useState` synchronized via `useEffect`.
- [ ] **`useEffect` Justification**: Effects must only be used for true external system synchronization (subscriptions, DOM measurement, external non-React widgets). Zero `useEffect` chains for state synchronization.
- [ ] **Shared Component Safety**: When modifying shared components, verify existing consumers and ensure changes are backward-compatible.
- [ ] **Component Lifecycle Hygiene**: Do not define components or hooks inside other component render bodies.

---

## 4. Code Hygiene & Observability

Across all modified files:
- [ ] **Type Safety**: No introduced `any`, `@ts-ignore`, or suppressions unless accompanied by explicit technical justification.
- [ ] **Debug Artifacts Removed**: Temporary debug logs (`console.log`, `dd()`, `dump()`) removed. Persistent logging follows the project's structured logging convention.
- [ ] **No Unfinished Stubs**: No empty catch blocks, placeholder TODO/FIXME comments replacing actual implementations.
- [ ] **Syntax & Template Integrity**: Ensure JSX templates, classNames, and string interpolations are syntactically valid and quote-closed.

---

## 5. Verification Protocol

- [ ] **Executable Verification**: Build or syntax checks run and verified (`npm run build`, `php -l`, `tsc --noEmit`).
- [ ] **Risk-Proportional Tests**:
  - High-risk operations verified with automated behavioral tests for both success and domain-appropriate negative paths (unauthenticated 401, unauthorized 403, atomic rollback on failure, insufficient balance/stock rejection).
- [ ] **Diff Cleanliness**: Git diff inspected for unintended changes or stray files.
