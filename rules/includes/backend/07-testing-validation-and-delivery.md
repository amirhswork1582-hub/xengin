# 07 — Testing, Validation & Delivery

Use this module when implementing or completing repository changes.

---

## Testing Depth Matches Risk

Testing SHOULD reflect:

```text
task risk
blast radius
data sensitivity
security sensitivity
existing test conventions
```

Possible levels:

```text
unit
service
repository
database integration
API integration
contract
job/queue integration
E2E
targeted manual validation
```

MUST inspect existing test conventions before adding tests.

MUST NOT introduce a new testing framework for a small unrelated task without authorization.

---

## Bug Fixes

For bug fixes, SHOULD add/update a regression test when:

```text
a suitable test setup exists
the behavior is reasonably testable
```

The regression test SHOULD fail for the original bug and pass after the fix where practical.

---

## Security-Sensitive Tests

When changing:

```text
authorization
tenant isolation
authentication
input validation
file access
webhooks
```

SHOULD test relevant denied/invalid paths, not only successful access.

Examples:

```text
user can access own resource
user cannot access another tenant's resource
invalid signature is rejected
forbidden role gets denied
```

---

## Data Integrity Tests

For write paths with invariants, test relevant failure/edge cases.

Examples:

```text
duplicate request
concurrent update where testable
partial failure
transaction rollback
unique constraint
invalid state transition
```

---

## API Contract Tests

When changing public API behavior, validate:

```text
request compatibility
response shape
status/error semantics
pagination/filtering behavior
authentication requirements
```

Do not rely only on internal unit tests when the contract itself changed.

---

## Migration Validation

For schema/migration changes, when feasible:

```text
apply migration to representative existing schema/data
verify application reads/writes
verify constraints
verify backfill behavior
verify rolling compatibility when relevant
```

Do not claim migration safety merely because the migration file parses.

---

## Default Validation Workflow

Before declaring completion, run relevant project-declared checks when available.

Typical sequence:

```text
1. targeted tests
2. typecheck / compile
3. lint
4. database/migration checks when relevant
5. build
6. broader integration/E2E tests when risk requires
```

Adapt to project scripts.

MUST NOT claim a command passed if it was not run.

---

## Validation Failures

When validation fails:

```text
1. determine whether current changes introduced the failure
2. fix failures introduced by current changes
3. do not silently expand scope to repair unrelated legacy failures
4. report relevant pre-existing failures clearly
```

Do not label a failure "pre-existing" without evidence.

---

## Diff Hygiene

Before completion, review the actual diff.

Check for:

```text
unrelated edits
accidental rewrites
debug logs
temporary code
commented-out code
unused imports
placeholder implementations
unsafe type escapes
unexpected generated changes
unexpected lockfile changes
secret leakage
accidental schema changes
migration changes
auth/permission changes
```

MUST NOT run broad formatting that creates large unrelated diffs unless project workflow requires it.

---

## Complete Code Only

For direct repository changes, MUST NOT leave:

```text
TODO implement later
fake repository methods
undefined helpers
placeholder API calls
incomplete migrations
dummy secrets
partial transaction logic
```

unless the user explicitly requested pseudocode/prototype work.

---

## Definition of Done

A backend task MAY be declared complete only when all applicable required gates pass.

### Required

```text
✓ requested behavior is implemented
✓ no known task-introduced build/type/runtime failure remains
✓ no required code is intentionally incomplete
✓ scope did not expand without reason
✓ relevant dependencies/config/imports are valid
✓ actual diff was reviewed
✓ relevant validation was executed or limitations were explicitly reported
```

### When applicable

```text
✓ authorization/security paths
✓ input validation
✓ data integrity / transaction behavior
✓ migration safety
✓ large-data/query behavior
✓ idempotency/retry behavior
✓ cache/queue failure behavior
✓ API contract compatibility
✓ regression tests
```

If something could not be validated, MUST say so.

### Mandatory Self-Enforcement Inspector Gate

Before declaring completion, the Agent MUST inspect its own changes as an independent inspector:

```text
1. Search modified code for:
   - `any`
   - `@ts-ignore`
   - `@ts-expect-error`
   - empty catch blocks
   - TODO/FIXME introduced by this task

2. For every modified external-input boundary:
   verify explicit validation exists (Zod, Joi, or schema validator).

3. For every modified API response:
   verify sensitive/internal fields (password hashes, secrets, foreign tenant data) cannot leak (explicit select/serializer).

4. For DB writes involving multiple dependent operations:
   verify transaction boundaries, state transitions, and concurrency safety.

5. For background / async jobs:
   verify whether delivery is best-effort or business-critical (durable queue/outbox required if critical).

6. For changed endpoints or public contracts:
   verify backward compatibility for existing consumers/clients.

7. Review the final diff line-by-line against loaded rules.
```

---

## Completion Report

Keep the final report short and factual.

Recommended:

```text
Changed:
- ...

Validated:
- ...

Important decisions:
- ...

Notes / limitations:
- ...
```

For high-impact technical decisions, explain the reason in plain language.

Do not dump hidden/internal reasoning.

Do not claim more than was verified.
