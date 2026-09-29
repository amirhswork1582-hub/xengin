---
name: xengin-plan
description: Inspect the repository and formulate a phased, risk-mitigated architectural implementation plan for high-blast-radius changes without modifying code. Use when designing major refactors, schema migrations, auth overhauls, or complex integrations.
---

# Xengin Architectural Planning

The user has requested architectural planning for a complex or high-blast-radius software requirement.

> [!IMPORTANT]
> **STRICTLY READ-ONLY:** Do NOT modify any application source files or execute mutations during this workflow. Provide only the architectural analysis, risk assessment, and phased execution roadmap.

---

## Planning Protocol

When formulating an implementation plan, follow this structured assessment:

1. **Pre-Flight Discovery & Blast Radius**:
   - Inspect relevant directory structures, configuration files, and dependencies.
   - If `graphify-out/` is present, inspect `graphify-out/GRAPH_REPORT.md` to map affected services, consumers, and data models (*references/graphify-policy.md*).
   - Identify upstream and downstream consumers that could be affected by the change.
2. **Architecture & Existing Conventions**:
   - Discover existing models, middleware, schemas, and UI components that should be reused (*references/core.md*).
   - Explicitly avoid introducing parallel architectures or redundant utility libraries.
3. **Phased Implementation Roadmap**:
   - Structure implementation into discrete, verifiable phases.
   - For database schema changes, formulate an **Expand-Migrate-Contract** roadmap to ensure zero downtime and backward compatibility.
   - For stateful workflows, define clear Finite State Machine (FSM) transitions and valid state states.
4. **Risk & Failure Modes**:
   - Identify potential concurrency issues, race conditions, and lock contention (*references/risk-model.md*).
   - Define transaction boundaries and ensure external side effects (emails, webhooks) are isolated outside transactions.
5. **Verification & Testing Strategy**:
   - Specify the exact build commands, linters, and behavioral test suites needed to validate success and negative-path invariants.

---

## Cooperation with Claude Code Plan Mode

When Claude Code is operating in **Plan Mode** (`/plan`), the `xengin-plan` workflow acts as the domain engineering engine:
- It produces the structured blast-radius analysis, dependency matrix, and verification plan.
- The plan integrates seamlessly with Claude's native plan tracking and user approval checkpoints.
