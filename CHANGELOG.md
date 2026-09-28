# Changelog

All notable changes to the **Xengin** extension will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2026-09-28

### Added
- Initial release of **Xengin (X Engineering Intelligence)** as a Gemini CLI extension.
- Manifest `gemini-extension.json` with persistent context file `GEMINI.md`.
- Core 10-step lifecycle orchestrator with conflict resolution hierarchy.
- Namespaced agent skills:
  - `xengin-frontend-engineering`: Complete frontend rulebook integration.
  - `xengin-backend-engineering`: Complete backend rulebook integration.
  - `xengin-workflow`: Universal Final Enforcement Gate v2, 3-tier risk model, and smart Graphify policy.
  - `xengin-review`: 5-dimension architectural and security code review rubric.
- Custom slash commands:
  - `/xengin:task`: Primary development workflow entry point.
  - `/xengin:plan`: Read-only architectural and blast-radius planning.
  - `/xengin:review`: Severity-ranked code and diff review.
- Comprehensive documentation:
  - Architecture overview (`docs/architecture.md`).
  - Production operating handbook (`docs/production-workflow-guide.md`).
  - Non-destructive migration guide (`docs/migration-guide.md`).
