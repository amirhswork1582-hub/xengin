# 02 Components And Architecture

> Load this module when the task touches these concerns. `00-core-rules.md` remains authoritative and always loaded.

# 14. Component Responsibility

A component SHOULD have a coherent responsibility.

Avoid combining many independent concerns in one module:

```text
rendering
network calls
business rules
validation
filter engines
multiple modal workflows
complex transformations
```

MUST NOT extract components merely to satisfy arbitrary size rules.

Rule:

```text
Responsibility > line count.
```

Line count is a smell signal, not a refactor trigger.

---
---

# 15. Avoid Over-fragmentation

Before extraction ask:

```text
Does it own a coherent responsibility?
Does it isolate meaningful complexity?
Does it improve the parent substantially?
Is there real reuse?
Does it create a useful contract?
```

If not, keep it local.

Avoid meaningless fragmentation such as:

```text
UserNameWrapper
UserNameContainer
UserNameText
UserNameValue
```

for trivial UI.

---
---

# 16. Page as Orchestrator — When Complexity Justifies It

For medium/large features, a page MAY mainly coordinate meaningful subparts:

```text
UsersPage
 ├── UsersToolbar
 ├── UsersTable
 ├── DeleteUserDialog
 └── feature hooks / data layer
```

This is a useful pattern, not a mandatory shape.

MUST NOT manufacture many files just to make the page visually small.

---
---

# 17. Component API Design

Component APIs SHOULD expose intent and hide implementation details.

Good:

```tsx
<UserDialog
  open={open}
  user={user}
  onClose={handleClose}
  onSubmit={handleSubmit}
/>
```

Avoid leaking internal mechanics:

```tsx
<UserDialog
  isStepOne={...}
  setIsStepOne={...}
  rawInternalState={...}
  resetInternalFields={...}
/>
```

---
---

# 18. Shared Component Safety

Before changing a shared component, design-system primitive, hook, helper, or shared type for one feature, MUST inspect relevant existing consumers.

MUST NOT make a shared contract feature-specific in a way that silently breaks unrelated consumers.

Prefer, when appropriate:

```text
1. backward-compatible extension
2. local composition
3. feature-level wrapper
4. breaking shared-contract change only when explicitly justified and scoped
```

Example:

```text
Do not change the global Button behavior just to satisfy one page
without checking the other places that rely on Button.
```

Higher reuse means higher responsibility to preserve the public contract.

---
---

# 19. Boolean Props

Boolean props are not inherently bad.

These are normal:

```tsx
<Button disabled />
<Dialog open />
```

Avoid boolean explosion where many flags create unclear or contradictory combinations.

Prefer semantic APIs when they better express intent.

---
---

# 20. Custom Hooks

Create a custom hook when it encapsulates a coherent React-related responsibility such as:

```text
stateful feature behavior
reusable React behavior
complex lifecycle / side-effect logic
coherent feature orchestration
```

MUST NOT create trivial hooks only to satisfy a rule.

MUST NOT move an entire spaghetti component unchanged into:

```text
useEverythingPage()
```

Moving complexity is not the same as organizing complexity.

---
---

# 43. Reuse & Abstraction

Before creating a new abstraction, search for an existing equivalent.

But:

```text
similar-looking code ≠ same concept
```

Do not force unrelated behaviors into a generic abstraction merely to reduce duplication.

Rules:

```text
Reuse real concepts, not accidental similarity.
Evidence before abstraction.
```

A little duplication can be safer than the wrong abstraction.

---
---

# 44. Shared / Utility Module Hygiene

Avoid generic dumping grounds:

```text
utils.ts
helpers.ts
common.ts
misc.ts
```

Feature-specific logic SHOULD generally stay near the feature.

Prefer concept-specific names when extraction is justified:

```text
formatCurrency.ts
userPermissions.ts
dateRange.ts
```

A shared module should represent a genuinely shared concept.

---
---

# 46. Preserve Product Behavior During Refactoring

Refactoring MUST preserve observable behavior unless behavior change is explicitly part of the task.

Do not silently alter:

```text
sorting
validation semantics
default filters
navigation flow
confirmation behavior
permission behavior
API semantics
```

Cleaning code is not permission to redesign the product.

---
