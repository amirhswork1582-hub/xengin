# Xengin Extension Smoke Tests

This test suite verifies the integrity, discovery, and execution capabilities of the **Xengin** Gemini CLI extension.

---

## Test Scenarios

### Test 1: Extension Validation
- **Command**: `gemini extensions validate G:/AntiGravity/xengin`
- **Expected Result**: Exit code 0, message stating that the extension has been successfully validated.

### Test 2: Extension Linking & Registration
- **Command**: `gemini extensions link G:/AntiGravity/xengin`
- **Verification**: `gemini extensions list`
- **Expected Result**: Extension `xengin` is listed with version `0.1.0`, state `Enabled`, pointing to `G:\AntiGravity\xengin`, with `GEMINI.md` as context file.

### Test 3: Agent Skills Discovery
- **Command**: `gemini skills list`
- **Expected Result**: The following 4 namespaced skills are discovered and enabled:
  - `xengin-frontend-engineering`
  - `xengin-backend-engineering`
  - `xengin-workflow`
  - `xengin-review`

### Test 4: Custom Slash Commands Registration
- **Expected Commands**:
  - `/xengin:task`
  - `/xengin:plan`
  - `/xengin:review`

### Test 5: End-to-End Execution
- **Verification**: Execute a sample query to verify that Xengin persistent context guides the model without requiring technical jargon in the prompt.
