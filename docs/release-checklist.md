# Xengin Public Beta Release Checklist

This document details the checklist and configuration required to publish Xengin as an open-source Public Beta on GitHub.

---

## 1. Pre-Release Repository Verification

- [ ] **Zero Machine-Specific Paths**: Ensure no references to local usernames, paths (e.g. `C:\Users\...`, `G:\...`) exist across any `.md`, `.json`, or code files.
- [ ] **Full License Included**: Verify Apache 2.0 full text is present in `LICENSE`.
- [ ] **Manifest Validated**: Verify `plugin.json` validates with `agy plugin validate .` reporting:
  - `skills`: exactly 3 processed (`xengin-task`, `xengin-plan`, `xengin-review`)
  - `commands`: skipped (not found)
- [ ] **Clean Git History**: Sensitive tokens, scratch notes, and temporary logs omitted from git staging.

---

## 2. Recommended GitHub Repository Settings

### Repository Metadata
- **Repository Name**: `xengin`
- **Short Description**: `Engineering intelligence, architectural guardrails, and risk-proportional verification for Antigravity AI pair programming.`
- **Website**: `https://antigravity.google` (or project documentation site)
- **License**: Apache-2.0

### GitHub Topics (Tags)
```text
antigravity
ai-agent
pair-programming
code-generation
vibe-coding
software-engineering
engineering-standards
developer-tools
plugin
```

---

## 3. Release Tagging & Packaging

- **Release Tag**: `v0.3.0-beta.1`
- **Release Title**: `Xengin v0.3.0-beta.1 (Public Beta)`
- **Release Description**:
  ```markdown
  ### Highlights
  - Native Antigravity Plugin architecture with streamlined 3-workflow UX (`/xengin-task`, `/xengin-plan`, `/xengin-review`).
  - Modular domain rules for Frontend and Backend activated on demand.
  - Final Enforcement Gate v2 for rigorous self-auditing of security, state, and concurrency boundaries.
  - Risk-proportional verification scaling from builds to mandatory automated negative-path feature tests.
  - Experimental Gemini CLI compatibility layer under `compat/gemini-cli/`.
  ```

---

## 4. Installation Instructions for Users

Users can install Xengin directly via the Antigravity CLI:

```bash
# Clone the repository
git clone https://github.com/xengin/xengin.git ~/.gemini/config/plugins/xengin

# Or import into Antigravity
agy plugin import /path/to/xengin
```
