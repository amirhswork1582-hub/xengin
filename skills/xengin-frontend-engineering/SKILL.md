---
name: xengin-frontend-engineering
description: Production frontend engineering skill for React, TypeScript, Vue, Next.js, and modern web UIs. Enforces disciplined component architecture, single source of truth, URL vs local state ownership, derived state calculation, useEffect gate, UI accessibility, and backward-compatible shared component modifications.
---

# Xengin Frontend Engineering

This skill provides comprehensive engineering guidelines for frontend applications.

## Purpose & Scope
Apply this skill whenever designing, modifying, refactoring, or reviewing web user interfaces, client state, components, or API integrations.

## Rulebook References Map

Consult the authoritative reference documents located in `references/frontend-agent-rules/`:

1. **`00-core-rules.md`**: Core frontend directives, hard completion gates, and vibe-coding decision guidelines.
2. **`01-workflow-scope-and-refactoring.md`**: Pre-flight repository discovery, smart Knowledge Graph inspection, blast radius estimation, and refactoring boundary rules.
3. **`02-components-and-architecture.md`**: Component hierarchy, responsibility separation, avoiding over-fragmentation, and avoiding component declarations inside render functions.
4. **`03-state-data-and-effects.md`**: State ownership taxonomy (URL, server cache, local UI, form), strict rules on `useEffect` (eliminate sync effects in favor of derived state or event handlers), and race condition prevention.
5. **`04-ui-quality-and-accessibility.md`**: Async UI states (Loading, Empty, Error, Success), semantic HTML, accessibility standards, and focus management.
6. **`05-dependencies-validation-and-delivery.md`**: Dependency hygiene, executable build validation (`npm run build`, lint), and diff review before delivery.

## Key Directives
- **Single Source of Truth**: State that should survive page refresh, browser back/forward, or link sharing MUST live in URL query params. Local UI toggles stay local.
- **Compute, Don't Sync**: Compute derived values with pure functions or `useMemo`. Never duplicate state in `useState` or synchronize state across effects.
- **Inspect Never Invent**: Reuse existing UI primitives, modals, buttons, and design tokens rather than inventing new variants or installing ad-hoc packages.
