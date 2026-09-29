# Xengin

Engineering guardrails for Antigravity coding agents.

Describe what you want.  
Xengin handles how to engineer it safely.

[![GitHub Release](https://img.shields.io/github/v/release/amirhswork1582-hub/xengin?include_prereleases&color=blue&label=release)](https://github.com/amirhswork1582-hub/xengin/releases)
[![License](https://img.shields.io/badge/license-Apache--2.0-green.svg)](LICENSE)
[![Antigravity](https://img.shields.io/badge/Antigravity-Native%20Plugin-purple)](https://antigravity.google)
[![Status](https://img.shields.io/badge/status-Public%20Beta-orange)](#)

---

Xengin is an Antigravity-native engineering harness for developers and vibe coders who want coding agents to make routine technical decisions without turning the codebase into a mess.

It inspects the existing project, activates relevant frontend or backend engineering rules, applies a final enforcement gate, and validates changes proportionally to risk.

---

## Why Xengin?

AI coding agents are fast, but speed alone does not guarantee good engineering.

Without guardrails, agents may:
- **Invent parallel architecture**: Create duplicate utilities, redundant state managers, or conflicting API abstractions instead of reusing existing patterns.
- **Skip validation or authorization**: Leave endpoints vulnerable to IDOR or accept unvalidated request payloads directly into database models (mass assignment).
- **Over-engineer simple tasks**: Introduce heavy layers, generic form engines, or complex abstractions for basic requirements.
- **Misuse state and effects**: Chain reactive `useEffect` triggers to synchronize state instead of deriving values inline or persisting navigable state in URLs.
- **Introduce unnecessary infrastructure**: Reach for Redis, message queues, or microservice patterns for simple, low-volume operations.
- **Declare work complete without meaningful verification**: Claim tasks are finished without running compilers, linters, or risk-appropriate negative-path behavioral tests.

Xengin adds an engineering process around the agent without forcing you to micromanage implementation details.

```text
You describe product intent.
Xengin owns routine engineering decisions.
```

---

## Practical Example: Before & After

### Without Xengin (Prompt Micromanagement)
```text
Create the API, add authorization, prevent IDOR, use a transaction,
validate fields, keep side effects outside the transaction,
write rollback tests...
```

### With Xengin (Product Intent)
```text
Users should be able to cancel their own unpaid orders.
Orders that have already shipped cannot be canceled.
Notify the admin after a successful cancellation.
```

Xengin is responsible for discovering the appropriate engineering implementation from the existing project.

---

## 60-Second Quick Start

### 1. Install Plugin

```bash
# Clone the repository
git clone https://github.com/amirhswork1582-hub/xengin.git
cd xengin

# Option A: Import into your active Antigravity plugins directory
agy plugin import .

# Option B: Clone directly into global plugins directory
git clone https://github.com/amirhswork1582-hub/xengin.git ~/.gemini/config/plugins/xengin
```

### 2. Verify Installation

```bash
# Validate plugin structure
agy plugin validate ~/.gemini/config/plugins/xengin

# List active plugins
agy plugin list
```

### 3. Start Coding

Just talk normally in Antigravity:
> *"I want users to be able to cancel unpaid orders. Once an order ships, it should no longer be cancelable."*

Or invoke dedicated workflows:
- `/xengin-task` — Implement a feature with automated discovery, gate audit, and test execution.
- `/xengin-plan` — Analyze and plan high-risk architectural changes without modifying code.
- `/xengin-review` — Audit a git diff or existing code for security and architecture flaws.

---

## Not Another 100-Skill Pack

Xengin is intentionally not trying to provide hundreds of commands or specialized personas.

Its user experience is deliberately small:
- `/xengin-task`
- `/xengin-plan`
- `/xengin-review`

Everything else happens behind those workflows or through conditional rules.

```text
Three workflows.
Conditional engineering rules.
Risk-aware verification.
```

---

## How It Works

Xengin operates as a disciplined lifecycle behind every task:

```text
Your requirement
      ↓
Inspect existing codebase
      ↓
Frontend / Backend rules
      ↓
Smallest safe implementation
      ↓
Final Enforcement Gate
      ↓
Risk-based validation
      ↓
Evidence-based delivery
```

### Optional Graphify Localization

When analyzing complex codebases with established knowledge graphs:

```text
Complex repository?
      ↓
Graphify available?
      ↓ yes
Use graph for localization
      ↓
Verify against source
```

> [!NOTE]
> **Source code is always the final authority.** All structural relationships discovered via knowledge graphs are verified against actual source files and database migrations.

---

## Three Workflows

Xengin exposes three focused user-facing workflows:

### `/xengin-task`
Use when you explicitly want Xengin to implement a change. It conducts pre-flight discovery, reuses existing models and UI components, enforces the Final Enforcement Gate, and validates changes with executable tests.
```text
/xengin-task Add a wishlist to the product page. Users should be able to remove items later and see a clear message if saving fails.
```

### `/xengin-plan`
Use for large or risky changes when you want analysis and a plan without modifying source code. Evaluates blast radius, dependency impact, and phased migration roadmaps (Expand-Migrate-Contract).
```text
/xengin-plan We want to redesign authentication from session cookies to bearer tokens without breaking active users.
```

### `/xengin-review`
Use to inspect a Git diff or existing changes without modifying source code. Audits against security boundaries, transactional atomicity, state taxonomy, and code hygiene, categorizing issues by severity.
```text
/xengin-review Review the current changes on this branch before I merge them.
```

### Natural Prompts (No Slash Command Required)
You do not need a slash command for normal work. Natural-language prompts are supported. Xengin's core invariants are permanently active in Antigravity, automatically loading relevant frontend or backend rules as needed.

---

## Tested, Not Just Prompted

Xengin has been evaluated using:
- **Isolated legacy-free tests**: Ensuring zero dependence on deprecated global skills.
- **Executable task tests**: Verifying pattern discovery and code reuse in real repositories.
- **Read-only plan tests**: Confirming that planning workflows produce actionable roadmaps without mutating code.
- **Read-only review tests**: Ensuring security flaws (IDOR, mass assignment, secret leaks) are detected and blocked with zero code modifications.
- **Natural frontend prompts**: Verifying URL state persistence and derived state without slash commands.
- **Natural backend prompts**: Verifying IDOR defenses, transactional boundaries, and side-effect isolation from plain conversational prompts.
- **Risk-specific validation scenarios**: Testing domain-tailored verification (e.g. batching and lock mitigation in background jobs) without checklist blindness.
- **Graphify ON/OFF tests**: Proving seamless localization when knowledge graphs exist, and graceful fallback when absent.

The project includes its [validation methodology and empirical test results](docs/benchmarks/public-beta-validation.md) so users can inspect how its behavior was evaluated.

---

## Optional: Graphify

For larger or dependency-heavy repositories, Xengin can use [Graphify](https://github.com/xengin/graphify) output to localize relevant architecture before deeper source inspection.

Graphify is optional. If it is unavailable, Xengin falls back to normal source-code discovery. Graph data is never treated as more authoritative than the source code.

---

## Compatibility

| Environment | Status | Notes |
| :--- | :--- | :--- |
| **Antigravity** | ✅ Native / validated | First-class native plugin (`plugin.json`, `rules/`, `skills/`) |
| **Claude Code** | ✅ Native adapter | Official plugin & marketplace integration (`platforms/claude-code/`) |
| **Gemini CLI** | 🧪 Experimental compatibility layer | Supported via `compat/gemini-cli/` manifest |
| **Codex** | 🗺️ Planned adapter | Core rules portable; adapter planned for future releases |

---

## Feedback & Contributions

Xengin is currently in public beta.

If you use it on a real project:

- ⭐ **Star the repository** if it helps your daily coding workflow
- 🐛 **Open an issue** when agent behavior violates engineering guardrails
- 💡 **Suggest workflows or rule improvements** based on real development patterns
- 🔧 **Submit a PR** for reproducible improvements

Real-world failure cases are especially valuable because Xengin evolves from observed agent behavior, not from adding rules speculatively.

---

## Roadmap

- Gather real-world Antigravity user feedback during Public Beta
- Improve rules and edge cases from reproducible failure cases
- Expand benchmark coverage across more frameworks and languages
- Explore Codex environment adapter
- Explore Claude Code environment adapter

---

## License

Licensed under the [Apache License 2.0](LICENSE).
