# Contributing to Xengin

Thank you for your interest in contributing to Xengin! We welcome contributions that improve software engineering rigor, testing discipline, and architecture invariants for AI-driven development.

---

## Code of Conduct

We are committed to providing a welcoming, constructive, and inclusive environment. Please treat all contributors with respect.

---

## Architectural Principles

Before submitting a pull request, ensure your contribution respects Xengin's core engineering principles:

1. **Source Code is Ground Truth**: Avoid hardcoded assumptions about specific frameworks or stacks. Inspect before inventing.
2. **Minimal Safe Diff**: Avoid speculative abstractions, unnecessary microservices, or complex external dependencies unless strictly necessary.
3. **No Parallel Architectures**: Do not introduce duplicate state managers or redundant architectural layers.
4. **Honest Verification**: Verify all changes with concrete tests and commands. Never claim verification passed without executable evidence.

---

## Development & Testing Workflow

### 1. Fork & Clone
```bash
git clone https://github.com/<your-username>/xengin.git
cd xengin
```

### 2. Validate Antigravity Plugin
Ensure you have the Antigravity CLI (`agy`) installed:
```bash
agy plugin validate .
```
The output should confirm:
- `skills`: 3 processed (`xengin-task`, `xengin-plan`, `xengin-review`)
- `commands`: skipped (not found)
- `agents`: skipped (not found)

### 3. Modifying Rules & Skills
- User-facing workflows must be limited to the three core skills: `xengin-task`, `xengin-plan`, `xengin-review`.
- Domain rules reside in `rules/` (`frontend.md`, `backend.md`) and must use `trigger: model_decision`.
- Core principles and the 10-step lifecycle are consolidated in `rules/AGENTS.md` and `rules/includes/`.
- Never commit machine-specific paths (e.g. `C:\Users\...` or absolute local directories).

### 4. Submitting a Pull Request
1. Create a feature branch: `git checkout -b feature/my-improvement`.
2. Commit with conventional commit messages (e.g., `feat:`, `fix:`, `docs:`, `refactor:`).
3. Ensure `agy plugin validate .` passes without warnings.
4. Submit your pull request with a clear description of the problem solved and verification evidence.
