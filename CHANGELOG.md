# Changelog

All notable changes to the **Xengin** project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.3.0-beta.1] - 2026-09-29

### Changed
- **Streamlined 3-Workflow UX**: User-facing slash menu restricted to exactly three core workflows: `/xengin-task`, `/xengin-plan`, and `/xengin-review`.
- **Modular Rule Architecture**: Demoted heavy domain skills (`xengin-frontend-engineering`, `xengin-backend-engineering`, `xengin-workflow`) to modular, conditional rules (`rules/frontend.md` and `rules/backend.md` with `trigger: model_decision`) and shared includes under `rules/includes/`.
- **Generalized Domain Rules & Risk Model**:
  - De-Owlino-ized verification requirements: negative-path tests are now domain-tailored (auth boundaries for security, atomic rollback for transactions, race conditions for concurrency) rather than a rigid uniform checklist.
  - Clarified public vs protected endpoint security requirements.
  - Codified comprehensive state taxonomy (navigable/URL, private/storage, transient/local, derived/inline).
  - Conditional Expand-Migrate-Contract database migrations.
  - Durable delivery requirements for business-critical side effects.
- **Isolated Gemini CLI Layer**: Relocated legacy `commands/` and `gemini-extension.json` to `compat/gemini-cli/` to keep the native Antigravity plugin root clean.
- **Plugin Manifest Upgrade**: Upgraded `plugin.json` to version `0.3.0-beta.1` with official schema `$schema: https://antigravity.google/schemas/v1/plugin.json`.
- **Open Source Sanitization**: Stripped all local machine paths (`C:\Users\...`, `G:\...`) across repository files and added full Apache-2.0 `LICENSE`, `CONTRIBUTING.md`, `SECURITY.md`, `.gitignore`, and GitHub issue templates.
- **Read-Only Invariant for /xengin-plan**: Explicitly specified `RequestFeedback: false` in planning artifacts to guarantee clean read-only termination without triggering auto-execution hooks.
- **Examples & Benchmarks**: Added real-world implementation examples and anonymized benchmarking methodology and empirical results.

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
