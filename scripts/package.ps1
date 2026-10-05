param([string]$OutputDirectory, [switch]$Force)
$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
if (-not $OutputDirectory) {
  # Default output folder: two levels above the project folder, derived instead of hard-coded
  $OutputDirectory = Split-Path -Parent (Split-Path -Parent $projectRoot)
}
$manifest = Get-Content -LiteralPath (Join-Path $projectRoot 'manifest.json') -Raw | ConvertFrom-Json
$zipPath = Join-Path $OutputDirectory "orchid-bloom-theme-$($manifest.version).zip"
if (Test-Path -LiteralPath $zipPath) {
  if (-not $Force) { throw "Archive already exists: $zipPath" }
  Remove-Item -LiteralPath $zipPath -Force
}
$items = @('manifest.json', 'logo', 'README.md', 'scripts', 'store-assets', 'PACKAGING.md', 'LICENSE', '.gitignore') | ForEach-Object { Join-Path $projectRoot $_ }
Compress-Archive -LiteralPath $items -DestinationPath $zipPath -Force

# Verify the finished archive instead of trusting the compression step
Add-Type -AssemblyName System.IO.Compression.FileSystem
$zip = [System.IO.Compression.ZipFile]::OpenRead($zipPath)
try {
  $names = @($zip.Entries | ForEach-Object { $_.FullName -replace '\\', '/' })
  if ($names -notcontains 'manifest.json') { throw 'manifest.json must sit at the archive root' }
  if ($names | Where-Object { $_ -like '.codebuddy/*' }) { throw 'local AI data (.codebuddy/) leaked into the archive' }
  if ($names | Where-Object { $_ -like '*.pak' -or $_ -like '*.zip' }) { throw 'build artifacts leaked into the archive' }
  $entry = $zip.Entries | Where-Object { ($_.FullName -replace '\\', '/') -eq 'manifest.json' }
  $reader = New-Object System.IO.StreamReader($entry.Open())
  try { $inside = $reader.ReadToEnd() | ConvertFrom-Json } finally { $reader.Dispose() }
  if ($inside.name -ne $manifest.name -or $inside.version -ne $manifest.version) { throw 'manifest inside the archive does not match the project manifest' }
  $refs = @()
  if ($inside.icons) { $refs += $inside.icons.PSObject.Properties.Value }
  foreach ($ref in $refs) {
    if ($names -notcontains ($ref -replace '\\', '/')) { throw "manifest references a file missing from the archive: $ref" }
  }
} finally { $zip.Dispose() }

Get-Item -LiteralPath $zipPath | Select-Object FullName,Length,LastWriteTime
