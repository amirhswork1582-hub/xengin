# Xengin Migration & Setup Guide

This guide describes how to migrate from legacy loose rulebook directories and global skills to the packaged **Xengin** Gemini CLI extension without service interruption or data loss.

---

## 1. Zero-Risk Migration Principle

> [!CAUTION]
> **Do NOT delete your existing global skills or loose rulebook files until Xengin has been verified in development.**  
> Keep all existing configurations in place during the transition.

Xengin skills are uniquely namespaced (`xengin-frontend-engineering`, `xengin-backend-engineering`, `xengin-workflow`, `xengin-review`) to avoid naming collisions with any legacy user skills (such as `frontend-agent-rules` or `backend-agent-rules`).

---

## 2. Step-by-Step Installation & Linking

### Step 1: Validate the Extension Structure
Before installing, run the official Gemini CLI validation command from terminal:

```bash
gemini extensions validate G:/AntiGravity/xengin
```
Expected output:
```text
Extension G:\AntiGravity\xengin has been successfully validated.
```

### Step 2: Link for Local Development
Link the extension to your Gemini CLI environment:

```bash
gemini extensions link G:/AntiGravity/xengin
```

When prompted:
1. `Trust this workspace? [Y/n]`: Enter `Y`.
2. `Review agent skills and continue? [Y/n]`: Enter `Y`.

Expected output:
```text
Extension "xengin" linked successfully and enabled.
```

### Step 3: Verify Discovery
Check that the extension, its skills, and its custom commands are recognized:

```bash
# Verify extension is listed and enabled
gemini extensions list

# Verify skills are registered
gemini skills list

# In interactive mode, check commands
/help
# Verify /xengin:task, /xengin:plan, /xengin:review are present
```

---

## 3. Post-Verification: Archiving Legacy Skills (Optional)

Once you have verified that Xengin successfully drives your development sessions:

1. Create a backup archive of your old skills:
   ```bash
   mkdir -p C:/Users/amir/.gemini/config/skills_backup
   cp -r C:/Users/amir/.gemini/config/skills/* C:/Users/amir/.gemini/config/skills_backup/
   ```
2. Disable or archive legacy skills (`frontend-agent-rules`, `backend-agent-rules`) so that all operations cleanly funnel through Xengin.
3. Keep `graphify` in place as it is an independent optional tool.

---

## 4. Unlinking or Updating Xengin

- **Updating**: Since the extension is linked via `gemini extensions link`, any file edits in `G:/AntiGravity/xengin` take effect immediately without running update commands.
- **Uninstalling / Unlinking**:
  ```bash
  gemini extensions uninstall xengin
  ```
