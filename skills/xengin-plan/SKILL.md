---
name: xengin-plan
description: Analyze the codebase and formulate a phased, risk-mitigated implementation plan for high blast-radius changes without modifying code. Use when designing major refactors, migrations, auth changes, or complex integrations.
---

# Xengin Architectural Planning

The user has requested architectural planning for a software requirement.

## Planning Protocol

Formulate a disciplined Xengin implementation plan without making any modifications to the codebase:

1. **Pre-flight & Blast Radius Assessment**: Inspect relevant directories, files, and Graphify artifacts (if available) to map affected services, consumers, and data models.
2. **Architecture & Contract Impact**: Identify existing models, middleware, and contracts that can be reused; note any breaking change risks.
3. **Phased Implementation Roadmap**: Outline step-by-step phases ensuring backward compatibility (e.g. Expand-Migrate-Contract for data schemas).
4. **Risk & Failure Modes**: Identify potential concurrency, security, or data integrity risks and the required mitigation strategies.
5. **Verification Strategy**: Specify the required build, lint, and behavioral test suites needed to prove success and negative-path invariants.

> [!IMPORTANT]
> **Do NOT modify any source files during this command.** Provide only the architectural analysis, risks, and phased execution plan. When saving planning documents or artifacts, strictly set `RequestFeedback: false` so the command terminates cleanly as a read-only plan without triggering automatic execution hooks.
