# 01 Workflow Scope And Refactoring

> Load this module when the task touches these concerns. `00-core-rules.md` remains authoritative and always loaded.

# 1. Non-Negotiable Completion Gates

A task is not complete unless all applicable hard gates pass:

```text
1. Safety & Data Integrity
2. Functional / Behavioral Correctness
3. Build / Type / Runtime Integrity
```

A feature that works but breaks the build is not done.

A build that passes while the feature behaves incorrectly is not done.

After the hard gates, use this trade-off order:

```text
Healthy Existing Architecture & Public Contracts
↓
Minimal Safe Change Scope
↓
Maintainability & Testability
↓
Accessibility & UX
↓
Measured Performance
↓
Optional Refactoring / Beautification
```

Core rules:

```text
Healthy existing architecture > Agent preference.
Correctness > broken convention.
```

When accessibility or UX behavior is explicitly required by the task or acceptance criteria, treat it as part of **Functional / Behavioral Correctness**, not as a lower-priority trade-off.

---
---

# 2. Detect Project Mode

Before meaningful implementation, determine whether this is:

```text
A. Existing Project
B. New / Nearly Empty Project
```

Do not apply a greenfield architecture workflow blindly to an existing codebase.

---
---

# 3. Existing Project — Pre-flight Inspection

For an existing project, MUST inspect enough of the relevant codebase to make a safe change.

Goal:

```text
Enough understanding to make a safe change.
```

Not:

```text
Understand the entire repository before touching one button.
```

Inspection depth MUST be proportional to change scope.

### Knowledge Graph & Graphify Pre-flight Detection

During pre-flight, detect whether Graphify output (`graphify-out/`) or an architectural knowledge graph is available.

- **Medium / High Blast Radius & Dependency Discovery**: For medium/high blast-radius tasks, or when dependency, shared components, routing, or state architecture discovery materially matters, **SHOULD** inspect the relevant Graphify report (`graphify-out/GRAPH_REPORT.md` or graph query tools) before deep manual exploration.
- **Small / Local Tasks**: For small/local tasks (e.g. minor text copy, localized CSS/styling, simple isolated leaf component changes), Graphify inspection may be skipped.
- **Source Verification**: Graph findings **MUST** be verified against source code (never treat graph metadata as an excuse to skip verifying actual source code).

Check relevant parts of:

```text
- nearby files and feature boundaries
- package.json
- package manager
- framework and relevant versions
- TypeScript configuration
- import aliases
- routing conventions
- styling / design-system conventions
- state-management patterns
- API / data-fetching patterns
- similar maintained features
- build / typecheck / lint / test scripts
```

Do not inspect unrelated areas without a reason.

---
---

# 4. Find Existing Patterns Before Creating New Ones

Before introducing a new component pattern, hook pattern, API layer, state mechanism, or folder structure, search for an existing equivalent.

Prefer:

```text
1. nearest relevant maintained feature
2. dominant current project pattern
3. documented project convention
4. a new pattern only when necessary
```

Do not copy obviously legacy or deprecated code merely because it exists.

---
---

# 5. Classify the Target Architecture

Assess only the area relevant to the requested change.

Classify it as:

```text
A. Healthy
B. Imperfect but usable
C. Unsafe to extend without limited refactoring
```

## A. Healthy

MUST follow the existing pattern.

```text
Healthy existing architecture > Agent preference.
```

## B. Imperfect but usable

Use:

```text
Small problem → Small safe change.
```

Do not turn a small task into cleanup work.

## C. Unsafe to extend

Examples include one target module owning many independent responsibilities:

```text
UI
API calls
form state
validation
permissions
filters
pagination
modal workflows
data transformation
multiple mutations
```

MUST NOT blindly add another responsibility.

Perform only the smallest structural correction required for safe implementation.

---
---

# 6. Refactor Gate

A local refactor MAY be performed when at least one is true:

```text
- the requested feature cannot be added safely without it
- the current boundary would create substantial duplication
- the existing structure directly causes the bug being fixed
- extending the module would materially increase coupling
- a small extraction is required to preserve an existing contract
```

These are NOT sufficient reasons:

```text
"I prefer another architecture."
"This file is ugly."
"This is not textbook clean architecture."
"The file is longer than I like."
"I can make the whole project cleaner."
```

Rule:

```text
Refactor only enough to make the requested change safe.
```

---
---

# 7. Local Refactor vs System Refactor

## Local Refactor

Examples:

```text
extract one coherent component
extract one coherent hook
move one helper to the correct feature module
remove duplication directly involved in the task
define a missing type
```

MAY be performed when justified by the task.

## System Refactor

Examples:

```text
replace API architecture
replace global state system
change router architecture
change styling architecture
reorganize the whole repository
migrate shared component contracts
change package manager
```

MUST NOT be performed as a side effect of a local feature.

A broad architectural migration requires explicit task scope or user authorization.

---
---

# 8. Minimal Safe Diff

Minimal Diff does not mean the fewest changed lines.

Definition:

```text
Minimal Safe Diff =
the smallest coherent change that is correct,
maintainable, and consistent with the project.
```

MUST NOT mix unrelated cleanup with feature work.

MUST NOT rename, move, reformat, or rewrite unrelated files merely because they can be improved.

A slightly larger change that uses the project's correct existing abstraction is preferable to a tiny architectural hack.

---
---

# 9. Do Not Solve Hypothetical Future Requirements

MUST NOT design architecture around imagined future requirements that are not part of the current task or demonstrated project needs.

Avoid reasoning such as:

```text
"We may need ten implementations later."
"This might become multi-tenant someday."
"Let's generalize this now for future scalability."
```

Prefer:

```text
Solve demonstrated current complexity.
Keep today's design easy to extend when real requirements arrive.
```

Future-aware design is reasonable only when current constraints, existing contracts, or clearly stated roadmap requirements make it relevant now.

Rule:

```text
Architecture should solve demonstrated complexity, not imagined complexity.
```

---
---

# 10. Change Scope & Blast Radius

Classify changes roughly as:

```text
S — Local
M — Feature-level
L — Cross-cutting
```

## S — Local

Examples:

```text
copy change
small visual adjustment
one simple validation
small local interaction
```

Inspect locally and validate the affected area.

## M — Feature-level

Examples:

```text
new modal workflow
new form
new API mutation
new filtering behavior
new feature component
```

Inspect the feature's components, state, API, types, and relevant dependents.

## L — Cross-cutting

Examples:

```text
apiClient
authentication
router
global state
shared design-system primitive
global type contract
root layout
```

MUST perform impact analysis before editing.

Rule:

```text
Higher blast radius → stronger inspection and validation.
```

---
---

# 11. Graphify

When Graphify is available:

```text
Graphify = Map
Source Code = Ground Truth
```

Use Graphify to discover:

```text
dependencies
dependents
central modules
feature boundaries
shared modules
unexpected coupling
potential blast radius
```

Usage by scope:

```text
Local tiny change       → MAY skip
Feature-level change    → SHOULD use when useful
Cross-cutting change    → SHOULD strongly prefer
```

If the graph may be stale and refresh/update is available, SHOULD refresh it before relying on it for impact analysis.

MUST read relevant source code before architectural conclusions.

MUST NOT treat Graphify as a replacement for source inspection.

For an empty project, Graphify is not required.

---
---

# 12. Existing-Project Workflow

Use this workflow proportionally:

```text
User Request
    ↓
Determine Change Scope
    ↓
Inspect Relevant Project Structure
    ↓
Graphify / Dependency Analysis when useful
    ↓
Find Similar Maintained Patterns
    ↓
Read Actual Source Code
    ↓
Assess Architecture
    ↓
Assess Blast Radius
    ↓
Choose Minimal Safe Diff
    ↓
Implement
    ↓
Validate
    ↓
Review Diff
    ↓
Report
```

---
---

# 13. New Project Workflow

For a new or nearly empty project:

```text
Start simple.
Grow architecture with demonstrated complexity.
```

Simple meaning:

```text
برای کشتن پشه تانک نساز.
```

MUST NOT create speculative layers merely because they may be useful later.

Bad for a small app:

```text
domain/
entities/
repositories/
adapters/
controllers/
presenters/
factories/
use-cases/
services/
```

A simpler starting point may be:

```text
features/
  auth/
    components/
    api/
    hooks/
    types.ts
```

Rule:

```text
Architecture should grow because complexity exists,
not because complexity might exist someday.
```

---
---

# 34. Handling Ambiguity

When a request is ambiguous:

```text
1. inspect the project first
2. use existing behavior/conventions when they clearly resolve ambiguity
3. make low-risk reversible inferences only when reasonable
4. ask when ambiguity materially changes:
   - product behavior
   - destructive actions
   - data meaning
   - public contracts
   - architecture
```

Do not block on trivial details that can safely follow established conventions.

---
