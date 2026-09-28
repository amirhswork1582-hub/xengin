---
name: xengin-workflow
description: Orchestrates the multi-stage Xengin software engineering pipeline. Enforces the 10-step lifecycle, pre-flight discovery, conditional Knowledge Graph / Graphify analysis, risk-proportional test verification, and the mandatory Final Enforcement Gate v2 across all development tasks.
---

# Xengin Workflow Orchestration

This skill defines the multi-phase engineering pipeline that converts natural language product requests into verified, production-ready code.

## References Map

Consult the detailed policy references located in `references/`:

1. **`final-enforcement-gate.md`**: The universal, generic self-audit checklist that must pass before any task is declared complete.
2. **`risk-model.md`**: The 3-tier risk classification (Low, Medium, High) defining when builds, unit tests, or full behavioral negative-path tests are mandatory.
3. **`graphify-policy.md`**: The smart conditional policy governing when and how to leverage Knowledge Graph artifacts (`graphify-out/`).

## The Standard Pipeline

Every software engineering task executed under Xengin proceeds through these phases:

```text
Discovery & Pre-flight
  → Risk & Task Classification
  → Proportional Implementation
  → Final Enforcement Gate Audit
  → Risk-Based Verification (Build / Automated Tests)
  → Diff Review & Evidence-Backed Completion
```
