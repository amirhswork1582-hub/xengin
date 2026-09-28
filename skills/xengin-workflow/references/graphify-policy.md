# Xengin Knowledge Graph & Graphify Policy

This policy governs the interaction between Xengin and the optional Knowledge Graph tool (`Graphify`). It encapsulates the empirical findings from rigorous real-world benchmarking.

---

## 1. Core Principles

1. **Optional & Zero Dependency**: Xengin does NOT depend on Graphify. If Graphify is not present in the environment or project, Xengin functions completely and effectively through standard source code inspection.
2. **Conditional Activation**: Graphify artifacts (`graphify-out/`) are inspected only when they provide high cognitive leverage. Running or reading graph artifacts on minor UI tweaks is anti-pattern over-engineering.
3. **Source Code is Ground Truth**: A Knowledge Graph is an architectural map, not source code. Node definitions, signatures, and database schemas discovered in the graph MUST be verified against actual source files before modifying code.

---

## 2. Decision Matrix

| Task Characteristics | `graphify-out/` Exists? | Action |
| :--- | :---: | :--- |
| **Low Blast Radius** (text, styling, isolated UI) | Any | **Skip Graphify**. Inspect local component directly. |
| **Medium / High Blast Radius** (multi-service API, BOM, cross-layer refactor) | ❌ No | **Standard Pre-flight**. Grep codebase, routes, and models manually. |
| **Medium / High Blast Radius** | ✅ Yes | **Pre-flight Graph Review**. Read `GRAPH_REPORT.md` first to locate communities, god nodes, and dependency blast radius before touching code. |

---

## 3. Operational Pre-Flight Workflow (When Graphify is Present)

When `graphify-out/` is detected during pre-flight on complex tasks:

1. **Locate Community**: Open `graphify-out/GRAPH_REPORT.md` and identify the relevant functional cluster (e.g. `Warehouse & Assembly`, `Authentication & Tokens`).
2. **Identify Boundary Nodes**: Extract key models, controllers, and services associated with that cluster.
3. **Trace Blast Radius**: Note outbound and inbound dependency links to determine which other services or consumers could be affected.
4. **Source Verification**: Navigate to the discovered source files and inspect migration schemas and method signatures directly.
5. **Proceed to Implementation**: Write code adhering to discovered patterns without blind or redundant filesystem scanning.
