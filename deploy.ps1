param(
  [string]$ConfigDir = "$env:USERPROFILE\.config\opencode"
)

Write-Host "Deploying global opencode config to: $ConfigDir" -ForegroundColor Cyan

# 1. Global config
if (-not (Test-Path -LiteralPath $ConfigDir)) {
  New-Item -ItemType Directory -Path $ConfigDir -Force | Out-Null
}
Copy-Item -LiteralPath "global\opencode.jsonc" -Destination "$ConfigDir\opencode.jsonc" -Force
Write-Host "  ✅ global\opencode.jsonc -> $ConfigDir\opencode.jsonc"

# 2. Agent prompts
$AgentDir = "$ConfigDir\agents"
if (-not (Test-Path -LiteralPath $AgentDir)) {
  New-Item -ItemType Directory -Path $AgentDir -Force | Out-Null
}
Get-ChildItem -LiteralPath "global\agents\*.md" | ForEach-Object {
  Copy-Item -LiteralPath $_.FullName -Destination "$AgentDir\$($_.Name)" -Force
  Write-Host "  ✅ global\agents\$($_.Name) -> $AgentDir\$($_.Name)"
}

# 3. Audit plugin
$PluginDir = "$ConfigDir\plugins"
if (-not (Test-Path -LiteralPath $PluginDir)) {
  New-Item -ItemType Directory -Path $PluginDir -Force | Out-Null
}
Copy-Item -LiteralPath "global\plugins\pmo-audit.mjs" -Destination "$PluginDir\pmo-audit.mjs" -Force
Write-Host "  ✅ global\plugins\pmo-audit.mjs -> $PluginDir\pmo-audit.mjs"

Write-Host ""
Write-Host "Done. Restart opencode for changes to take effect." -ForegroundColor Green
