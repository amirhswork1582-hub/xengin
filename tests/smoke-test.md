# Xengin Native Plugin Smoke Tests

This test suite verifies the integrity, discovery, and execution capabilities of the **Xengin** Native Antigravity Plugin (v0.3.0-beta.1).

---

## Test Scenarios

### Test 1: Plugin Validation
- **Command**: `agy plugin validate .`
- **Expected Result**: 
  - Exit code 0 (`[ok]`).
  - `skills`: 3 processed (`xengin-task`, `xengin-plan`, `xengin-review`).
  - `commands`: skipped (not found).
  - `agents`: skipped (not found).
  - `mcpServers`: skipped (not found).
  - `hooks`: skipped (not found).

### Test 2: Active Plugin Listing
- **Command**: `agy plugin list`
- **Expected Result**: Plugin `xengin` is listed with source and enabled status.

### Test 3: Native Skills Registration
- **Verification**: In slash command menu, exactly three Xengin skills appear:
  - `/xengin-task`
  - `/xengin-plan`
  - `/xengin-review`

### Test 4: Modular Rules Injection
- **Verification**:
  - Always-on rule: `rules/AGENTS.md` (core principles, 10-step lifecycle, Final Enforcement Gate v2).
  - Conditional modular rules: `rules/frontend.md` and `rules/backend.md` triggered via `model_decision`.

### Test 5: End-to-End Execution
- **Verification**:
  - Execute `/xengin-plan` on a sample feature and verify read-only behavior.
  - Execute a natural prompt and verify pre-flight inspection and gate compliance.
