# Xengin — Gemini CLI Compatibility Layer (Experimental)

This directory contains configuration files for running Xengin as an extension within the Google Gemini CLI.

> [!NOTE]
> **Primary Runtime:** Xengin is primarily designed and validated as a **Native Antigravity Plugin** (`plugin.json`, `rules/`, `skills/`).
> Support for Gemini CLI is maintained as an experimental compatibility layer.

---

## Structure

- `gemini-extension.json`: Extension manifest for Gemini CLI.
- `GEMINI.md`: Context file injected into Gemini CLI sessions.
- `commands/xengin/*.toml`: Custom slash commands (`/xengin:task`, `/xengin:plan`, `/xengin:review`) for Gemini CLI.

---

## Installation in Gemini CLI

To link or install this compatibility layer in Gemini CLI:

```bash
# Link the extension directory
gemini extension link ./compat/gemini-cli
```

Or copy the manifest and commands to your local Gemini CLI extensions directory (`~/.gemini/extensions/xengin`).
