---
name: xengin-review
description: Audit existing changes, Pull Requests, or Git diffs against security, data integrity, component architecture, and test coverage standards without modifying source code. Use when reviewing code, auditing commits, or checking changes before merge.
---

# Xengin Code Review & Audit Workflow

The user has requested a disciplined engineering audit of code changes or active Git diffs.

> [!IMPORTANT]
> **STRICTLY READ-ONLY:** Do NOT modify application source files during this command unless the user explicitly asks to apply fixes. Provide an objective, prioritized audit report.

---

## 5-Dimension Audit Protocol

Inspect the active Git diff (`git diff HEAD`, `git diff main...HEAD`, or modified files) across these five critical dimensions:

### 1. Security & Authorization Boundaries
- [ ] Route authentication verified: route is mounted behind the project's actual auth middleware (*references/final-enforcement-gate.md*).
- [ ] Tenant & user isolation: resource access is scoped to authenticated identity (`req.user.id`, `tenant_id`). Zero IDOR vulnerabilities.
- [ ] Input validation: boundaries guarded by explicit schema validation (Zod, Joi, FormRequest).
- [ ] No mass assignment: unvalidated payloads are never passed directly to database persistence methods.
- [ ] Response sanitization: internal secrets, password hashes, and sensitive tokens are excluded from API responses.

### 2. Data Integrity & Concurrency
- [ ] Transactional atomicity: multi-step dependent writes are wrapped in DB transactions with rollback on failure.
- [ ] Lock ordering & race conditions: concurrent writes use deterministic ordering or optimistic locking.
- [ ] Side effect isolation: network calls (SMS, Email, Webhooks) are executed **outside** database transactions.
- [ ] Durable delivery: business-critical notifications use reliable queues/outbox tables.

### 3. Frontend Architecture & Reactivity
- [ ] State taxonomy: shareable state in URL; transient UI state in local state; derived values computed inline (`useMemo`).
- [ ] Zero state-sync `useEffect` chains: effects used solely for external system synchronization.
- [ ] Shared component safety: existing consumers checked before altering shared component signatures.

### 4. Code Hygiene & Observability
- [ ] Type safety: no introduced `any`, `@ts-ignore`, or unsafe type assertions.
- [ ] Zero debug artifacts: temporary logs, `dump()`, or `console.log` removed.
- [ ] No incomplete stubs: no empty catch blocks or placeholder TODO comments.

### 5. Verification & Testing Coverage
- [ ] Executable verification: build and typechecks confirmed passing.
- [ ] Risk-proportional behavioral tests: high-risk operations accompanied by tests covering success AND negative paths.

---

## Severity Classification

Report findings categorized by severity:
- **CRITICAL**: IDOR vulnerabilities, data corruption, broken transactions, privilege escalation. Blocks completion.
- **HIGH**: Missing input validation, leaked sensitive fields, race conditions under concurrency. Blocks completion.
- **MEDIUM**: Suboptimal state synchronization, missing pagination, lack of accessibility attributes.
- **LOW**: Minor stylistic inconsistencies or documentation improvements.
