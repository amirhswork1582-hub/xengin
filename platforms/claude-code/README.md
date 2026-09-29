# Xengin — Claude Code Native Adapter

> **Engineering guardrails for AI coding agents — safer vibe coding with architecture-aware workflows, risk-based validation, and code review.**

This adapter provides native packaging and agent skills for **Anthropic Claude Code**, bringing Xengin's proven engineering invariants, risk-based verification model, and three-workflow user experience directly to Claude Code environments.

---

## Key Features

- **Progressive Disclosure Skills**: Exposes three primary workflows (`/xengin-task`, `/xengin-plan`, `/xengin-review`) while loading detailed domain chapters conditionally from internal references.
- **Natural Conversational Prompting**: Claude Code automatically matches feature requests, bug reports, and refactor prompts to the appropriate Xengin engineering workflow without requiring explicit slash commands.
- **Plan Mode Integration**: Cooperates natively with Claude Code's Plan Mode (`/plan`), providing structured blast-radius analysis, Expand-Migrate-Contract roadmaps, and verification matrices without modifying code.
- **Universal Final Enforcement Gate**: Enforces pre-completion checks (IDOR protection, mass assignment prevention, transactional atomicity, response sanitization).
- **Single Source of Truth**: Rules are maintained centrally in canonical markdown format and synchronized deterministically to prevent rulebook drift.

---

## Installation

### Method 1: Claude Code Marketplace (Recommended)

Add the Xengin repository as a marketplace source and install the plugin:

```bash
# 1. Add the marketplace
claude plugin marketplace add amirhswork1582-hub/xengin

# 2. Install the Xengin plugin
claude plugin install xengin@xengin

# 3. Verify installation
claude plugin list
```

### Method 2: Local Repository or Skills Directory

If developing locally or linking from a cloned repository:

```bash
# Clone the repository
git clone https://github.com/amirhswork1582-hub/xengin.git
cd xengin

# Validate the plugin manifest
claude plugin validate ./platforms/claude-code --strict

# Scaffold into your user skills directory if desired:
# claude plugin init xengin --with skills
```

---

## The Three Workflows

### 1. `/xengin-task` (Implementation)
Executes a software feature, bug fix, or refactor through the 10-step lifecycle:
```text
/xengin-task Implement bulk export for warehouse movements to CSV with date filtering.
```

### 2. `/xengin-plan` (Architectural Planning)
Analyzes dependencies, blast radius, and migration strategies without modifying application source code. Synergizes with Claude Code Plan Mode:
```text
/xengin-plan Refactor session-based authentication to JWT bearer tokens without disrupting active users.
```

### 3. `/xengin-review` (Audit & Inspection)
Audits active changes or a Git diff across security boundaries, data integrity, component architecture, and test coverage:
```text
/xengin-review Audit the current branch diff before merge.
```

### Natural Conversational Prompts
Slash commands are optional. You can simply describe product intent in plain language:
> *"Users should be able to cancel unpaid orders, but not after shipping. Notify the admin after cancellation."*

Xengin automatically applies ownership verification, transaction boundaries, and side-effect isolation without requiring technical prompt micromanagement.

---

## Project-Level Integration (`CLAUDE.md`)

Xengin does not require modifying or replacing your project's existing `CLAUDE.md`. If you wish to reinforce Xengin's role as the project's default engineering harness, merge the optional snippet from [`integration/CLAUDE.md.example`](integration/CLAUDE.md.example) into your project root.

---

## Architecture & Zero Drift Strategy

```text
xengin/
├── rules/                       # CANONICAL SOURCE OF TRUTH (Always edit here)
│   ├── AGENTS.md
│   ├── frontend.md
│   ├── backend.md
│   └── includes/
│       ├── core.md
│       ├── workflow.md
│       ├── final-enforcement-gate.md
│       ├── risk-model.md
│       └── graphify-policy.md
├── scripts/
│   └── sync-claude-adapter.ps1 # Deterministic synchronization script
└── platforms/
    └── claude-code/             # ADAPTER DIRECTORY (Generated / synchronized)
        ├── .claude-plugin/
        │   └── plugin.json     # Claude Code plugin manifest
        └── skills/
            ├── xengin-task/
            ├── xengin-plan/
            └── xengin-review/
```

To update Claude Code references after modifying canonical rules:
```powershell
pwsh ./scripts/sync-claude-adapter.ps1
```

---

## License

Licensed under the [Apache License 2.0](../../LICENSE).
