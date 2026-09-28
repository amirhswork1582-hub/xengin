# Xengin System Architecture

Xengin (X Engineering Intelligence) is an autonomous software engineering layer packaged as a **Native Antigravity Plugin**. It establishes an architectural separation of concerns between product intent and technical execution.

---

## 1. High-Level System Architecture

```mermaid
flowchart TD
    User["User Product Intent / Slash Command"] --> Core["Xengin Core Rules (rules/AGENTS.md)"]
    
    subgraph CoreEngine["Core Orchestration Engine"]
        Core --> Classify["Task & Risk Classification (risk-model.md)"]
        Classify --> PreFlight["Pre-flight Discovery (Inspect Never Invent)"]
        PreFlight --> GraphPolicy{"Graphify Available & Blast Radius High?"}
        GraphPolicy -->|Yes| ReadGraph["Inspect graphify-out/GRAPH_REPORT.md"]
        GraphPolicy -->|No| SourceScan["Direct Source & Schema Inspection"]
    end

    subgraph ModularRules["Modular Domain Rules (Progressive Disclosure)"]
        ReadGraph --> RulesRouter{"Detect Task Domain"}
        SourceScan --> RulesRouter
        RulesRouter --> FERules["rules/frontend.md (model_decision)"]
        RulesRouter --> BERules["rules/backend.md (model_decision)"]
    end

    subgraph SkillsWorkflow["User Workflow Skills"]
        User -->|/xengin-task| TaskSkill["skills/xengin-task"]
        User -->|/xengin-plan| PlanSkill["skills/xengin-plan (Read-Only)"]
        User -->|/xengin-review| RevSkill["skills/xengin-review (Audit)"]
    end

    subgraph Enforcement["Quality & Safety Verification"]
        FERules --> Gate["Final Enforcement Gate v2"]
        BERules --> Gate
        TaskSkill --> Gate
        Gate --> RiskVerif["Risk-Based Verification Protocol"]
        RiskVerif --> LowCheck["Low Risk: Build / Lint / Typecheck"]
        RiskVerif --> MedCheck["Med Risk: Build + Targeted Unit/Integration Tests"]
        RiskVerif --> HighCheck["High Risk: Mandatory Behavioral Negative Tests"]
    end

    subgraph Delivery["Evidence-Based Output"]
        LowCheck --> Report["Structured Report: Changed, Validated, Gate, Notes"]
        MedCheck --> Report
        HighCheck --> Report
    end
```

---

## 2. Directory Layout & Roles

- `plugin.json`: The Antigravity plugin manifest, declaring plugin identity, version (`0.3.0-beta.1`), and schema.
- `rules/`:
  - `AGENTS.md`: Consolidated always-on rules (core engineering principles, 10-step lifecycle, Final Enforcement Gate v2).
  - `frontend.md`: Modular frontend rulebook triggered via `model_decision`.
  - `backend.md`: Modular backend rulebook triggered via `model_decision`.
  - `includes/`: Modular reference chapters for frontend, backend, risk model, gate checklist, and knowledge graph policy.
- `skills/`: Exactly three user-facing workflow skills:
  - `xengin-task/`: Primary feature implementation skill (`/xengin-task`).
  - `xengin-plan/`: Read-only architectural and blast-radius planning skill (`/xengin-plan`).
  - `xengin-review/`: 5-dimension code review and diff audit skill (`/xengin-review`).
- `compat/gemini-cli/`: Experimental compatibility layer providing `gemini-extension.json`, `GEMINI.md`, and custom TOML commands for Google Gemini CLI users.
- `examples/`: Reference implementations for frontend features, backend APIs, and architectural plans.
- `docs/`: Technical specifications, migration instructions, benchmarks, and release checklists.
