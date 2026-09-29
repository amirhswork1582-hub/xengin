## Summary of Changes

A concise description of the problem solved or feature added.

## Motivation & Context

Why is this change required? What issue does it resolve?

## Pre-Flight & Architecture Review

- [ ] Inspected existing codebase before adding new models, abstractions, or libraries.
- [ ] No parallel architectures introduced (reused existing conventions).
- [ ] Backward compatibility maintained for existing public contracts.

## Final Enforcement Gate Self-Audit

- [ ] **Security**: Route authentication verified, tenant/user ownership enforced (zero IDOR), inputs validated via schema.
- [ ] **Data Safety**: Dependent writes wrapped in DB transactions, side effects executed outside transactions, no secrets/passwords leaked.
- [ ] **Frontend**: Navigable state stored in URL query params; derived state computed inline; zero `useEffect` state synchronization chains.
- [ ] **Code Hygiene**: No `any`, `@ts-ignore`, empty catch blocks, or temporary debug logs.

## Verification & Testing

- [ ] Executable build/typecheck run and passed (`npm run build`, `tsc --noEmit`, etc.).
- [ ] Behavioral tests run and passed proportionally to risk.
- [ ] Git diff inspected for cleanliness and minimal safe change.
