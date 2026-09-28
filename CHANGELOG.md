# Changelog

All notable changes to the **Xengin** project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2026-09-28

### Added
- **Native Antigravity Plugin Packaging**: Full native plugin support via `plugin.json` and directory structure.
- **Native Plugin Rules**: Moved core invariants and 10-step lifecycle to permanently active native rules (`rules/00-xengin-core.md`, `rules/01-xengin-workflow.md`, and consolidated `rules/AGENTS.md`).
- **Slash Commands to Native Skills**: Converted custom TOML commands into native Antigravity skills:
  - `xengin-task`: Everyday feature implementation workflow.
  - `xengin-plan`: Read-only blast-radius and architectural planning.
  - `xengin-review`: 5-dimension code and diff audit with severity ranking.
- **Dual Compatibility**: Retained full compatibility with both Native Antigravity Plugin runtime and Gemini CLI Extension environments.

## [0.1.0] - 2026-09-28

### Added
- Initial release of **Xengin (X Engineering Intelligence)** as a Gemini CLI extension.
- Manifest `gemini-extension.json` with persistent context file `GEMINI.md`.
- Namespaced agent skills (`xengin-frontend-engineering`, `xengin-backend-engineering`, `xengin-workflow`, `xengin-review`).
- Universal Final Enforcement Gate v2, 3-tier risk model, and conditional Graphify policy.
