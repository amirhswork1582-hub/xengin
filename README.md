# Xengin

Engineering guardrails for Antigravity coding agents.

Describe what you want.  
Xengin decides how to engineer it safely.

---

Xengin is an Antigravity-native engineering harness designed for developers and vibe coders who want the coding agent to own routine engineering decisions while keeping architecture, security, data integrity, and validation disciplined.

---

## Why Xengin?

AI coding agents are fast, but left on their own they often:

- **Invent parallel architectures**: Create duplicate utility folders, duplicate state managers, or conflicting API layers instead of reusing established project patterns.
- **Skip authorization and validation**: Implement endpoints that lack ownership checks (IDOR vulnerabilities) or accept unvalidated request payloads (mass assignment).
- **Over-engineer simple tasks**: Introduce heavy abstractions, unnecessary repositories, or generic engines for a three-field form.
- **Add unneeded infrastructure**: Reach for Redis, message queues, or microservice patterns for simple low-volume operations.
- **Introduce state synchronization issues**: Chain reactive effects (`useEffect`) to synchronize state rather than deriving values inline or persisting navigable state in URLs.
- **Claim completion without verification**: Announce success without actually running builds, typechecks, or negative-path behavioral tests.

Xengin introduces a structured engineering process around these risks without requiring you to micromanage technical implementation.

---

## How It Works

Xengin operates as a transparent lifecycle behind the scenes:

```text
Natural product requirement
        ↓
Inspect existing architecture
        ↓
Load relevant frontend/backend rules
        ↓
Use Graphify when it adds real value
        ↓
Implement the smallest safe change
        ↓
Final Enforcement Gate
        ↓
Risk-proportional verification
        ↓
Evidence-based delivery
```

1. **Inspect Before Invent**: Discovers existing models, middleware, and components before writing new code.
2. **Conditional Activation**: Injects relevant domain rules (frontend vs. backend) based on the task scope.
3. **Proportional Implementation**: Writes the smallest safe diff that meets product requirements.
4. **Final Enforcement Gate**: Executes a mandatory pre-completion audit across security, state taxonomy, and data safety.
5. **Executable Verification**: Validates changes using actual build tools, compilers, and risk-proportional behavioral tests.

---

## Three Workflows

Xengin exposes three focused user-facing workflows:

### `/xengin-task`
Implement a feature or fix a bug with full pre-flight discovery, implementation, gate audit, and executable validation.
```text
/xengin-task Add a wishlist to the product page. Users should be able to remove items later and see a clear message if saving fails.
```

### `/xengin-plan`
Inspect the repository and formulate a phased, risk-mitigated implementation plan for high-blast-radius changes without modifying source code.
```text
/xengin-plan We want to redesign authentication from session cookies to bearer tokens without breaking active users.
```

### `/xengin-review`
Audit existing changes or an active Git diff against security, data integrity, component architecture, and test coverage standards without modifying source code.
```text
/xengin-review Review the current changes on this branch before I merge them.
```

### Natural Prompts (No Slash Command Required)
Xengin's core invariants are permanently active in Antigravity. Normal conversational prompts automatically trigger the appropriate domain rules and verification standards:

```text
Users should be able to cancel unpaid orders, but not after shipping.
Notify the admin after cancellation.
```

You do not need to manually specify database transactions, IDOR protection, state libraries, or rollback strategies. Xengin handles how to engineer it safely.

---

## What Makes Xengin Different

Xengin is not merely:
- A prompt pack or prompt template collection
- A massive static system prompt that clutters context
- A rigid, uniform checklist that demands HTTP tests for batch scripts

Instead, Xengin combines:
- **Always-on engineering invariants**: Source code as ground truth, zero parallel architectures, honest execution.
- **Modular, conditional domain rules**: Separate frontend and backend rulebooks loaded only when relevant.
- **Risk-based validation model**: Dynamically scales verification depth from build/lint checks up to domain-tailored negative-path behavioral tests.
- **Universal Final Enforcement Gate**: A disciplined self-audit catching regressions, leaked credentials, and input boundaries before completion.
- **Explicit task, plan, and review workflows**: Purpose-built tools for implementation, planning, and read-only auditing.

---

## Graphify: Optional Repository Intelligence

Xengin integrates seamlessly with [Graphify](https://github.com/xengin/graphify) as an optional cognitive accelerator:

- **When Graphify is available (`graphify-out/`)** on medium- or high-blast-radius tasks, Xengin inspects community clusters and boundary nodes to understand dependency relationships before modifying code.
- **When Graphify is unavailable**, Xengin proceeds normally through direct source-code inspection without errors or interruption.

> [!NOTE]
> Source code remains the final authority. All structural relationships discovered via knowledge graphs are verified against actual source files and database migrations.

---

## Benchmarks & Verification

Xengin is continuously evaluated through rigorous empirical benchmarking:

- **Blind scenario prompts**: Testing architectural inference against common coding traps (spaghetti UI, over-engineering, state synchronization, IDOR, and unsafe migrations).
- **Rulebook vs. Enforcement Gate iterations**: Measuring defect capture rates with and without the Final Enforcement Gate self-audit.
- **Controlled Graphify A/B/C testing**: Measuring discovery speed, token efficiency, and pattern reuse across complex codebases.
- **Real-codebase behavioral suites**: Automated feature testing across production Laravel, React, and TypeScript stacks.
- **Isolated Public Beta qualification**: 100% pass rate across 8 empirical validation dimensions in an isolated runtime environment.

See the [benchmark methodology and summarized validation results](docs/benchmarks/public-beta-validation.md) for reproducible evidence.

---

## Compatibility

Xengin v0.3 is built and validated as a **native Antigravity plugin**.

Its rulebooks and workflow architecture are intentionally portable, and adapters for additional coding-agent environments may be added in future releases.

An experimental Gemini CLI compatibility layer is included separately under `compat/gemini-cli/`.

---

## Installation & Setup

### Antigravity Native Installation (Recommended)

To install Xengin into your Antigravity environment:

```bash
# Option A: Import from a local directory into your active plugins
agy plugin import /path/to/xengin

# Option B: Clone directly into your Antigravity plugins directory
git clone https://github.com/amirhswork1582-hub/xengin.git ~/.gemini/config/plugins/xengin

# Validate plugin integrity
agy plugin validate ~/.gemini/config/plugins/xengin

# Verify active status
agy plugin list
```

---

## Repository Structure

```text
xengin/
├── plugin.json                 # Antigravity Plugin manifest
├── rules/
│   ├── AGENTS.md               # Permanent core principles & 10-step lifecycle
│   ├── frontend.md             # Conditional frontend rules
│   ├── backend.md              # Conditional backend rules
│   └── includes/               # Modular chapters (core, workflow, gate, risk, graphify)
├── skills/
│   ├── xengin-task/            # /xengin-task implementation workflow
│   ├── xengin-plan/            # /xengin-plan read-only architectural planning
│   └── xengin-review/          # /xengin-review read-only audit workflow
├── docs/                       # Architecture, migration guides, and empirical benchmarks
├── examples/                   # Reference implementations & plans
└── compat/
    └── gemini-cli/             # Experimental Gemini CLI compatibility layer
```

---

## Contributing

Contributions, issues, and feature requests are welcome. Please read [CONTRIBUTING.md](CONTRIBUTING.md) and [SECURITY.md](SECURITY.md) before submitting pull requests.

---

## License

Licensed under the [Apache License 2.0](LICENSE).
