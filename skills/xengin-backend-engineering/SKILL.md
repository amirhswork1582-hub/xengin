---
name: xengin-backend-engineering
description: Production backend engineering skill for APIs, database migrations, authentication, authorization, transactional integrity, concurrency control, and async queues across Laravel, Node.js, Python, Go, and relational/NoSQL databases. Enforces tenant isolation, IDOR/BOLA protection, mass assignment prevention, response sanitization, and atomic transactional integrity.
---

# Xengin Backend Engineering

This skill provides comprehensive engineering guidelines for backend services, APIs, databases, and async background processing.

## Purpose & Scope
Apply this skill whenever building or modifying API endpoints, data models, database migrations, authentication/authorization logic, transactional operations, or background workers.

## Rulebook References Map

Consult the authoritative reference documents located in `references/backend-agent-rules/`:

1. **`00-core-rules.md`**: Core backend directives, completion gates, and proportionate engineering principles.
2. **`01-project-workflow.md`**: Pre-flight inspection, smart Knowledge Graph / Graphify detection, blast radius assessment, and avoiding parallel architectures.
3. **`02-api-contracts-and-services.md`**: API contract stability, idempotency, REST/RPC conventions, and pagination standards.
4. **`03-data-database-and-scale.md`**: Database transactions, atomic operations, deterministic lock ordering, index planning, N+1 query elimination, and zero-downtime migration patterns (Expand-Migrate-Contract).
5. **`04-security-and-validation.md`**: Authentication enforcement, authorization & tenant scoping, IDOR/BOLA prevention, schema validation, mass assignment prevention, and response data sanitization.
6. **`05-async-queues-and-integrations.md`**: Async boundaries, keeping network side effects outside DB transactions, durable delivery for business-critical events, and avoiding artificial queue infrastructure.
7. **`06-observability-performance-and-ops.md`**: Structured logging, health checks, error budgets, and performance profiling.
8. **`07-testing-validation-and-delivery.md`**: Executable syntax verification, test strategy, and diff review before delivery.

## Key Directives
- **Security by Design**: Every endpoint must verify authentication, authorization, and ownership. Never accept raw tenant or user ownership IDs from client request bodies.
- **Transactional Atomicity**: Multi-row or cross-table mutations that represent a business invariant MUST be wrapped in transactions with full rollback on failure.
- **Isolate Side Effects**: External network calls (SMS, Email, Payment Gateways) MUST NOT be executed inside database transactions.
