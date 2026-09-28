# 01 — Xengin Software Engineering Workflow

These workflow rules are permanently active whenever the Xengin plugin is enabled.

## The 10-Step Execution Lifecycle

For every software engineering task, execute this disciplined lifecycle:

```text
Classify
  → Assess Risk
  → Pre-flight Discovery
  → Conditional Knowledge Graph Review
  → Activate Relevant Skill
  → Proportional Implementation
  → Final Enforcement Gate Audit
  → Risk-Based Verification
  → Diff Review
  → Evidence-Based Completion Report
```

### 1. Classification & Risk Assessment
- Classify scope: `frontend`, `backend`, `cross-layer`, `refactor`, `review`, `plan`.
- Assess risk:
  - **Low**: Presentational UI, text, non-breaking styling $\rightarrow$ Build / lint / typecheck.
  - **Medium**: Forms, standard CRUD, shared components $\rightarrow$ Targeted tests + build.
  - **High**: Auth, finance, inventory/BOM, concurrency, migrations, data deletion $\rightarrow$ **Mandatory domain-tailored behavioral negative-path feature tests** (e.g., 401/403 for protected auth, atomic rollback on constraint failure, race condition checks).

### 2. Pre-flight & Conditional Graphify
- Inspect directory layout, package managers, and scripts.
- If `graphify-out/` exists and the task has medium/high blast radius or cross-service dependencies, inspect `graphify-out/GRAPH_REPORT.md` before manual scanning. For small/local tasks, Graphify may be skipped. Verify all findings against source code.

### 3. Implementation & Final Gate
- Implement the smallest coherent change.
- Before completion, conduct a mandatory self-audit:
  - **Security**: Auth middleware verified, strict ownership scoping, zero IDOR, payload whitelisting, response sanitization (no secret/password leaks).
  - **Data Integrity**: Multi-step writes wrapped in DB transactions; deterministic lock acquisition in concurrency; external side effects (SMS/Email/Webhooks) executed **outside** DB transactions.
  - **Frontend**: Persistable state in URL; transient UI state in local state; derived values computed inline (`useMemo`), zero state-sync `useEffect` chains.
  - **Hygiene**: No introduced `any`, `@ts-ignore`, or leftover debug statements.

### 4. Evidence-Based Reporting
Report strictly what was executed:
- `Changed`: Files modified/created and rationale.
- `Validated`: Exact command outputs and test results.
- `Gate`: Protections verified during self-audit.
- `Notes/Risks`: Operational considerations or migration notes.
