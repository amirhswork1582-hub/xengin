# 05 — Async, Concurrency, Queues & Integrations

Use this module for external APIs, retries, timeouts, idempotency, background jobs, queues, events, and distributed coordination.

---

## Failure Is Normal

Network calls and distributed work can fail.

For relevant operations, consider:

```text
timeout
retry
duplicate execution
partial failure
out-of-order delivery
provider outage
rate limits
network partition
process crash
```

Do not design only for the happy path.

---

## Timeouts

External calls SHOULD have bounded timeouts according to project conventions.

Avoid requests that can wait indefinitely.

Timeouts should reflect:

```text
provider behavior
user request latency budget
background-job context
retry strategy
```

---

## Retry Safety

Retry only when the operation and failure are retry-safe.

Consider:

```text
Is the operation idempotent?
Could retry duplicate side effects?
Which errors are transient?
How many attempts?
What backoff?
Is jitter useful?
```

Do not retry validation/auth failures.

Do not create retry storms.

---

## Idempotency

Idempotency is important when the same logical operation may be delivered more than once.

Examples:

```text
payment creation
webhook processing
job execution
order creation
external callback
retryable command
```

Possible mechanisms:

```text
idempotency key
unique database constraint
deduplication table
state-transition guard
provider request key
```

Choose the simplest mechanism that reliably protects the invariant.

---

## Background Jobs

Move work to a background job when justified by:

```text
long runtime
non-blocking side effect
retry requirement
batch work
scheduled work
expensive processing
external integration
```

Do not create a queue for trivial fast synchronous work.

### Delivery Criticality: Best-Effort vs Business-Critical

Distinguish the business criticality of background actions:

1. **Best-Effort** (e.g. non-critical activity notifications, UI hints, loose analytics):
   - In-process fire-and-forget (`try/catch` with logging) is acceptable to avoid premature infrastructure.
2. **Business-Critical** (e.g. payment confirmations, account activations, financial ledger entries, regulatory logs):
   - In-process fire-and-forget is UNACCEPTABLE (a process crash or restart drops the event silently).
   - MUST use a durable delivery mechanism (durable job queue, transactional outbox table, or background reconciliation job).

Rule:
```text
notification nice-to-have → fire-and-forget is acceptable.
notification business-critical → durable delivery mechanism required.
```

---

## Job Safety

A background job SHOULD define, when relevant:

```text
payload contract
retry behavior
maximum attempts
timeout
idempotency
duplicate handling
failure visibility
dead-letter/final-failure handling
```

Job payloads SHOULD contain stable identifiers rather than huge stale object snapshots when practical.

---

## Queue Choice

Do not introduce RabbitMQ/Kafka/NATS/Redis queues automatically.

Choose based on actual semantics:

```text
simple background jobs
durable work queue
ordering
fan-out
event replay
throughput
consumer groups
delivery guarantees
operational maturity
```

A database-backed job queue may be sufficient for many systems.

Infrastructure complexity must be justified by the workload.

---

## Events vs Commands

Distinguish:

```text
Command → asks a specific action to happen
Event   → reports that something already happened
```

Do not use event-driven architecture solely to decouple code aesthetically.

Use events when independent consumers and failure isolation provide real value.

---

## Delivery Semantics

Assume "exactly once" is difficult across distributed systems.

Design consumers to tolerate at-least-once delivery when the chosen infrastructure has that behavior.

Do not rely on marketing labels without understanding actual broker/consumer semantics.

---

## Outbox Pattern

The transactional outbox MAY be appropriate when:

```text
database state change
+
message/event publication
```

must not diverge.

Do not introduce an outbox for low-risk non-critical notifications without need.

---

## Distributed Locks

Distributed locks MAY be needed for cross-instance mutual exclusion.

Before using one, consider whether a database constraint/atomic update solves the problem more safely.

If using distributed locks, consider:

```text
lease expiry
process crash
clock/time assumptions
lock ownership token
renewal
split-brain/fencing where required
```

Do not implement naive lock/unlock logic.

---

## External API Integration

Before integrating a provider, inspect:

```text
official API contract
authentication method
timeouts
rate limits
pagination
retry guidance
idempotency support
webhook behavior
error model
sandbox/testing mode
```

Do not guess provider behavior when documentation or existing project code is available.

---

## Partial Failure

For multi-step workflows across systems, identify what happens if each step fails.

Example:

```text
DB write succeeds
payment succeeds
email fails
queue publish fails
```

Decide which failures are critical and which may be retried/reconciled.

Do not wrap distributed systems in a fake "transaction" abstraction that cannot actually guarantee atomicity.

---

## Scheduled Jobs

Cron/scheduled work SHOULD consider:

```text
overlap
duplicate run
missed run
timezone
long execution
leader election when multiple instances run schedulers
retry
observability
```

Do not assume only one application instance will execute a scheduler unless deployment guarantees it.

---

## Real-Time Transport

Choose between polling, SSE, WebSocket, or pub/sub based on interaction needs.

Do not use WebSocket just because data changes often.

Consider:

```text
one-way vs two-way
frequency
connection count
authorization
reconnect
backpressure
message ordering
horizontal scaling
```
