# Frontend Agent Rules v2 — RC2 Modular Pack

This directory is the runtime-oriented split of `frontend-agent-rules-v2-rc2.md`.

## Recommended loading strategy

```text
Always:
  00-core-rules.md

Then load only relevant modules:
  workflow/scope/refactoring → 01-workflow-scope-and-refactoring.md
  components/architecture    → 02-components-and-architecture.md
  state/data/effects         → 03-state-data-and-effects.md
  UI/a11y/performance        → 04-ui-quality-and-accessibility.md
  deps/tests/validation      → 05-dependencies-validation-and-delivery.md
```

For large or cross-cutting changes, loading multiple topic modules is appropriate.

The combined RC2 file remains the canonical human-readable reference. Avoid editing the split files and combined file independently; update one source and regenerate the other to prevent drift.
