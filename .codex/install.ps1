param(
    [string]$Name = "superpowers",
    [switch]$Force
)

$repoRoot = Split-Path -Parent $PSScriptRoot
$sourceDir = Join-Path $repoRoot "skills"
$targetRoot = Join-Path $HOME ".agents\skills"
$targetDir = Join-Path $targetRoot $Name

if (-not (Test-Path -LiteralPath $sourceDir)) {
    Write-Error "Skills directory not found: $sourceDir"
    exit 1
}

New-Item -ItemType Directory -Force -Path $targetRoot | Out-Null

if (Test-Path -LiteralPath $targetDir) {
    if (-not $Force) {
        Write-Error "Target already exists: $targetDir`nUse -Force to replace it."
        exit 1
    }

    Remove-Item -LiteralPath $targetDir -Recurse -Force
}

$mklinkCommand = "mklink /J `"$targetDir`" `"$sourceDir`""
cmd /c $mklinkCommand | Out-Null

if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to create junction: $targetDir -> $sourceDir"
    exit 1
}

Write-Host "Installed superpowers skills:"
Write-Host "  $targetDir -> $sourceDir"
Write-Host "Restart Codex CLI to load the skills."
