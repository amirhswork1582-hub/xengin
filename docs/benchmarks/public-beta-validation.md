# Xengin v0.3.0 Public Beta Empirical Validation Report

> **Release Target:** Xengin v0.3.0-beta.1 (Native Antigravity Plugin & Gemini CLI Extension)  
> **Evaluation Date:** September 2026  
> **Qualification Verdict:** **READY FOR PUBLIC BETA** (100% Pass Rate across all 8 empirical dimensions)

---

## 1. Executive Summary

This report documents the rigorous, isolated empirical qualification of **Xengin v0.3.0**. The primary objective was to verify that the consolidated native plugin architecture delivers on all engineering invariants:
1. Operates without dependency on legacy global skills (`frontend-agent-rules`, `backend-agent-rules`).
2. Restricts the user-facing slash menu to exactly three workflows (`/xengin-task`, `/xengin-plan`, `/xengin-review`).
3. Automatically triggers conditional domain rules (`frontend.md`, `backend.md`) on pure natural language prompts without slash commands or technical keywords.
4. Adheres strictly to the risk-based model without checklist blindness.
5. Employs Graphify conditionally when high cognitive leverage exists, while maintaining seamless fallback in its absence.
6. Maintains complete read-only safety during planning and code review operations.

All tests were executed on real codebases with automated behavioral test suites and compilation checks.

---

## 2. Test Matrix & Verification Summary

| # | Dimension | Target Capability | Observed Result | Status |
| :-: | :--- | :--- | :--- | :-: |
| **1** | **Legacy Isolation** | Zero reliance on legacy global skills; exactly 3 user-facing workflows exposed | Active skills: `/xengin-task`, `/xengin-plan`, `/xengin-review`. `AGENTS.md` permanently active; `frontend.md`/`backend.md` conditional. Legacy skills safely isolated. | **PASS** |
| **2** | **Feature Execution (`/xengin-task`)** | Inspect before invent, pattern reuse, negative-path handling, type-safe delivery | Discovered and reused existing `updateUserProfile` API and `Alert` component. Zero parallel architecture. `tsc --noEmit` exit 0, 4/4 behavioral scenarios passed. | **PASS** |
| **3** | **Security & Audit (`/xengin-review`)** | 5-dimension audit, risk-proportional blocking, 100% read-only guarantee | Detected IDOR, role mass assignment, password hash leakage, and `any` types. Blocked merge with Critical/High severities. Working tree 100% identical before and after. | **PASS** |
| **4** | **Architectural Planning (`/xengin-plan`)** | Blast-radius assessment, FSM transitions, read-only plan artifact | Produced comprehensive cancellation roadmap with FSM matrix and rollback strategy. `RequestFeedback: false` verified clean termination without auto-execution. | **PASS** |
| **5** | **Natural Prompt (Frontend)** | Automatic activation of `frontend.md` on plain Persian text without technical keywords | Extracted stock status filter into URL search params, computed derived list via `useMemo`, avoided `useEffect` syncing, added ARIA labels. `npm run build` exit 0. | **PASS** |
| **6** | **Natural Prompt (Backend)** | Automatic activation of `backend.md` on plain conversational order cancellation request | Enforced ownership check (`req.user.id`), rejected invalid state transitions, isolated side effects outside DB transaction. 7/7 automated tests passed. | **PASS** |
| **7** | **Checklist Blindness Adaptation** | Domain-tailored risk mitigation rather than rigid HTTP checklist | Batch cleanup CLI/Cron evaluated on bounded batching (1000 items), lock mitigation, dry-run safety, and date boundaries rather than mechanical 401/403/IDOR checks. 6/6 tests passed. | **PASS** |
| **8** | **Graphify Conditional Policy** | Conditional leverage of `graphify-out/` when present; graceful fallback when absent | When graph available: identified clusters (`Warehouse & Assembly BOM`) and verified with source files. When absent: performed manual discovery smoothly with zero errors. | **PASS** |

---

## 3. Detailed Empirical Evidence

### Dimension 1: Legacy Isolation & Runtime Inspection
- **Setup:** Global legacy skill directories (`frontend-agent-rules`, `backend-agent-rules`) were moved out of `~/.gemini/config/skills/` into an isolated backup folder.
- **Runtime Query:** `agy --print "List your active skills and rules"`
- **Result:**
  - Active Skills: `xengin-task`, `xengin-plan`, `xengin-review` (and system utility `graphify`).
  - Active Rules: `rules/AGENTS.md` (Permanently Active).
  - Conditional Rules: `rules/frontend.md` and `rules/backend.md` (Active conditionally via model decision).
  - **Verdict:** Zero skill duplication, zero legacy bleed.

---

### Dimension 2: Executable `/xengin-task` on Real Codebase
- **Prompt:** User requested adding display name editing to user settings with empty-string rejection.
- **Actions Observed:**
  - Inspected existing profile service (`api/user.ts`) and reused `updateUserProfile`.
  - Reused existing shared `Alert` component instead of creating new toast/dialog libraries.
  - Implemented client validation rejecting empty strings and whitespace.
  - Executed `npm run typecheck` (`tsc --noEmit`): Exit Code 0.
  - Executed automated scenarios: Initial load, edit success, empty-string rejection, server error recovery (4/4 passed).
- **Final Enforcement Gate:** Verified input validation, no `any`, no debug logs.

---

### Dimension 3: Executable `/xengin-review` Read-Only Audit
- **Target:** Staged changes introducing:
  1. `PATCH /api/users/:id` without ownership check (IDOR vulnerability).
  2. Mass assignment updating `role` directly from request payload.
  3. Sensitive response leaking `password_hash`.
  4. Function parameter typed as `any`.
- **Audit Findings:**
  - **Security (Critical):** Flagged IDOR vulnerability on `:id` parameter; demanded `req.user.id` authorization check.
  - **Data Integrity (Critical):** Flagged mass assignment permitting privilege escalation to admin.
  - **Response Safety (High):** Flagged password hash exposure; required explicit serializer/DTO.
  - **Code Hygiene (Medium):** Flagged `any` type on user payload.
- **Read-Only Verification:** `git diff` and `git status` before and after review invocation were byte-for-byte identical. Zero files were touched.

---

### Dimension 4: `/xengin-plan` Read-Only Invariant
- **Prompt:** Formulate an architectural roadmap for order cancellation after shipping.
- **Plan Outputs:**
  - Identified blast radius across orders, warehouse movements, and payment refund providers.
  - Constructed Finite State Machine (FSM) defining valid transitions and terminal states.
  - Formulated phased Expand-Migrate-Contract schema migration plan.
  - Specified optimistic locking (`version` column) to mitigate race conditions during simultaneous cancellations.
  - Created plan artifact with `RequestFeedback: false`, preventing unwanted automated execution hooks in non-interactive CI/CLI environments.

---

### Dimension 5: Natural Prompt Routing — Frontend
- **Prompt:** *"در صفحه محصولات یک فیلتر وضعیت موجودی اضافه کن به طوری که کاربر بتونه کالاهای موجود رو فیلتر کنه و اگر صفحه رو رفرش کرد فیلتر نپره."*  
  *(No mention of Xengin, no slash commands, no technical architectural keywords).*
- **Observed Behavior:**
  - Automatically activated `rules/frontend.md`.
  - Stored filter state in URL search parameters (`?inStock=true`) as single source of truth.
  - Calculated filtered products inline via `useMemo` from raw list and URL parameters.
  - Zero `useEffect` synchronization chains introduced.
  - Added accessible `aria-pressed` attributes to toggle controls.
  - Verified with `npm run build`: Exit Code 0.

---

### Dimension 6: Natural Prompt Routing — Backend
- **Prompt:** *"کاربر باید بتواند سفارش پرداخت‌نشده خودش را لغو کند. هنگام لغو، موجودی کالا به انبار برگردد و برای ادمین اعلان ارسال شود."*  
  *(Pure conversational Persian prompt).*
- **Observed Behavior:**
  - Automatically activated `rules/backend.md`.
  - Enforced ownership verification: `req.user.id === order.userId` (IDOR defense).
  - Validated state machine: Allowed `PENDING_PAYMENT -> CANCELLED`; rejected `SHIPPED` status with 400.
  - Reused existing mock database models (`ordersDatabase`, `productsDatabase`) without inventing new ORM abstractions.
  - Enforced transactional boundary: Stock increment and order status update executed together.
  - Isolated side effect: `NotificationService.notifyAdmin` invoked outside mutation boundary with error recovery.
  - Passed all 7 automated unit and behavioral integration tests (`npm test`): Exit Code 0.

---

### Dimension 7: Checklist Blindness Adaptation
- **Scenario:** Background maintenance script (CLI/Cron) purging expired session tokens older than 90 days.
- **Risk Analysis:**
  - Risk is not API authentication (no HTTP endpoint, no 401/403 required).
  - Risk is database table lock escalation, unbounded memory consumption, and accidental deletion of valid sessions.
- **Implementation & Test Suite:**
  - Applied bounded batching (1000 records per batch) with inter-batch yield (`sleepMs`) to release database table locks.
  - Added safe dry-run mode using cursor-based pagination.
  - Guarded input parameters against zero/negative/floating-point values.
  - Added structured audit logging recording batch counts and total deleted rows.
  - Verified with 6 domain-tailored automated test scenarios (Selective deletion, batching, idempotency, dry-run, input guardrails, observability): 6/6 passed, Exit Code 0.

---

### Dimension 8: Graphify Conditional Policy
- **Condition A (Graphify ON — Complex Codebase):**
  - Inspected repository with `graphify-out/` present.
  - Detected and reviewed `GRAPH_REPORT.md` during pre-flight.
  - Extracted domain clusters (`Warehouse & Assembly BOM`) and boundary nodes (`ProductRecipe`, `WarehouseMovement`).
  - Verified models against live migration files before implementing logic.
- **Condition B (Graphify OFF — Leaf Tasks / Standard Codebases):**
  - Executed tasks in workspaces without `graphify-out/`.
  - System proceeded directly to manual source code inspection without throwing errors or requesting Graphify generation.

---

## 4. Repository Sanitization & Security Scan

A repository-wide static scan was conducted on all tracked files in `xengin`:
- **Personal Machine Paths:** 0 occurrences of local Windows drive paths (`C:\Users\...`, `G:\...`).
- **Secrets / Private Keys:** 0 credentials, private keys, or API tokens committed.
- **Manifest Schema:** Validated against official schema `$schema: https://antigravity.google/schemas/v1/plugin.json`.
- **License & Governance:** Apache-2.0 `LICENSE`, `SECURITY.md`, `CONTRIBUTING.md`, and issue templates confirmed present and standard-compliant.

---

## 5. Qualification Verdict

```text
================================================================================
  FINAL QUALIFICATION VERDICT: READY FOR PUBLIC BETA
  Version: v0.3.0-beta.1
  All 8 empirical qualification gates passed with zero regressions.
================================================================================
```
