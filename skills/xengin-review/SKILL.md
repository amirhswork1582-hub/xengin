---
name: xengin-review
description: Disciplined code review and architectural audit skill. Inspects git diffs, PRs, and existing codebases against Xengin engineering standards, security gates, data integrity principles, and testing gaps without modifying files unless explicitly requested.
---

# Xengin Code Review & Architectural Audit

This skill provides an objective, senior-level code review process designed to evaluate changes before they merge into production.

## Review Rubric

When auditing code, evaluate across these 5 core dimensions:

1. **Security & Boundary Protection**:
   - Are new routes and actions properly authenticated and authorized?
   - Is there any risk of IDOR / BOLA? Are tenant and user scopes enforced?
   - Is input validated at the boundaries? Is mass assignment prevented?
   - Does any response leak internal tokens, hashes, or sensitive fields?

2. **Data Integrity & Concurrency**:
   - Are multi-step mutations executed inside database transactions?
   - Does the code mitigate concurrency deadlocks or race conditions?
   - Are external side effects (SMS, email, webhooks) placed outside DB transactions?
   - Are schema migrations backward-compatible (Expand-Migrate-Contract)?

3. **Architecture & Project Conventions**:
   - Does the implementation reuse existing models, middleware, and UI components (`Inspect Never Invent`)?
   - Did it create parallel or redundant architectures?
   - In frontend: Is state ownership correct (URL vs local)? Are there unnecessary `useEffect` hooks or nested component declarations?

4. **Code Hygiene & Type Safety**:
   - Are there introduced `any` types, `@ts-ignore` comments, or suppressed warnings?
   - Are temporary debugging statements (`console.log`, `dd()`) present?
   - Are error handling blocks swallowing exceptions silently?

5. **Verification & Test Coverage**:
   - Are high-risk behaviors covered by automated tests?
   - Do tests cover negative paths (unauthenticated, forbidden, constraint violation rollback)?

## Findings Classification

Always report review findings categorized by severity:
- **[CRITICAL]**: Security vulnerabilities (IDOR, auth bypass, data leaks), data corruption risks, or broken core invariants.
- **[HIGH]**: Missing transactions on multi-step writes, race conditions, breaking contract changes, or unhandled runtime exceptions.
- **[MEDIUM]**: Architectural divergence, unnecessary `useEffect` state syncing, missing input validation, or untested edge cases.
- **[LOW / ADVISORY]**: Code cleanliness, minor naming inconsistencies, or optimization suggestions.

*Do NOT automatically modify code during a review unless the user explicitly requests automatic remediation.*
