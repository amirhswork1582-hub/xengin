# 04 Ui Quality And Accessibility

> Load this module when the task touches these concerns. `00-core-rules.md` remains authoritative and always loaded.

# 37. Loading / Empty / Error / Success

For data-driven UI, handle applicable states intentionally:

```text
Loading
Empty
Error
Success
```

Example:

```text
Loading → skeleton
Empty   → meaningful empty state
Error   → error UI + retry when appropriate
Success → actual content
```

Do not implement only the happy path.

---
---

# 38. Layout Stability / CLS

Reserve space for dynamic or media content where appropriate.

Use project-appropriate techniques such as:

```text
width / height
aspect-ratio
min-height
skeletons
reserved containers
```

Skeletons SHOULD approximately match final content dimensions.

Goal:

```text
Loading should not rearrange the page unnecessarily.
```

---
---

# 39. Phased UI Development

For substantial new pages/features, SHOULD establish first:

```text
Phase 1 — structure / layout / responsive behavior
Phase 2 — component contracts / visual detail
Phase 3 — state / logic / data
Phase 4 — validation / polish
```

This is a complexity tool, not mandatory ceremony.

Tiny changes MUST NOT be artificially expanded into multiple phases.

Only pause for phase approval when the user has explicitly requested a staged approval workflow.

If such a workflow requires visual approval after the skeleton phase, stop at that checkpoint before deep styling/logic.

---
---

# 40. Accessibility

Baseline accessibility is part of frontend quality.

SHOULD use:

```text
semantic HTML
button for actions
link for navigation
labels for inputs
keyboard-accessible interactions
appropriate focus behavior
useful image alt text
native semantics before ARIA
```

Bad:

```tsx
<div onClick={deleteUser}>Delete</div>
```

Better:

```tsx
<button type="button" onClick={deleteUser}>
  Delete
</button>
```

Use established accessible primitives for dialogs, menus, and custom widgets when available.

---
---

# 41. Responsive & Styling Conventions

When modifying UI:

```text
- respect existing breakpoints
- check relevant viewport sizes
- follow the existing styling system
- reuse design tokens/primitives when available
```

Do not casually mix styling architectures.

Do not create a new design-system primitive if an existing one supports the requirement cleanly.

---
---

# 42. Performance Without Premature Optimization

Do not optimize imaginary bottlenecks.

These are not default decorations:

```text
useMemo
useCallback
memo
virtualization
complex caching
```

Use them only with a concrete reason such as:

```text
measurably expensive work
meaningful rerender issue
required stable reference
large-list rendering problem
library contract
```

Prefer correctness and clarity before speculative optimization.

---
