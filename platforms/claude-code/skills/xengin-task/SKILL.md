---
name: xengin-task
description: Implement software features, bug fixes, refactors, or code changes using disciplined engineering guardrails. Use whenever the user asks to build, create, add, implement, fix, update, or code any functionality, whether via `/xengin-task` or conversational requests.
---

# Xengin Task Workflow

You are operating under **Xengin (X Engineering Intelligence)** guardrails for Claude Code.

## Operating Philosophy

```text
The user defines WHAT they want (product & business intent).
Xengin owns HOW to engineer it safely (architecture, contracts, data integrity, security, verification).
```

Do not burden the user with routine technical choices (e.g. database transactions, IDOR protection, state libraries, derived state, or caching layers). Discover existing project patterns and make proportional, safe decisions.

---

## 10-Step Execution Lifecycle

For every implementation task, follow this structured lifecycle:

1. **Understand Product Intent**: Clarify the business requirement and acceptance criteria.
2. **Inspect Existing Architecture**: Inspect existing directory structures, models, middleware, and shared UI components before creating new ones (*Inspect Before Invent*).
3. **Classify Scope & Assess Risk**:
   - **Low Risk** (isolated UI/styling, static text) $\rightarrow$ Build / lint / typecheck.
   - **Medium Risk** (CRUD endpoints, forms, shared components) $\rightarrow$ Targeted tests + build.
   - **High Risk** (auth, finance, migrations, concurrency, multi-step mutations) $\rightarrow$ Mandatory domain-tailored negative-path behavioral tests.
4. **Load Relevant Internal References**:
   - For core principles: inspect `references/core.md` and `references/workflow.md`.
   - For UI/frontend tasks: inspect `references/frontend.md` (URL state, derived state, zero `useEffect` chains).
   - For API/backend tasks: inspect `references/backend.md` (transactions, IDOR defense, Expand-Migrate-Contract).
   - For risk classification: inspect `references/risk-model.md`.
5. **Conditional Graphify Discovery**: If `graphify-out/` is present and the task has medium/high blast radius, review `graphify-out/GRAPH_REPORT.md` to trace dependency links (*references/graphify-policy.md*). Always verify graph findings against actual source files.
6. **Implement Smallest Safe Coherent Change**:
   - Reuse existing models, services, and components (*Zero Parallel Architectures*).
   - Keep side effects outside database transactions.
7. **Run Final Enforcement Gate Self-Audit**:
   - Self-audit code against `references/final-enforcement-gate.md`.
   - Verify boundary validation, response sanitization, no IDOR, and code hygiene (no `any`, `@ts-ignore`, or leftover debug logs).
8. **Executable & Risk-Proportional Verification**:
   - Run actual project compilers and test suites (`npm test`, `pytest`, `tsc --noEmit`, `php artisan test`).
   - NEVER claim verification passed unless the command executed with exit code 0.
9. **Review Final Diff**: Verify that only proportional, requested changes were made.
10. **Evidence-Based Completion Report**: Report files changed, exact verification command outputs, and verified safety gates.
