---
name: xengin-task
description: Execute a software development task through the disciplined Xengin engineering workflow. Use to build features, fix bugs, or implement requirements with automated risk assessment, pre-flight discovery, final enforcement gate, and risk-proportional verification.
---

# Xengin Task Execution

The user has requested the implementation of a software requirement.

## Workflow

Execute this task using the Xengin 10-step software engineering pipeline:

1. **Classify Scope**: Determine whether this is `frontend`, `backend`, `cross-layer`, or `refactor`.
2. **Assess Risk**: Classify risk level (`Low`, `Medium`, `High`) according to `xengin-workflow`.
3. **Pre-flight Discovery**:
   - Inspect existing project structure, framework, conventions, and scripts (`Inspect Never Invent`).
   - If `graphify-out/` exists and the task has medium/high blast radius, review `GRAPH_REPORT.md` before deep manual exploration. Verify against source code.
4. **Activate Expertise**: Activate `xengin-frontend-engineering`, `xengin-backend-engineering`, or `xengin-workflow` as needed.
5. **Implement Proportionally**: Implement the minimal safe, coherent solution without parallel architectures or unnecessary infrastructure.
6. **Final Enforcement Gate**: Perform the mandatory self-audit (Security, Boundaries, Concurrency, State Persistence, Hygiene).
7. **Risk-Based Verification**: Execute builds and linters. For high-risk tasks, **automatically write and run automated behavioral negative-path tests** (401 unauthenticated, 403 unauthorized/IDOR, atomic rollback on failure).
8. **Diff Review & Delivery**: Review git diff and deliver an evidence-backed completion report (`Changed`, `Validated`, `Gate`, `Notes/Risks`).
