# 01 — Project Workflow & Architecture

Use this module for project discovery, scope control, architecture decisions, refactoring, and impact analysis.

---

## Detect Project Mode

Before meaningful implementation, determine whether this is:

```text
A. Existing Project
B. New / Nearly Empty Project
```

Do not apply a greenfield architecture workflow blindly to an existing backend.

---

## Existing Project — Pre-flight Inspection

For an existing project, MUST inspect enough of the relevant codebase to make a safe change.

Inspection depth MUST be proportional to scope.

### Knowledge Graph & Graphify Pre-flight Detection

During pre-flight, detect whether Graphify output (`graphify-out/`) or an architectural knowledge graph is available.

- **Medium / High Blast Radius & Dependency Discovery**: For medium/high blast-radius tasks, or when dependency, consumer, service-flow, or architecture discovery materially matters, **SHOULD** inspect the relevant Graphify report (`graphify-out/GRAPH_REPORT.md` or graph query tools) before deep manual exploration.
- **Small / Local Tasks**: For small/local tasks (e.g. minor text copy, localized styling, simple isolated leaf logic), Graphify inspection may be skipped.
- **Source Verification**: Graph findings **MUST** be verified against source code (never treat graph metadata as an excuse to skip verifying actual source code).

Check relevant parts of:

```text
- service/module boundaries
- framework and runtime versions
- package/dependency manifest
- package manager
- environment/config conventions
- routing/controllers/handlers
- service/business-logic layer
- data-access/repository/ORM conventions
- database schema and relevant migrations
- authentication/authorization conventions
- validation mechanism
- error-handling conventions
- background-job/queue conventions
- caching conventions
- logging/observability conventions
- similar maintained features
- build/typecheck/lint/test scripts
```

Do not inspect unrelated areas without a reason.

---

## Find Existing Patterns Before Creating New Ones

Before introducing a new:

```text
service pattern
repository pattern
API style
validation mechanism
cache
queue
event bus
auth abstraction
database abstraction
folder structure
```

search for an existing equivalent.

Prefer:

```text
1. nearest relevant maintained feature
2. dominant current project pattern
3. documented project convention
4. a new pattern only when necessary
```

Do not copy legacy/deprecated code merely because it exists.

---

## Classify Target Architecture

Assess only the area relevant to the requested change.

```text
A. Healthy
B. Imperfect but usable
C. Unsafe to extend without limited refactoring
```

### A. Healthy

MUST follow the existing pattern.

### B. Imperfect but usable

```text
Small problem → Small Safe Change.
```

Do not turn a small feature into cleanup work.

### C. Unsafe to extend

Examples:

```text
one handler owns routing + validation + business rules + SQL + auth + external calls
shared module has undocumented global side effects
a service mixes unrelated bounded responsibilities
a critical write path has no atomicity boundary
```

MUST NOT blindly add another responsibility.

Perform only the smallest structural correction required for safe implementation.

---

## Local Refactor vs System Refactor

Local refactors MAY include:

```text
extract a coherent service/helper
separate validation from business logic
define a missing type/schema
move one data-access concern to the existing repository/data layer
remove duplication directly involved in the task
```

System refactors include:

```text
replace ORM
replace database
replace auth system
replace API style
introduce event-driven architecture
change package manager
reorganize the whole repository
replace queue/cache infrastructure
```

MUST NOT perform a system refactor as a side effect of a local feature.

---

## Minimal Safe Diff

Minimal Diff does not mean the fewest changed lines.

```text
Minimal Safe Diff =
the smallest coherent change that is correct,
secure, data-safe, maintainable, and consistent with the project.
```

Do not mix unrelated cleanup with feature work.

A slightly larger change that preserves the project's correct abstraction is preferable to a tiny architectural hack.

---

## Change Scope & Blast Radius

Classify roughly:

```text
S — Local
M — Feature-level
L — Cross-cutting / Data-sensitive
```

### S — Local

Examples:

```text
copy/message change
small validation rule
local serializer change
simple internal helper
```

### M — Feature-level

Examples:

```text
new endpoint
new mutation
new background job
new integration call
new business rule
```

### L — Cross-cutting / Data-sensitive

Examples:

```text
database schema
shared API contract
authentication
authorization
tenant isolation
shared request middleware
shared transaction helper
cache infrastructure
queue/event infrastructure
global error handling
```

MUST perform impact analysis before editing.

```text
Higher blast radius → stronger inspection and validation.
```

---

## No Hypothetical Architecture

MUST NOT add architecture, infrastructure, abstraction, or extension points solely for imagined future scenarios.

Suspicious reasoning:

```text
"we may need microservices later"
"we may need Kafka later"
"we may reach millions of users"
"this might become multi-region"
"let's make it generic just in case"
```

Future-facing design MAY be justified when:

```text
- the user explicitly requests it
- the current system already has that constraint
- a public contract already requires it
- current demonstrated complexity makes the requested change unsafe without it
```

Design for realistic growth, not imaginary hyperscale.

---

## Technology & Infrastructure Decision Gate

Do not add technology because it is fashionable.

Before adding infrastructure such as:

```text
Redis
Memcached
RabbitMQ
Kafka
NATS
Elasticsearch/OpenSearch
WebSocket infrastructure
object storage
CDN
distributed locks
read replicas
```

answer:

```text
What concrete problem exists?
Can the current stack solve it safely?
What failure modes does the new technology add?
What operational burden does it create?
Does it change deployment/cost?
Is it already used in the project?
```

Rule:

```text
Choose infrastructure from the problem,
not the problem from the infrastructure.
```

---

## Handling Ambiguity

When a request is ambiguous:

```text
1. inspect the project first
2. use existing behavior/contracts when they clearly resolve ambiguity
3. make low-risk reversible inferences only when reasonable
4. ask only when ambiguity materially changes:
   - user-visible behavior
   - destructive actions
   - data meaning
   - public API contracts
   - authorization/security
   - database schema
   - infrastructure/cost
```

Do not block on trivial details that can safely follow established conventions.

When the user is non-specialist, explain high-impact choices in plain language instead of asking them to select unfamiliar technologies.
