# Xengin (X Engineering Intelligence)

> **Disciplined Software Engineering Workflows for Antigravity & Gemini CLI**

Xengin transforms natural product requirements into resilient, verified software implementations. It operates as an autonomous engineering layer that shields developers and users from technical micromanagement while upholding uncompromising standards in security, architectural integrity, and data safety.

---

## The Philosophy

```text
The user defines WHAT they want (product & business intent).
Xengin owns HOW to engineer it safely (architecture, contracts, data integrity, security, verification).
```

You do not need to prompt about transactions, IDOR, `useEffect`, state taxonomy, or mutex locks. Xengin automatically infers and enforces these technical boundaries based on the codebase context and risk level.

---

## Architecture & Packaging

Xengin is engineered as a **Native Antigravity Plugin** with full compatibility for Gemini CLI Extension environments:

- **Rules (`rules/`)**: Permanent, always-on core engineering invariants (`00-xengin-core.md`, `01-xengin-workflow.md`, `AGENTS.md`) loaded into the agent's baseline context.
- **Skills (`skills/`)**: On-demand specialized engineering domain knowledge:
  - `xengin-task`: Everyday feature implementation workflow (`/xengin-task`).
  - `xengin-plan`: Read-only blast-radius and architectural planning (`/xengin-plan`).
  - `xengin-review`: 5-dimension code and diff audit (`/xengin-review`).
  - `xengin-frontend-engineering`: Frontend React/TypeScript rulebook.
  - `xengin-backend-engineering`: Backend API, DB, and concurrency rulebook.
  - `xengin-workflow`: Universal Final Enforcement Gate v2, 3-tier risk model, and conditional Graphify policy.

---

## Installation & Setup

### 1. Antigravity Native Installation (Primary)

To import and enable Xengin in Antigravity:

```powershell
# Import directly from the repository
agy plugin import G:\AntiGravity\xengin-antigravity

# Validate the plugin
agy plugin validate C:\Users\amir\.gemini\config\plugins\xengin

# List active plugins
agy plugin list
```

### 2. Gemini CLI Compatibility (Alternative)

To link for Gemini CLI development:

```bash
gemini extensions link G:\AntiGravity\xengin
gemini extensions list
```

---

## Usage

### 1. Normal Natural Language (Default Mode)
Xengin's permanent rules automatically guide the agent even without slash commands:
```text
In the customer portal, allow users to cancel unpaid orders. 
Once an order has entered shipping, it cannot be canceled. 
Notify administrators upon successful cancellation.
```

### 2. Explicit Development Workflow (`/xengin-task`)
```text
/xengin-task Implement bulk export for inventory warehouse movements to CSV.
```

### 3. High Blast-Radius Planning (`/xengin-plan`)
```text
/xengin-plan Refactor authentication from session cookies to Sanctum bearer tokens.
```

### 4. Code Review & Audit (`/xengin-review`)
```text
/xengin-review Audit the recent changes on the current branch against security and transactional standards.
```

---

## License

Apache-2.0
