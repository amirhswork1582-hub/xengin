# 04 — Security, Authentication & Validation

Use this module for trust boundaries, authentication, authorization, tenant isolation, input validation, secrets, file handling, and common backend vulnerabilities.

---

## Security Is Part of Correctness

A feature that "works" but permits unauthorized access, injection, data leakage, or abuse is not correct.

Security review depth MUST be proportional to exposure and risk.

---

## Trust Boundaries

Treat as untrusted unless proven otherwise:

```text
request body
query parameters
path parameters
headers
cookies
uploaded files
webhook payloads
queue messages from external producers
third-party API data
user-controlled URLs
serialized client data
```

Frontend validation does not replace backend validation.

---

## Authentication vs Authorization

Keep these separate:

```text
Authentication = Who are you?
Authorization  = Are you allowed to do this?
```

A valid session/token does not imply permission to access every object or action.

---

## Object-Level Authorization / IDOR / BOLA

For resource access such as:

```text
GET /orders/:id
PATCH /users/:id
DELETE /documents/:id
```

MUST verify the caller's permission for that specific resource when required.

Do not rely on resource IDs being difficult to guess.

Typical checks may include:

```text
ownership
role
organization/tenant membership
explicit permission
resource state
```

---

## Tenant Isolation

In multi-tenant systems, tenant isolation is a security and data-integrity invariant.

Queries and mutations MUST NOT accidentally cross tenant boundaries.

Do not rely solely on UI-provided tenant IDs.

Prefer trusted tenant context derived from authenticated server-side identity when the architecture supports it.

Review shared caches, background jobs, and search indexes for tenant-key isolation too.

---

## Input Validation

Validate input at the backend boundary using project conventions.

Consider:

```text
type
format
length
range
allowed values
nested object shape
unexpected fields
file size/type
identifier format
```

Reject or safely handle unexpected input according to API conventions.

---

## Mass Assignment

Do not blindly spread user-controlled objects into persistence operations.

Bad concept:

```text
updateUser(req.body)
```

when `req.body` could contain fields such as:

```text
role
isAdmin
tenantId
accountBalance
verifiedAt
```

Use explicit allowlisted writable fields or validated schemas.

---

## SQL / NoSQL Injection

Use parameterized queries, ORM-safe APIs, and validated query construction.

MUST NOT concatenate untrusted input into SQL, database commands, or query expressions.

Dynamic identifiers/order clauses require explicit safe mapping when parameterization cannot cover them.

---

## Command Injection

MUST NOT interpolate untrusted input into shell commands.

Prefer safe library APIs and argument-array execution.

If command execution is unavoidable, use strict allowlists and project-approved safe mechanisms.

---

## SSRF

When the server fetches user-controlled URLs, consider SSRF risk.

Potential protections include:

```text
allowlisted hosts
allowed schemes
DNS/IP validation
blocking private/internal networks
redirect handling
timeout
response size limits
```

Do not implement generic "fetch any URL" functionality without evaluating SSRF.

---

## Path Traversal

For user-influenced file paths:

```text
normalize paths
restrict to intended base directory
reject traversal
avoid direct path concatenation
```

Do not trust filenames.

---

## File Upload Safety

When accepting files, consider:

```text
size limits
content-type distrust
magic-byte/content inspection when appropriate
storage outside executable paths
randomized server-side names
extension handling
malware scanning when risk justifies it
image/document processing vulnerabilities
download Content-Disposition
```

Do not make uploaded files executable by default.

---

## Passwords

MUST NOT store plaintext passwords.

Use the project's established modern password hashing mechanism.

Do not invent custom cryptography.

Password comparison SHOULD use the library's safe verification function.

---

## Tokens & Sessions

For auth tokens/sessions, inspect existing conventions before changes.

Consider when relevant:

```text
expiration
rotation
revocation
cookie flags
CSRF interaction
refresh-token handling
session fixation
replay risk
storage
```

Do not log bearer tokens, session secrets, or reset tokens.

---

## CSRF

CSRF defenses are especially relevant for cookie-authenticated state-changing requests.

Use project/framework protections where applicable.

Do not add CSRF machinery blindly to architectures that do not use ambient cookie credentials.

---

## CORS

CORS is a browser access policy, not authentication.

Do not use `Access-Control-Allow-Origin: *` casually for authenticated/sensitive APIs.

Follow explicit allowed-origin requirements and framework conventions.

---

## Secrets

MUST NOT hard-code:

```text
API keys
database credentials
JWT signing secrets
private keys
webhook secrets
cloud credentials
```

Inspect existing secret/config conventions.

Do not expose server-only secrets to client-visible environment variables.

Do not log secrets.

---

## Sensitive Data

Minimize exposure of sensitive information.

Consider:

```text
PII
financial data
tokens
password/reset data
private internal metadata
security answers
```

Do not log entire request/response payloads blindly on sensitive endpoints.

---

## Brute Force & Abuse

High-risk endpoints SHOULD consider abuse controls when applicable:

```text
login
OTP
password reset
signup
coupon/reward redemption
expensive public search
resource creation
```

Potential controls:

```text
rate limiting
progressive delay
temporary lockout
CAPTCHA where product-appropriate
monitoring
```

Avoid controls that create easy denial-of-service against legitimate users.

---

## Replay & Idempotency

For replay-sensitive operations, consider:

```text
idempotency keys
nonce/timestamp
signature verification
deduplication records
state transition checks
```

Particularly relevant to:

```text
payments
webhooks
external callbacks
job processing
resource creation
```

---

## Webhook Security

When receiving webhooks:

```text
verify signature/authenticity
validate timestamp/replay window when protocol supports it
parse safely
acknowledge according to provider semantics
make processing idempotent when retries occur
```

Do not trust source IP alone unless the provider explicitly documents and maintains that mechanism.

---

## Error Information Leakage

Public errors MUST NOT leak:

```text
stack traces
SQL text
filesystem paths
internal hostnames
secrets
implementation details useful to attackers
```

Keep operational detail in protected logs/observability.

---

## Dependency Security

Before adding or upgrading security-sensitive dependencies:

```text
verify package identity
verify installed/version compatibility
prefer maintained packages
avoid unnecessary dependencies
```

Do not "fix" a vulnerability by blindly applying a major upgrade without compatibility analysis.
