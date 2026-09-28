# Backend Agent Rules v1 — RC1 (Modular)

This directory is the modular backend Coding Agent rulebook.

It is designed especially for Vibe Coding workflows where the user may not have enough backend expertise to choose architecture, database, security, cache, queue, or scaling strategies manually.

## Loading policy

Always load:

```text
00-core-rules.md
```

Then load only the modules relevant to the task:

```text
Project discovery, scope, architecture, refactoring, infrastructure decisions
→ 01-project-workflow.md

Endpoints, API styles, contracts, pagination, cache/Redis decisions
→ 02-api-contracts-and-services.md

Database, schema, migrations, queries, transactions, large data, scale
→ 03-data-database-and-scale.md

Authentication, authorization, tenant isolation, validation, common vulnerabilities
→ 04-security-and-validation.md

External services, retries, idempotency, jobs, queues, events, WebSocket/SSE
→ 05-async-queues-and-integrations.md

Logging, metrics, health, performance, deployment, operational behavior
→ 06-observability-performance-and-ops.md

Testing, validation, migrations checks, diff review, Definition of Done
→ 07-testing-validation-and-delivery.md
```

## Suggested loading examples

Simple CRUD endpoint:

```text
00-core
01-project-workflow
02-api-contracts-and-services
03-data-database-and-scale
04-security-and-validation
07-testing-validation-and-delivery
```

Database-heavy feature:

```text
00-core
01-project-workflow
03-data-database-and-scale
07-testing-validation-and-delivery
```

Authentication/permissions:

```text
00-core
01-project-workflow
04-security-and-validation
07-testing-validation-and-delivery
```

Queue/webhook/integration:

```text
00-core
01-project-workflow
02-api-contracts-and-services
04-security-and-validation
05-async-queues-and-integrations
07-testing-validation-and-delivery
```

Performance/scaling work:

```text
00-core
01-project-workflow
03-data-database-and-scale
06-observability-performance-and-ops
07-testing-validation-and-delivery
```

## Core philosophy

```text
Do not make the non-specialist user choose technologies unnecessarily.

Inspect the project.
Understand the real problem.
Choose the smallest safe proportional design.
Explain important trade-offs simply.
Escalate only high-impact choices.
Validate before claiming completion.
```
