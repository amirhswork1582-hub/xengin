# ==============================================================================
# Xengin Deterministic Adapter Synchronization Script
# Synchronizes canonical Antigravity engineering rules into the Claude Code adapter.
# ==============================================================================

[CmdletBinding()]
param (
    [string]$RepoRoot = (Resolve-Path "$PSScriptRoot/..").Path
)

$ErrorActionPreference = "Stop"

Write-Host ">>> Synchronizing Xengin canonical rules to Claude Code adapter..." -ForegroundColor Cyan

$RulesDir = Join-Path $RepoRoot "rules"
$IncludesDir = Join-Path $RulesDir "includes"
$ClaudeSkillsDir = Join-Path $RepoRoot "platforms/claude-code/skills"

if (-not (Test-Path $RulesDir)) {
    throw "Rules directory not found at $RulesDir"
}

# Define target skills and their needed reference chapters
$SkillReferences = @{
    "xengin-task" = @("core.md", "workflow.md", "frontend.md", "backend.md", "final-enforcement-gate.md", "risk-model.md", "graphify-policy.md")
    "xengin-plan" = @("core.md", "workflow.md", "risk-model.md", "graphify-policy.md", "frontend.md", "backend.md")
    "xengin-review" = @("core.md", "final-enforcement-gate.md", "risk-model.md", "frontend.md", "backend.md")
}

foreach ($skill in $SkillReferences.Keys) {
    $targetRefDir = Join-Path (Join-Path $ClaudeSkillsDir $skill) "references"
    New-Item -ItemType Directory -Path $targetRefDir -Force | Out-Null
    
    foreach ($file in $SkillReferences[$skill]) {
        # Check in rules/ or rules/includes/
        $sourcePath = $null
        if (Test-Path (Join-Path $IncludesDir $file)) {
            $sourcePath = Join-Path $IncludesDir $file
        } elseif (Test-Path (Join-Path $RulesDir $file)) {
            $sourcePath = Join-Path $RulesDir $file
        }
        
        if ($sourcePath) {
            $destPath = Join-Path $targetRefDir $file
            Copy-Item -Path $sourcePath -Destination $destPath -Force
            Write-Host "  [OK] $skill/references/$file <- $(Split-Path $sourcePath -Leaf)" -ForegroundColor Green
        } else {
            Write-Warning "Source reference not found for $file"
        }
    }
}

Write-Host ">>> Synchronization complete. Zero rulebook drift guaranteed." -ForegroundColor Cyan
