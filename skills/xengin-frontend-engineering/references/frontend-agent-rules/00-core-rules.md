# Frontend Agent Rules RC2 — Core Runtime Rules

> Always load this file for meaningful frontend coding tasks.

# 0. How to Read These Rules

Normative words:

```text
MUST       = required
MUST NOT   = prohibited
SHOULD     = expected unless a concrete reason applies
SHOULD NOT = avoid unless a concrete reason applies
MAY        = optional
```

Core principle:

```text
Understand before changing.
```

Simple meaning:

```text
اول نقشه خانه را ببین، بعد دیوار را خراب کن.
```

These rules guide engineering judgment; they do not replace it.

---

---

# 56. CORE Rules — Always Load

If this document is split, the following rules belong in `00-core-rules.md` and MUST always be available:

```text
1. Understand before changing; inspect proportionally to task scope and risk.
2. Source code and actual project configuration are Ground Truth.
3. Healthy existing architecture > Agent preference; correctness > broken convention.
4. Small problem → Small Safe Change. Minimal Diff means the smallest safe coherent change, not the fewest lines.
5. Do not introduce parallel architecture, speculative abstractions, or system-wide refactors without concrete need.
6. Do not design for hypothetical future requirements; solve demonstrated complexity.
7. Assess blast radius before changing shared/central contracts; use Graphify as a map, never as a substitute for source inspection.
8. Organize by coherent responsibility; avoid both giant mixed-responsibility modules and meaningless fragmentation.
9. Determine state ownership before creating state; prefer derived values over synchronized duplicate state.
10. Use useEffect for real side effects/external synchronization, not render-time derivation.
11. Preserve TypeScript safety and do not hide type problems without a concrete justified reason.
12. Verify imports, exports, aliases, installed dependencies, versions, and project conventions instead of guessing.
13. Do not introduce third-party dependencies casually; require authorization unless dependency changes are already explicitly in scope.
14. Preserve observable product behavior and shared public contracts unless the task explicitly changes them.
15. Handle applicable UI states, baseline accessibility, and layout stability as part of a complete frontend change.
16. Deliver complete code only; do not leave placeholders, fake APIs, missing imports, or partial implementations.
17. Validate proportionally to risk, review the actual diff, and distinguish introduced failures from evidenced pre-existing failures.
18. Report only what was actually changed and verified.
```

These Core rules are intentionally compact. Topic files provide the detailed gates, examples, and exceptions.

---

---

# Final Operating Loop

For every meaningful change:

```text
UNDERSTAND
↓
LOCATE
↓
ASSESS
↓
LIMIT SCOPE
↓
IMPLEMENT
↓
VALIDATE
↓
REVIEW DIFF
↓
REPORT
```

Simple meaning:

```text
بفهم
↓
محل واقعی تغییر را پیدا کن
↓
وضعیت معماری و اثر تغییر را بسنج
↓
دامنه را کنترل کن
↓
پیاده‌سازی کن
↓
تست و بررسی کن
↓
Diff را ببین
↓
واقعیت را گزارش کن
```

## Final Enforcement Gate (Mandatory Self-Check)

Before declaring completion:
1. **Search modified code for:** `any`, `@ts-ignore`, `@ts-expect-error`, empty catch blocks, TODO/FIXME.
2. **Framework state:** Use framework reactive state APIs rather than reading mutable globals directly (`window.location.search`, etc.).
3. **Effects:** Verify every new `useEffect` synchronizes with an external system (not derived state).
4. **Shared safety:** Verify existing consumers for backward compatibility.
5. **Diff check:** Audit line-by-line diff against these rules.

Final principle:

```text
The goal is not to change the most code.

The goal is to make the smallest correct,
safe, understandable, and validated change.
```
