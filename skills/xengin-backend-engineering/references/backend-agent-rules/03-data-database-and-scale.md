# 03 — Data, Database, Migrations & Scale

Use this module for schema changes, queries, large datasets, transactions, consistency, indexing, pagination, and database scaling.

---

## Data Integrity First

A backend feature that produces inconsistent or corrupt data is not complete.

Before changing a write path, identify:

```text
source of truth
affected tables/documents
constraints
transaction boundary
related side effects
failure points
concurrent access
retry behavior
```

---

## Never Assume Datasets Stay Small

Code that works with 100 rows may fail with millions.

For data-access paths that may grow, consider:

```text
bounded result size
pagination
query selectivity
indexes
sorting cost
join cost
N+1 behavior
memory usage
batching
streaming where appropriate
connection usage
transaction size
```

Rule:

```text
Design for realistic growth,
not imaginary hyperscale.
```

Ask:

```text
What happens if this dataset is 100x larger?
```

Do not automatically design for billions of records.

---

## Query Safety

Avoid accidental unbounded operations such as:

```text
load entire table
load every relationship
fetch huge blobs unnecessarily
perform application-side filtering when database filtering is appropriate
run one query per item unintentionally
```

Select only the data needed when doing so materially improves safety/performance.

Do not micro-optimize trivial queries without evidence.

---

## N+1 Queries

When loading collections plus related data, inspect query behavior.

Example risk:

```text
1 query for 100 orders
+
100 queries for each order's user
```

Use project-appropriate eager loading, joins, batching, or data-loader patterns when a real N+1 exists.

Do not over-fetch huge relationship graphs merely to avoid N+1.

---

## Indexing

Indexes SHOULD be driven by actual query patterns.

Before adding an index, identify:

```text
filter predicates
join keys
sort order
uniqueness requirement
query frequency
table size
write frequency
existing indexes
```

Remember:

```text
indexes improve some reads
but add storage and write/maintenance cost
```

Do not index every column.

For new high-value query patterns on large tables, SHOULD consider whether an index is required.

---

## Pagination Strategy

Offset pagination is often sufficient for moderate, stable browsing.

Cursor/keyset pagination MAY be preferred when:

```text
datasets are large
deep pagination is common
ordering is stable
rows change frequently
latency of large OFFSET becomes material
```

Do not introduce cursor complexity without need.

---

## Transactions

Use a transaction when multiple database changes must succeed or fail as one logical unit.

Example:

```text
create order
decrement stock
record payment state
write ledger entry
```

If partial completion would violate an invariant, an atomic boundary may be required.

Do not place slow external network calls inside long database transactions unless the architecture specifically requires and safely supports it.

Keep transactions as small as correctness permits.

---

## External Side Effects & Transactions

Database transactions cannot automatically roll back:

```text
email sent
payment provider charge
third-party API call
message already delivered
```

For workflows combining database state and external side effects, consider project-appropriate patterns such as:

```text
outbox pattern
idempotent consumers
state machine/status transitions
reconciliation jobs
compensating action
```

Use these only when the failure mode justifies them.

---

## Concurrency & Race Conditions

Shared mutable data can be changed by concurrent requests.

Risk examples:

```text
inventory decrement
balance updates
seat booking
coupon redemption
username uniqueness
job claiming
counter updates
```

Consider when relevant:

```text
atomic database update
unique constraint
optimistic concurrency/version column
pessimistic locking
transaction isolation
distributed lock
```

Prefer database-native atomicity/constraints over application-only "check then write" logic when practical.

Do not add locks for concurrency that cannot realistically occur.

---

## Database Constraints

Important invariants SHOULD be enforced at the strongest practical layer.

Examples:

```text
uniqueness
foreign keys
non-null requirements
valid relation ownership
check constraints when supported and appropriate
```

Application validation alone may be insufficient under concurrency.

---

## Schema Change Safety

Schema changes are not ordinary code edits.

Before schema modification, inspect:

```text
existing data
current migrations
deployment model
running old/new application versions
backfill requirements
downtime tolerance
rollback/forward-fix strategy
```

High-risk examples:

```text
drop column
rename column
change type
nullable → non-nullable
enum changes
large-table backfills
new uniqueness constraint
```

---

## Migration Rules

MUST NOT rewrite already-applied production migration history unless the project explicitly uses a workflow that permits it.

Prefer new migrations.

Migration code SHOULD be:

```text
deterministic
reviewable
safe for existing data
compatible with deployment order
```

---

## Expand → Migrate → Contract

For risky production schema changes, SHOULD consider staged compatibility:

```text
1. Expand
   add new schema in a backward-compatible way

2. Migrate
   backfill / dual-read / dual-write if necessary

3. Contract
   remove old schema only after consumers no longer depend on it
```

Do not force this ceremony onto trivial development-only databases.

---

## Backfills

Large backfills SHOULD consider:

```text
batch size
locks
transaction duration
replication lag
retry behavior
restartability
observability
production load
```

Do not load the entire dataset into memory for a large migration.

Backfills SHOULD be idempotent or safely restartable when interruption is possible.

---

## Read Replicas

Read replicas MAY help read-heavy systems.

Before using them, consider:

```text
replication lag
read-after-write expectations
routing complexity
failover
consistency requirements
```

Do not send consistency-sensitive reads to a lagging replica blindly.

---

## Partitioning & Sharding

Partitioning/sharding are advanced responses to demonstrated scale constraints.

MUST NOT introduce them merely because a table may become large.

Consider only after evaluating simpler measures:

```text
correct indexes
query improvement
archival
pagination
batching
vertical scaling
read replicas
partitioning
```

Sharding introduces major complexity:

```text
routing
cross-shard queries
transactions
rebalancing
operational recovery
```

---

## Connection Management

Respect the project's connection-pool strategy.

Consider:

```text
pool size
serverless connection bursts
long transactions
idle connections
database limits
```

MUST NOT create a new database connection/client per request if the framework/driver expects shared pooling.

---

## Data Retention & Deletion

When deleting data, determine whether requirements imply:

```text
hard delete
soft delete
archive
anonymization
cascade
retention period
audit preservation
```

Do not invent retention/compliance rules.

For destructive data changes, prefer explicit and reviewable behavior.
