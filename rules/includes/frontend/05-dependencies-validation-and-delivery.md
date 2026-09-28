# 05 Dependencies Validation And Delivery

> Load this module when the task touches these concerns. `00-core-rules.md` remains authoritative and always loaded.

# 31. Dependency & Package Safety

Before using third-party code:

```text
1. inspect package.json
2. inspect existing alternatives
3. verify import/API compatibility with the installed version
```

MUST NOT introduce a new third-party dependency casually.

If a new dependency appears materially necessary:

```text
- explain what problem it solves
- explain why existing dependencies are insufficient
- prefer established, well-supported options compatible with the project
- request authorization before installation unless the user's task already explicitly authorizes dependency changes
```

Do not ask for redundant approval when the user has already authorized dependency changes within the task scope.

Do not add a package for trivial logic that existing tools can handle clearly.

---
---

# 32. Imports, Exports & Package Manager

MUST verify:

```text
import paths
path aliases
actual exports
package availability
relevant installed versions
```

Do not invent project modules or export names.

Keep the existing package manager:

```text
package-lock.json      → npm
pnpm-lock.yaml         → pnpm
yarn.lock              → yarn
bun.lock / bun.lockb   → bun
```

MUST NOT switch package managers as part of an unrelated task.

---
---

# 33. No Guess-Driven Coding

Do not guess facts that can be inspected.

Examples:

```text
API function names
component props
route paths
environment variables
types
module locations
package availability
project conventions
```

Rule:

```text
Inspect > Infer > Guess
```

Low-risk inference is acceptable when direct verification is impossible.

Do not infer destructive behavior, data semantics, security rules, or major architecture when uncertainty materially affects the result.

---
---

# 45. Generated Files, Lockfiles & Environment Variables

MUST NOT manually edit generated files unless the project workflow expects it.

Dependency changes SHOULD use the existing package manager and normal lockfile workflow.

Do not regenerate lockfiles for unrelated tasks.

For environment variables:

```text
- inspect existing naming conventions
- verify client/server exposure rules
- do not invent variable names when they can be inspected
- do not expose secrets in frontend code
```

---
---

# 49. Testing

Testing depth SHOULD match task risk and project conventions.

Possible levels:

```text
unit
component
integration
E2E
targeted manual validation
```

MUST inspect existing test conventions before adding tests.

For bug fixes, SHOULD add/update a regression test when:

```text
- a suitable test setup already exists
- the behavior is reasonably testable
```

MUST NOT introduce a new test framework for a small unrelated task without authorization.

---
---

# 50. Validation Workflow

Before declaring completion, run relevant project-declared checks when available.

Default completion validation:

```text
1. relevant targeted tests
2. typecheck
3. lint
4. build
5. broader tests when change scope/risk requires them
```

Adapt command order to project scripts when appropriate.

MUST NOT claim a command passed if it was not run.

If a validation command cannot be run, report that explicitly.

---
---

# 51. Validation Failures

When validation fails:

```text
1. determine whether the failure was introduced by the current change
2. fix failures introduced by the current change
3. do not silently expand scope to repair unrelated legacy failures
4. report relevant pre-existing failures clearly
```

Do not label a failure “pre-existing” without evidence.

---
---

# 52. Diff Hygiene

Before completion, review the actual diff.

Check for:

```text
unrelated edits
accidental file rewrites
debug logs
temporary code
commented-out code
unused imports
unused variables
placeholder implementations
unsafe type escapes
unexpected generated-file changes
unexpected lockfile changes
```

MUST NOT run broad formatting that creates large unrelated diffs unless the project workflow explicitly requires it.

---
---

# 53. Complete Code Only

For direct repository changes, MUST NOT leave:

```text
// rest of code...
// TODO implement this later
undefined helper calls
missing imports
partial function bodies
fake placeholder APIs
```

unless the user explicitly requested pseudocode or a prototype.

---
---

# 54. Definition of Done

The task MAY be declared complete only when all applicable required gates pass.

## Required

```text
✓ requested behavior is implemented
✓ no known task-introduced build/type/runtime failure remains
✓ no required code is intentionally incomplete
✓ scope did not expand without reason
✓ relevant imports/dependencies are valid
✓ actual diff was reviewed
✓ relevant validation was executed or exceptions were explicitly reported
```

## When applicable

```text
✓ loading / empty / error / success states
✓ accessibility basics
✓ responsive behavior
✓ regression tests
✓ Graphify / impact analysis for higher-blast-radius changes
✓ destructive-action safeguards
```

If something could not be validated, MUST say so instead of pretending the task is fully verified.

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
   verify explicit validation exists (Zod, schema, or form validation).

3. For every modified API response / payload:
   verify sensitive/internal fields cannot leak.

4. For every new useEffect:
   state why an effect is actually necessary instead of derived state or handlers.

5. For every changed shared component/API:
   inspect existing consumers for backward compatibility.

6. Review the final diff against the loaded rules.
```

---
---

# 55. Completion Report

Keep the final report short and factual.

Recommended format:

```text
Changed:
- ...

Validated:
- ...

Notes / limitations:
- ...
```

Do not dump internal reasoning.

Do not claim more than was verified.

---
