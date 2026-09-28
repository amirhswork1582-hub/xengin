# 06 — Observability, Performance & Operations

Use this module for logging, metrics, health checks, performance decisions, deployment-aware behavior, and operational safety.

---

## Observability Is for Diagnosis

Observability SHOULD help answer:

```text
What failed?
Where?
For whom/request?
How often?
Since when?
What changed?
```

Do not log every line of execution.

---

## Logging

Log operationally meaningful events according to project conventions.

Useful context may include:

```text
request/correlation ID
operation name
resource ID
tenant ID when safe
provider name
job ID
error category
duration
```

MUST NOT log secrets or sensitive payloads blindly.

---

## Structured Logging

If the project uses structured logs, preserve that pattern.

Prefer fields over string-concatenated blobs when logs are machine-searched.

Do not introduce a new logging stack for a local feature.

---

## Metrics

Metrics MAY be useful for:

```text
request rate
latency
error rate
queue depth
job failure rate
cache hit rate
database saturation
external provider failures
```

Add metrics when they materially improve operation of the feature.

Do not instrument everything by default.

---

## Tracing

Distributed tracing MAY be useful across service boundaries or complex request chains.

Do not add tracing infrastructure for a simple monolith without need.

Preserve existing trace/correlation propagation when present.

---

## Health Checks

Health endpoints SHOULD reflect deployment needs.

Distinguish when relevant:

```text
liveness  → should process be restarted?
readiness → can this instance serve traffic?
```

Do not make liveness depend on every external service if that would cause restart storms.

---

## Performance Gate

Do not optimize imaginary bottlenecks.

Before optimization, identify:

```text
measured or credible hot path
frequency
data size
latency source
CPU/memory/IO cost
database behavior
network behavior
```

Prefer fixing the actual bottleneck.

---

## Caching vs Query Optimization

Before adding cache:

```text
inspect query
inspect indexes
inspect unnecessary data loading
inspect repeated computation
```

Cache may hide an inefficient data path while adding invalidation complexity.

Use cache when its trade-off is justified.

---

## Memory Safety

Avoid loading unbounded data/files into memory.

For large payloads consider:

```text
streaming
chunking
pagination
batching
size limits
temporary storage
```

Do not add streaming complexity to tiny bounded payloads.

---

## CPU-Heavy Work

CPU-intensive work may block event loops or request workers.

When relevant, consider:

```text
worker process
background job
native/library implementation
batch processing
rate limiting
```

Do not move work off-thread/process without understanding framework/runtime behavior.

---

## Database Load

Watch for:

```text
unbounded queries
N+1
long transactions
too many concurrent queries
missing indexes
expensive counts
high-frequency polling
```

Performance changes SHOULD preserve correctness.

---

## Cache Failure

Application behavior SHOULD define what happens when cache is unavailable.

For ordinary caches:

```text
cache miss/failure often should fall back to source of truth
```

For Redis used as coordination/rate-limit/session infrastructure, failure semantics may be different and must be explicit.

---

## Capacity Thinking

For important endpoints/features, reason about realistic scale dimensions:

```text
requests per second
dataset size
payload size
concurrent jobs
external provider limits
database connections
cache memory
```

Do not demand precise capacity planning for every small task.

---

## Deployment Compatibility

For changes that may run during rolling deployments, consider coexistence of old and new application versions.

Relevant areas:

```text
database migrations
message payloads
API contracts
cache formats
shared serialized data
```

Prefer backward-compatible rollout when feasible.

---

## Feature Flags

Feature flags MAY reduce rollout risk for significant behavior changes.

Do not add a feature-flag system for every feature.

Existing feature-flag infrastructure SHOULD be reused when appropriate.

---

## Graceful Shutdown

Servers/workers SHOULD follow framework/project conventions for shutdown.

When relevant, consider:

```text
stop accepting new work
finish/abort in-flight work safely
close consumers
release resources
close connections
```

Do not invent complex shutdown orchestration for platforms that already handle it.

---

## Resource Limits

Where relevant, bound:

```text
request body size
file upload size
concurrency
batch size
queue payload size
response size
execution time
```

Unbounded resource consumption can become both a reliability and security problem.
