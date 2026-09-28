# Xengin (X Engineering Intelligence)

> **Disciplined Software Engineering Workflows for Gemini CLI**

Xengin transforms natural product requirements into resilient, verified software implementations. It operates as an autonomous engineering layer that shields developers and users from technical micromanagement while upholding uncompromising standards in security, architectural integrity, and data safety.

---

## The Philosophy

```text
The user defines WHAT they want (product & business intent).
Xengin owns HOW to engineer it safely (architecture, contracts, data integrity, security, verification).
```

You do not need to prompt about transactions, IDOR, `useEffect`, state taxonomy, or mutex locks. Xengin automatically infers and enforces these technical boundaries based on the codebase context and risk level.

---

## Features

- **10-Step Disciplined Lifecycle**: Task classification, pre-flight discovery, proportional design, enforcement gate audit, risk-based verification, and evidence-backed reporting.
- **Inspect Never Invent**: Discovers and reuses existing models, middleware, portals, and design tokens instead of creating redundant parallel architectures.
- **Smart Knowledge Graph Integration**: Automatically identifies and leverages Graphify (`graphify-out/`) for medium/high blast-radius tasks when present.
- **Universal Final Enforcement Gate v2**: Generic self-audit catching auth boundary misses, IDOR, response leaks, raw `any`, and concurrency deadlocks.
- **Automated Behavioral Test Mandate**: Automatically writes and runs executable negative-path feature tests for high-risk operations (financial, inventory, authentication).

---

## Directory Structure

```text
xengin/
├── gemini-extension.json      # Extension manifest
├── GEMINI.md                  # Persistent core orchestration context
├── README.md                  # Overview and quickstart
├── CHANGELOG.md               # Version history
├── LICENSE                    # Apache-2.0 License
├── commands/
│   └── xengin/
│       ├── task.toml          # /xengin:task - primary feature implementation
│       ├── plan.toml          # /xengin:plan - read-only architectural planning
│       └── review.toml        # /xengin:review - 5-dimension code audit
├── skills/
│   ├── xengin-frontend-engineering/
│   │   ├── SKILL.md
│   │   └── references/frontend-agent-rules/
│   ├── xengin-backend-engineering/
│   │   ├── SKILL.md
│   │   └── references/backend-agent-rules/
│   ├── xengin-workflow/
│   │   ├── SKILL.md
│   │   └── references/
│   │       ├── final-enforcement-gate.md
│   │       ├── risk-model.md
│   │       └── graphify-policy.md
│   └── xengin-review/
│       └── SKILL.md
└── docs/
    ├── architecture.md
    ├── production-workflow-guide.md
    └── migration-guide.md
```

---

## Installation & Development Setup

### 1. Validate Extension
```bash
gemini extensions validate /path/to/xengin
```

### 2. Link for Local Development
```bash
gemini extensions link /path/to/xengin
```

### 3. Verify Registration
```bash
gemini extensions list
gemini skills list
```

---

## Usage

### 1. Normal Natural Language (Default Mode)
Simply describe your feature naturally:
```text
In the customer portal, allow users to cancel unpaid orders. 
Once an order has entered shipping, it cannot be canceled. 
Notify administrators upon successful cancellation.
```

### 2. Explicit Workflow (`/xengin:task`)
```text
/xengin:task Implement bulk export for inventory warehouse movements to CSV.
```

### 3. High Blast-Radius Planning (`/xengin:plan`)
```text
/xengin:plan Refactor authentication from session cookies to Sanctum bearer tokens.
```

### 4. Code Review & Audit (`/xengin:review`)
```text
/xengin:review Audit the recent changes on the current branch against security and transactional standards.
```

---

## License

Apache-2.0
