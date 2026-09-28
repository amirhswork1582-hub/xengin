# 03 State Data And Effects

> Load this module when the task touches these concerns. `00-core-rules.md` remains authoritative and always loaded.

# 21. Data Ownership Gate

Before creating state, determine its natural owner:

```text
1. Backend source of truth?  → Server State
2. Editable draft?           → Form State
3. Must survive/share URL?   → URL State
4. Temporary interface state?→ UI State
5. Can be calculated?        → Derived State
6. Truly cross-feature?      → Consider shared/global ownership
```

State MUST NOT become global merely because passing a few props is inconvenient.

---
---

# 22. Server State

Server State includes data whose authoritative source is the backend:

```text
users
orders
products
profile
```

If the project already uses a server-state mechanism, SHOULD follow it.

Avoid copying server data into local state without a distinct ownership reason.

A local copy MAY be valid when it represents a different concept such as an editable draft.

---
---

# 23. UI State

Temporary UI state SHOULD stay as local as practical.

Examples:

```text
isDialogOpen
activeTab
selectedRowId
isSidebarOpen
```

Do not move local modal state into a global store without a real cross-feature need.

---
---

# 24. Form State

Form values are usually an editable draft, distinct from server state.

MUST NOT mutate server/query data directly to represent unsaved edits.

Follow the project's existing form and validation conventions.

Validation logic SHOULD have one clear source rather than being duplicated across effects, JSX, submit handlers, and helpers.

---
---

# 25. URL State

Use URL state when product behavior benefits from:

```text
refresh persistence
back / forward behavior
shareable links
bookmarking
```

Common candidates:

```text
page
search
sort
filter
selected view
```

Do not put ephemeral state such as tooltip visibility in the URL.

### Framework-Managed State Integration

When integrating with framework-managed state (router, server cache, form library, auth):
- MUST use the framework/project's official reactive APIs (e.g. `useSearchParams`, `useLocation`, router hooks) rather than reading or mutating globals directly (`window.location.search`, `document.cookie`).
- Mutable browser globals do not trigger framework lifecycle or re-renders reliably.

Simple meaning:
```text
اگر Router خودش راه رسمی برای فهمیدن URL دارد، از همان استفاده کن؛ از پنجره کنار ساختمان وارد نشو.
```

---
---

# 26. Derived State & Single Source of Truth

If a value can be reliably calculated from existing state/props, derive it.

Bad:

```tsx
const [users, setUsers] = useState([]);
const [activeUsers, setActiveUsers] = useState([]);

useEffect(() => {
  setActiveUsers(users.filter(user => user.active));
}, [users]);
```

Better:

```tsx
const activeUsers = users.filter(user => user.active);
```

Rule:

```text
Do not store what can be reliably derived.
```

Avoid chains of synchronized copies.

---
---

# 27. Prop Drilling

A small amount of prop passing is normal.

Do not create Context/global state only to avoid one or two levels of props.

Reassess ownership when:

```text
many intermediary components only forward data
multiple independent branches need the same state
component APIs become dominated by pass-through props
```

Possible escalation:

```text
local state
→ nearest common owner
→ feature context/store if justified
→ global state only for genuinely global concerns
```

---
---

# 28. useEffect Gate

Before writing a new `useEffect`, answer:

```text
What external system or side effect am I synchronizing with?
```

Common valid uses:

```text
subscriptions
event listeners
timers
browser APIs
imperative third-party libraries
manual external synchronization
```

Common suspicious uses:

```text
calculate a display value
filter an array
copy props into state
copy query data into local state
update one state because another state changed
run logic that belongs directly in a click/submit handler
```

For subscriptions, listeners, timers, or similar effects, MUST implement appropriate cleanup.

Effects SHOULD be safe under the lifecycle behavior of the project's React/framework version.

---
---

# 29. Business Logic & JSX

JSX SHOULD primarily describe rendering.

Avoid burying substantial business rules in render expressions.

Bad:

```tsx
{users
  .filter(...)
  .sort(...)
  .map(...)
  .filter(...)
  .reduce(...)}
```

Better:

```tsx
const visibleUsers = getVisibleUsers(users, filters);
return <UserList users={visibleUsers} />;
```

Trivial display expressions do not need artificial helper functions.

---
---

# 30. TypeScript Safety

MUST solve type problems rather than hide them.

Avoid using as default fixes:

```text
any
as any
@ts-ignore
@ts-expect-error
unsafe non-null assertions
```

Such escapes MAY be used only when the reason is concrete and defensible.

Rule:

```text
Fix the type problem.
Do not silence the type checker.
```

Reuse existing project types before defining duplicates.

---
---

# 35. API / Data Layer

Follow the existing healthy API/data pattern.

If the project centralizes networking, MUST NOT scatter new raw network calls through UI components.

A common conceptual flow is:

```text
UI
→ feature logic
→ API/data layer
→ shared client
```

The exact folder structure is project-specific.

Do not create a second API client without a concrete reason.

---
---

# 36. Async & Mutation Safety

For async actions, consider when relevant:

```text
duplicate submission
out-of-order responses
stale results
loading ownership
error handling
cancellation / ignore behavior
```

For destructive actions:

```text
- follow existing confirmation patterns
- avoid accidental duplicate execution
- surface failures
- keep cache/state consistent
```

Do not add complex concurrency machinery unless the task actually needs it.

---
---

# 48. Error Handling

MUST NOT silently swallow meaningful failures.

Bad:

```ts
try {
  await save();
} catch {}
```

Handle errors according to project conventions.

Relevant failures SHOULD be surfaced to the user or represented/logged through the existing application mechanism.

Do not show success before actual success unless the project deliberately uses a safe optimistic strategy.

---
---

# 47. Security-Sensitive UI

Frontend visibility is not authorization.

```text
Hiding a Delete button ≠ securing delete permission.
```

Frontend permission checks improve UX but MUST NOT be treated as a replacement for backend authorization.

Do not expose secrets in client code.

---
