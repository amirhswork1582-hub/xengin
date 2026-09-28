# Xengin (X Engineering Intelligence)

> **Disciplined Software Engineering Workflows, Risk-Based Verification, and Architectural Guardrails for AI Pair Programming.**

Xengin transforms natural product requirements into resilient, verified software implementations. It operates as an autonomous engineering layer that shields developers and users from technical micromanagement while upholding uncompromising standards in security, architectural integrity, and data safety.

---

## The Core Philosophy

```text
The user defines WHAT they want (product & business intent).
Xengin owns HOW to engineer it safely (architecture, contracts, data integrity, security, verification).
```

You do not need to prompt about transactions, IDOR protection, state taxonomy, or mutex locks. Xengin automatically infers and enforces these technical boundaries based on the codebase context and risk level.

---

## Key Features

- **Streamlined 3-Workflow UX**:
  - `/xengin-task`: Standard feature implementation with automated risk assessment, discovery, implementation, gate audit, and testing.
  - `/xengin-plan`: Read-only blast-radius and phased architectural planning for high-risk changes (zero code modifications).
  - `/xengin-review`: Objective 5-dimension code review and diff audit (Security, Integrity, Architecture, Hygiene, Verification).
- **Modular Domain Rulebooks**:
  - Frontend engineering invariants for React, TypeScript, Vue, and UI state (URL as single source of truth, derived state, zero `useEffect` sync chains).
  - Backend engineering invariants for APIs, database migrations (Expand-Migrate-Contract), transactional atomicity, concurrency, and tenant isolation.
- **Final Enforcement Gate v2**: Mandatory self-inspection audit running before completion to eliminate security holes, leaked secrets, or broken contracts.
- **Risk-Proportional Verification**:
  - *Low Risk*: Syntax, build, and linter validation.
  - *Medium Risk*: Build + targeted unit and integration tests.
  - *High Risk*: Automatic implementation and execution of behavioral negative-path tests (401 unauthenticated, 403 unauthorized/IDOR, atomic rollback on failure).
- **Conditional Knowledge Graph Integration**: Seamlessly leverages `Graphify` when available to trace dependency blast radius on complex tasks.

---

## Directory Architecture

```text
xengin/
├── plugin.json                 # Antigravity Plugin manifest
├── rules/
│   ├── AGENTS.md               # Permanent core engineering principles & workflow
│   ├── frontend.md             # Modular frontend rules (trigger: model_decision)
│   ├── backend.md              # Modular backend rules (trigger: model_decision)
│   └── includes/
│       ├── core.md             # Core engineering invariants
│       ├── workflow.md         # 10-step software engineering lifecycle
│       ├── final-enforcement-gate.md  # Gate v2 self-audit checklist
│       ├── risk-model.md       # 3-tier risk-based verification model
│       ├── graphify-policy.md  # Knowledge graph policy & decision matrix
│       ├── frontend/           # Comprehensive frontend domain chapters
│       └── backend/            # Comprehensive backend domain chapters
├── skills/
│   ├── xengin-task/            # /xengin-task implementation skill
│   ├── xengin-plan/            # /xengin-plan architectural planning skill
│   └── xengin-review/          # /xengin-review code audit skill
├── examples/                   # Reference implementations & plans
├── docs/                       # Architecture, benchmarks, and release guides
└── compat/
    └── gemini-cli/             # Experimental Gemini CLI compatibility layer
```

---

## Installation & Setup

### 1. Antigravity Native Installation (Recommended)

To install or import Xengin as an Antigravity plugin:

```bash
# Option A: Import into your active Antigravity plugins directory
agy plugin import <path-to-xengin>

# Option B: Clone directly into global plugins directory
git clone https://github.com/xengin/xengin.git ~/.gemini/config/plugins/xengin

# Validate the plugin
agy plugin validate ~/.gemini/config/plugins/xengin

# List active plugins
agy plugin list
```

### 2. Gemini CLI Compatibility (Experimental)

To link Xengin in Gemini CLI:

```bash
gemini extension link ./compat/gemini-cli
```

---

## Usage

### Natural Language (Default Mode)
Xengin's permanent rules automatically guide the agent even without slash commands:
```text
In the customer portal, allow users to cancel unpaid orders. 
Once an order has entered shipping, it cannot be canceled. 
Notify administrators upon successful cancellation.
```

### Dedicated Workflows
- **Execute a Task**:
  ```text
  /xengin-task Implement bulk export for warehouse movements to CSV.
  ```
- **Architectural Plan**:
  ```text
  /xengin-plan Refactor authentication from session cookies to bearer tokens.
  ```
- **Code Review**:
  ```text
  /xengin-review Audit recent changes on this branch against security and transactional standards.
  ```

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and development process.

---

## License

Apache-2.0 — see the [LICENSE](LICENSE) file for details.
