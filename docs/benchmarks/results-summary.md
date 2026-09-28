# Xengin Empirical Benchmark Results Summary

This report summarizes the empirical results observed across benchmark evaluations in real-world full-stack codebases.

---

## 1. Multi-Condition Benchmark (TaskFlow Suite)

The evaluation compared Condition A (Control), Condition B (Rulebook only), and Condition C (Full Xengin with Gate v2) across 4 representative tasks (Frontend URL filters, Button variant refactor, Tenant update API, Invitation dispatcher).

| Metric | Condition A (Control) | Condition B (Rulebook Only) | Condition C (Full Xengin) |
| :--- | :---: | :---: | :---: |
| **Authentication Middleware** | Invented fake auth (`requireAuth`) | Reused existing (`authenticate`) | Reused existing (`authenticate`) |
| **IDOR / Ownership Scoping** | ❌ Failed (tamperable ID) | ⚠️ Partial (tenant check omitted) | ✅ Passed (strict `tenantId` match) |
| **Mass Assignment Protection** | ❌ None (`prisma.update(req.body)`) | ✅ Whitelisted DTO | ✅ Whitelisted DTO |
| **Atomic Transactions** | ❌ Multi-step queries unbundled | ⚠️ Partial transaction | ✅ Full transaction rollback |
| **Side Effect Isolation** | ❌ Network call in DB transaction | ❌ Network call in DB transaction | ✅ Dispatch outside DB transaction |
| **Frontend State Sync** | ❌ `useEffect` chain + local state | ⚠️ URL state with extra effects | ✅ URL single source of truth, 0 effects |
| **Shared Component Safety** | ❌ Breaking changes to Button | ✅ Backward-compatible variant | ✅ Backward-compatible variant |
| **Code Hygiene (`any` / debug)** | 4 instances of `any` / logs | 1 `@ts-ignore` | 0 `any`, 0 `@ts-ignore`, 0 debug logs |

### Key Finding
While Rulebooks (Condition B) significantly improve pattern awareness, the **Final Enforcement Gate self-inspection (Condition C)** is what consistently prevents subtle security omissions (such as missing ownership checks) and architectural edge cases.

---

## 2. Knowledge Graph (Graphify) Leverage Evaluation

A controlled comparison was executed on an ERP/manufacturing domain (BOM assembly, warehouse ledger, multi-model inventory transactions):

- **With Knowledge Graph (`graphify-out/` available)**:
  - Agent immediately identified cluster boundaries (`Warehouse & Assembly`), located god nodes (`ProductRecipe`, `WarehouseMovement`), and traced blast radius across 5 interconnected models in under 2 minutes.
  - Zero filesystem search loops or redundant grep scans.
  - Correctly reused existing cardex ledger and models without duplicate schema creation.

- **Without Knowledge Graph (Manual inspection)**:
  - Agent required multiple grep and directory exploration steps to discover relations between recipes, raw materials, and warehouse transactions.
  - While it successfully delivered working code adhering to Xengin rules, the discovery overhead was ~3x higher.

### Conclusion on Knowledge Graphs
Knowledge graphs act as high-leverage architectural maps for medium-to-large codebases with cross-service dependencies. For isolated tasks or small files, direct source inspection remains optimal.
