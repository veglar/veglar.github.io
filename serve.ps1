# Local Jekyll preview for veglar.github.io
# Usage: right-click > Run with PowerShell, or:  .\serve.ps1
# Site will be at http://127.0.0.1:4000/ and rebuilds on save.

$env:Path = "C:\Ruby33-x64\bin;" + $env:Path

# Ensure the private sublib submodule is present (project pages need it)
if (-not (Test-Path "_includes\sublib\data_load_script")) {
    Write-Host "Initializing sublib submodule..." -ForegroundColor Yellow
    git submodule update --init _includes/sublib
}

# Install/refresh gems if needed
bundle check 2>$null
if ($LASTEXITCODE -ne 0) { bundle install }

bundle exec jekyll serve --livereload --host 127.0.0.1 --port 4000
