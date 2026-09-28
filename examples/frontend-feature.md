# Example: Disciplined Frontend Feature Implementation

This example demonstrates how Xengin implements a frontend feature adhering to the core rules: URL as single source of truth, derived state without `useEffect` state syncing, and backward-compatible shared component reuse.

---

## User Prompt

> "Add a filter bar above the projects table with three tabs: All, Active, Archived. Filter results dynamically, show item counts in the tab badges, and make sure the active tab survives page refreshes and browser back/forward buttons."

---

## Xengin 10-Step Execution

### 1. Classification & Risk Assessment
- **Scope**: Frontend (`React` / `TypeScript`).
- **Risk Level**: Medium (URL-based state, shared components, client-side filtering).

### 2. Pre-flight Discovery
- Inspect existing directory structure: `frontend/src/features/projects/` and `frontend/src/shared/components/`.
- Discover existing router: `react-router-dom` with `useSearchParams`.
- Discover existing components: `Tabs.tsx`, `Badge.tsx`.

### 3. Implementation Patterns

#### Invariant A: URL State as Single Source of Truth
Instead of duplicating tab state in `useState`, read directly from and write directly to `useSearchParams`:

```tsx
import { useSearchParams } from 'react-router-dom';

export function useProjectTab() {
  const [searchParams, setSearchParams] = useSearchParams();
  const currentTab = searchParams.get('tab') || 'all';

  const setTab = (tab: string) => {
    setSearchParams((prev) => {
      const next = new URLSearchParams(prev);
      if (tab === 'all') {
        next.delete('tab');
      } else {
        next.set('tab', tab);
      }
      return next;
    });
  };

  return { currentTab, setTab };
}
```

#### Invariant B: Derived State (Compute Inline, Zero `useEffect`)
Never maintain `const [filteredProjects, setFilteredProjects] = useState(...)` synchronized via a `useEffect`:

```tsx
// Derived inline during render — guaranteed sync without race conditions or extra renders
const filteredProjects = useMemo(() => {
  if (currentTab === 'active') return projects.filter(p => p.status === 'ACTIVE');
  if (currentTab === 'archived') return projects.filter(p => p.status === 'ARCHIVED');
  return projects;
}, [projects, currentTab]);

const counts = useMemo(() => ({
  all: projects.length,
  active: projects.filter(p => p.status === 'ACTIVE').length,
  archived: projects.filter(p => p.status === 'ARCHIVED').length,
}), [projects]);
```

### 4. Final Enforcement Gate Self-Audit
- [x] **Type Safety**: Zero `any` or `@ts-ignore`.
- [x] **Reactivity**: Uses `useSearchParams` rather than mutable global `window.location`.
- [x] **Effects**: Zero `useEffect` used for state derivation.
- [x] **Accessibility**: Tabs provide proper `aria-selected` and keyboard navigation.

### 5. Verification
- `npm run build` / `tsc --noEmit`: Exited 0 with no type errors.
- Unit test verifies tab query string manipulation and state persistence across renders.
