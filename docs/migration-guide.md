# Xengin Migration & Operating Guide

This guide describes how to migrate from legacy loose rulebook directories and global skills to the native **Xengin** Antigravity plugin and Gemini CLI extension.

---

## 1. Zero-Risk Migration Principle

> [!CAUTION]
> **DO NOT DELETE LEGACY SKILLS PREMATURELY.**  
> Keep `frontend-agent-rules`, `backend-agent-rules`, and `graphify` in your global skills directory (`~/.gemini/config/skills/`) until Xengin v0.3.0-beta.1 has been verified across multiple real-world coding sessions.

Xengin skills are uniquely namespaced (`xengin-*`) and workflows are consolidated to avoid naming collisions with legacy skills. Both systems can safely coexist during the transition period.

---

## 2. The Migration Journey

```mermaid
flowchart LR
    Legacy["Legacy Loose Skills<br/>(~/.gemini/config/skills/)"] 
      --> GemExt["Xengin Prototype"]
    GemExt 
      --> NatPlugin["Native Antigravity Plugin<br/>(v0.3.0-beta.1)"]
    NatPlugin 
      --> Verification["Validation & Smoke Tests"]
    Verification 
      --> Retirement["Controlled Retirement of Legacy Skills (Future)"]
```

---

## 3. Step-by-Step Native Installation

### Step 1: Import Plugin into Antigravity
Run the official Antigravity CLI import command pointing to your cloned repository:

```bash
agy plugin import <path-to-xengin>
```

Expected output:
```text
  [ok]    xengin
          ✔ skills      : 3 processed
          - agents      : skipped (not found)
          - commands    : skipped (not found)
          - mcpServers  : skipped (not found)
          - hooks       : skipped (not found)

Staged to ~/.gemini/config
```

### Step 2: Validate the Staged Plugin
Verify the staged plugin structure:

```bash
agy plugin validate ~/.gemini/config/plugins/xengin
```

Expected output:
```text
  [ok]    ~/.gemini/config/plugins/xengin
          ✔ skills      : 3 processed
```

### Step 3: Verify Plugin is Active
```bash
agy plugin list
```

---

## 4. Controlled Retirement Plan (Only After Real-World Pilot)

Once you have verified that Xengin successfully drives your development across multiple projects:

1. **Create a Full Backup**:
   ```bash
   cp -r ~/.gemini/config/skills ~/.gemini/config/skills_backup
   ```
2. **Archive Legacy Skills**:
   Remove or move `frontend-agent-rules` and `backend-agent-rules` from `~/.gemini/config/skills/`.
3. **Keep Graphify**:
   Keep `graphify` in your skills directory; Xengin will detect and use it when relevant.
