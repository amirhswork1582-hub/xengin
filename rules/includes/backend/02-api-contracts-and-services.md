# 02 — API, Contracts & Service Boundaries

Use this module for endpoints, API styles, service boundaries, public contracts, rate limiting, caching decisions, and transport choices.

---

## API Style Selection

Do not assume one API style is always best.

Possible styles include:

```text
REST
RPC
GraphQL
WebSocket
Server-Sent Events (SSE)
webhooks
internal events/messages
```

Selection SHOULD follow actual interaction needs and existing project conventions.

Examples:

```text
ordinary CRUD/resource access      → REST may be sufficient
action-oriented internal commands  → RPC may be clearer
client-selected graph-shaped data  → GraphQL may be justified
bidirectional real-time interaction→ WebSocket may be justified
server-to-client streaming         → SSE may be simpler
system-to-system notification      → webhook/event may be appropriate
```

MUST NOT introduce a new API paradigm merely because it is more sophisticated.

---

## Public Contract Safety

Treat externally consumed API behavior as a public contract when applicable.

This includes:

```text
routes
methods
request shape
response shape
field names
field meaning
status codes
error codes
pagination behavior
sorting/filtering semantics
authentication requirements
idempotency behavior
webhook signatures
```

MUST NOT silently break an established contract.

Prefer backward-compatible extensions where practical.

Breaking changes require explicit task scope and migration/consumer consideration.

---

## Versioning

Do not introduce API versioning automatically.

Use versioning when a real compatibility boundary exists.

Before a breaking API change, inspect:

```text
current consumers
frontend/mobile clients
other services
tests
documentation
webhooks/integrations
```

---

## Request Validation vs Business Rules

Keep these concepts distinct.

Validation example:

```text
email has valid syntax
quantity is an integer > 0
UUID is structurally valid
```

Business-rule example:

```text
this account may create another workspace
this order may still be cancelled
this user may access this tenant
```

Do not treat syntactic validation as authorization or business-rule enforcement.

---

## Response Safety

Do not expose internal persistence models blindly.

Review whether responses leak:

```text
password hashes
secret tokens
internal IDs that should stay private
private flags
security metadata
provider credentials
stack traces
raw database errors
internal-only fields
```

Prefer explicit response schemas/serializers where the project uses them.

---

## Pagination & Collection Endpoints

Potentially large collections SHOULD NOT be unbounded.

Choose pagination based on real needs:

```text
offset/page pagination → simple browsing, moderate datasets
cursor/keyset pagination → large/changing ordered datasets when justified
```

Do not introduce cursor pagination merely because it scales better in theory.

For each collection endpoint, consider:

```text
maximum page size
stable ordering
filtering
sorting
index support
total-count cost
abuse potential
```

---

## Rate Limiting

Rate limiting MAY protect:

```text
login attempts
password reset
OTP endpoints
expensive search
public APIs
webhooks
resource creation
abuse-prone actions
```

Do not add global rate limiting blindly.

Choose storage based on deployment:

```text
single process / low risk       → in-memory may be enough
multiple instances / shared cap → distributed storage such as Redis may be needed
```

Rate limiting is not authorization.

---

## Cache Decision Gate

Do not add cache by default.

Before caching, answer:

```text
Is there a demonstrated expensive read or repeated computation?
What is the source of truth?
How stale may data be?
How is invalidation handled?
What happens on cache failure?
Can a better query/index solve the problem first?
```

Cache hierarchy may include:

```text
request-local memoization
process memory
database/materialized view
Redis/distributed cache
CDN/edge cache
```

Use the simplest level that solves the real problem.

Rule:

```text
Cache is a performance optimization,
not a substitute for correct data ownership.
```

---

## Redis Decision Gate

Redis MAY be appropriate for:

```text
shared cache
distributed rate limiting
short-lived coordination
sessions
idempotency records
queues when the project uses Redis-backed jobs
pub/sub when semantics fit
distributed locks when truly required
```

Redis MUST NOT be introduced just because data is "fast-changing" or "needs scale."

Before using Redis, consider:

```text
persistence expectations
eviction
TTL
cache invalidation
memory limits
high availability
network failure
multi-instance behavior
atomic operations
```

Redis is not automatically the source of truth.

---

## Service Boundaries

A handler/controller SHOULD usually coordinate transport concerns rather than own every responsibility.

Avoid one function that performs all of:

```text
parse request
validate request
authorize
execute business rules
query database
call external provider
send email
format response
write audit log
```

Separate responsibilities when complexity justifies it.

Do not create layers merely to satisfy a textbook architecture.

---

## Internal Contracts

Shared service/repository/module contracts require consumer inspection before breaking changes.

Prefer:

```text
backward-compatible extension
local adapter
feature-level wrapper
```

over changing a shared contract for one caller.

---

## API Error Semantics

Public errors SHOULD be:

```text
safe
stable enough for clients
non-sensitive
consistent with project conventions
```

Do not return raw stack traces, SQL errors, provider secrets, or internal exception objects to clients.

Map internal failures to appropriate public behavior without hiding operational failures from logs/observability.
