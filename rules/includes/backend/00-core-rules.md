# 00 — Core Rules

These rules MUST be available for every meaningful backend coding task.

## Normative language

```text
MUST       = required
MUST NOT   = prohibited
SHOULD     = expected unless a concrete reason applies
SHOULD NOT = avoid unless a concrete reason applies
MAY        = optional
```

These rules guide engineering judgment; they do not replace it.

## Vibe-Coding Decision Rule

The user may not be a backend specialist.

MUST NOT transfer routine architectural decision-making burden to the user when the Agent can inspect the project and make a safe proportional decision.

For important technical choices, the Agent SHOULD:

```text
1. identify the actual problem
2. inspect existing project conventions and constraints
3. compare realistic options
4. choose the smallest safe proportional solution
5. explain the decision in plain language
6. request approval only when the choice materially changes:
   - infrastructure
   - recurring cost
   - public API contracts
   - database schema/data migration risk
   - security model
   - operational complexity
```

Do not ask the user to choose between technologies merely because multiple technologies exist.

## Hard completion gates

A backend task is not complete unless all applicable hard gates pass:

```text
1. Security & Data Integrity
2. Functional / Behavioral Correctness
3. API / Contract Correctness
4. Build / Type / Runtime Integrity
```

Security is part of correctness, not final polish.

A working endpoint that corrupts data, leaks data, or breaks an established contract is not done.

## Core directives

```text
1. Understand before changing; inspect proportionally to task scope.
2. Source code, schema, migrations, configuration, and actual runtime contracts are ground truth.
3. Healthy existing architecture > Agent preference; correctness > broken convention.
4. Small problem → Small Safe Change.
5. Minimal Diff means the smallest safe coherent change, not the fewest changed lines.
6. Do not introduce parallel architecture or system-wide refactors without concrete need and scope.
7. Do not design for hypothetical future requirements or imaginary hyperscale.
8. Choose infrastructure from the problem; never invent a problem to justify infrastructure.
9. Assess blast radius before changing shared modules, schemas, contracts, auth, or infrastructure.
10. Treat data integrity, authorization, tenant isolation, and destructive operations as invariants when applicable.
11. Never trust client or external input merely because another layer already validated it.
12. Preserve public contracts unless the task explicitly requires a breaking change.
13. Use transactions, idempotency, locking, queues, caches, and distributed systems only when their failure mode justifies them.
14. Design database access for realistic data growth; avoid unbounded reads and accidental N+1 behavior.
15. Preserve security boundaries; authentication is not authorization.
16. Inspect rather than guess APIs, schemas, env vars, dependencies, versions, routes, permissions, and data semantics.
17. Deliver complete code only; do not leave placeholders in repository changes.
18. Validate success paths and relevant failure paths proportionally to risk.
19. Review the actual diff and distinguish introduced failures from pre-existing failures.
20. Report only what was actually changed and verified.
```

## Operating loop

```text
UNDERSTAND
→ LOCATE
→ ASSESS
→ LIMIT SCOPE
→ IMPLEMENT
→ VALIDATE
→ REVIEW DIFF
→ REPORT
```

## Final Enforcement Gate (Mandatory Self-Check)

Before declaring completion:
1. **Search modified code for:** `any`, `@ts-ignore`, `@ts-expect-error`, empty catch blocks, TODO/FIXME.
2. **Boundary Validation:** Verify explicit schema/input validation on all modified input points.
3. **Data Safety:** Verify response models do not leak sensitive or unneeded internal data (passwords, tokens, foreign tenant data).
4. **Transactions & Race conditions:** Verify multi-step database writes are atomic and safe under concurrency.
5. **Async Criticality:** Ensure business-critical events use durable storage, not ephemeral in-process fire-and-forget.
6. **Diff check:** Audit line-by-line diff against loaded rules.

Final principle:

```text
The goal is not to build the most sophisticated backend.

The goal is to make the smallest correct, secure,
data-safe, understandable, scalable-enough, and validated change.
```
