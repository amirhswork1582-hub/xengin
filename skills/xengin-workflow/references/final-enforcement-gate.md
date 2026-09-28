# Final Enforcement Gate v2 (Generic & Risk-Based)

The **Final Enforcement Gate** is a mandatory self-inspection audit executed before declaring any software task complete. It prevents regressions, security vulnerabilities, and architectural drift from reaching production.

> **Guiding Principle:** Rules are risk controls, not dogmatic checklists. Apply gates proportionally to the actual risk of the task.

---

## 1. Security & Input Boundaries

For every new or modified route, controller, API endpoint, or public action:
- [ ] **Authentication Verified**: Route is mounted behind the project's actual authentication mechanism (discovered from existing routes/middleware, never invented).
- [ ] **Authorization & Scope**: Access to user-owned or tenant-owned resources is strictly scoped to the authenticated identity (`req.user.id`, `$request->user()->id`, `tenant_id`).
- [ ] **No IDOR / BOLA**: Client cannot modify or view another entity's data simply by tampering with an ID parameter in the URL or payload.
- [ ] **Input Validation**: Boundaries are guarded by schema or request validation (Zod, Joi, FormRequest, Pydantic, etc.).
- [ ] **No Mass Assignment**: Payloads are strictly whitelisted or mapped to DTOs; never pass raw unvalidated request bodies directly to ORM persistence methods (`Model::create($request->all())` or `prisma.update({ data: req.body })`).
- [ ] **Response Sanitization**: Internal secrets, password hashes, foreign tenant data, and sensitive tokens are stripped from all API responses.

---

## 2. Data Integrity & Concurrency

For operations involving multiple data mutations or shared state:
- [ ] **Transactional Atomicity**: Dependent database writes that represent a cohesive business operation MUST be wrapped in a database transaction with full rollback on failure.
- [ ] **Concurrency & Lock Ordering**: In concurrency-sensitive multi-row writes (e.g. inventory decrements, balance updates), employ an appropriate concurrency control strategy (such as deterministic lock acquisition order or optimistic locking) to mitigate deadlock risks.
- [ ] **Side Effect Isolation**: External network calls (SMS, Email, Webhooks, Push Notifications, third-party payment calls) MUST NOT be executed inside database transactions. Complete DB commit first, then execute or dispatch side effects.
- [ ] **Zero Downtime Migrations**: Database schema modifications with existing data must follow Expand-Migrate-Contract. Avoid destructive column renames or locks on live production tables.

---

## 3. Frontend Architecture & Reactivity

For user interfaces and client-side logic:
- [ ] **State Ownership**:
  - *URL State*: Applied only when state should survive page refresh, browser back/forward navigation, or link sharing (e.g., active filters, search queries, pagination).
  - *Local State*: Transient UI state (e.g., dropdown expanded, modal open) remains in local component state.
- [ ] **Compute, Don't Sync**: Derived values (filtered arrays, counts, computed totals) must be computed during render or memoized with `useMemo`. Never duplicate them into `useState` synchronized via `useEffect`.
- [ ] **`useEffect` Justification**: Effects must only be used for true external system synchronization (subscriptions, DOM measurement, external APIs). No `useEffect` chains for state synchronization.
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
  - High-risk operations (auth, payment, inventory, state transitions) verified with automated behavioral tests for both success and negative paths (401 unauth, 403 forbidden, atomic rollback on failure).
- [ ] **Diff Cleanliness**: Git diff inspected for unintended changes or stray files.
