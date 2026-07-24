param(
  [switch]$Apply,
  [ValidateSet('local', 'lan', 'tailnet')]
  [string]$BindMode = 'local'
)

$ErrorActionPreference = 'Stop'

function Require-Command {
  param([Parameter(Mandatory = $true)][string]$Name)

  if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
    throw "Required command '$Name' was not found. Install it and reopen PowerShell."
  }
}

function Show-OptionalCommandStatus {
  param([Parameter(Mandatory = $true)][string]$Name)

  if (Get-Command $Name -ErrorAction SilentlyContinue) {
    Write-Host "[ready] $Name found"
  }
  else {
    Write-Warning "$Name was not found. The related Paperclip agents will not run until it is installed and authenticated."
  }
}

Require-Command -Name 'node'
Require-Command -Name 'npm'
Require-Command -Name 'npx'

Write-Host "Node: $(node --version)"
Write-Host "npm:  $(npm --version)"

Show-OptionalCommandStatus -Name 'git'
Show-OptionalCommandStatus -Name 'gh'
Show-OptionalCommandStatus -Name 'codex'
Show-OptionalCommandStatus -Name 'claude'

if (Get-Command gh -ErrorAction SilentlyContinue) {
  Write-Host "Checking GitHub authentication..."
  & gh auth status
  if ($LASTEXITCODE -ne 0) {
    Write-Warning "GitHub CLI is installed but not authenticated. Run 'gh auth login' before allowing coding agents to push branches."
  }
}

$onboardArgs = @(
  '--registry', 'https://registry.npmjs.org',
  'paperclipai', 'onboard', '--yes'
)

if ($BindMode -ne 'local') {
  $onboardArgs += @('--bind', $BindMode)
}

Write-Host "Onboarding or confirming the Paperclip instance..."
& npx @onboardArgs
if ($LASTEXITCODE -ne 0) {
  throw "Paperclip onboarding failed with exit code $LASTEXITCODE."
}

$source = 'NMcKenzie77/paperclip/arkon-development'
$importArgs = @(
  '--registry', 'https://registry.npmjs.org',
  'companies.sh', 'add', $source,
  '--target', 'new',
  '--include', 'company,agents,projects,tasks',
  '-y'
)

if (-not $Apply) {
  $importArgs += '--dry-run'
  Write-Host "Running a dry-run import. No ARKON company records should be applied."
}
else {
  Write-Host "Applying the ARKON Development Control Room import."
}

& npx @importArgs
if ($LASTEXITCODE -ne 0) {
  throw "ARKON company import failed with exit code $LASTEXITCODE."
}

if (-not $Apply) {
  Write-Host ""
  Write-Host "Dry run completed. Review the preview, then apply with:"
  Write-Host "powershell -ExecutionPolicy Bypass -File .\arkon-development\scripts\bootstrap-arkon-paperclip.ps1 -Apply"
}
else {
  Write-Host ""
  Write-Host "Import completed. Start or open Paperclip, verify each adapter and workspace, and leave scheduled heartbeats disabled until the first manual agent test passes."
  Write-Host "Local board: http://127.0.0.1:3100"
}
