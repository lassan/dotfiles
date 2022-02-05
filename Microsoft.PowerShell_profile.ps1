# if (!(Get-Module -ListAvailable -Name "oh-my-posh")) {
#     Install-Module oh-my-posh
# }

if (!(Get-Module -ListAvailable -Name "posh-git")) {
    Install-Module posh-git
}

if (!(Get-Module -ListAvailable -Name "PSScriptTools")) {
    Install-Module PSScriptTools
}

if (!(Get-Module -ListAvailable -Name "PSReadLine")) {
    Install-Module PSScriptTools -AllowPrerelease
}

if (!(Get-Module -ListAvailable -Name "Terminal-Icons")) {
    Install-Module Terminal-Icons
}

if (!(Get-Module -ListAvailable -Name "z")) {
    Install-Module z
}

$env:POSH_GIT_ENABLED = $true

oh-my-posh --init --shell pwsh --config omp.json | Invoke-Expression


Push-Location (Split-Path $PROFILE)
"functions" | Where-Object { Test-Path "$_.ps1" } | ForEach-Object -Process { Invoke-Expression ". .\$_.ps1" }
Pop-Location
Set-PoshPrompt avit

# PSReadLine

Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView -MaximumHistoryCount 10 -EditMode Windows

# Terminal-Icons
Import-Module Terminal-Icons

Import-Module z

Push-Location (Split-Path $PROFILE)
"functions", "machine_specific" | Where-Object { Test-Path "$_.ps1" } | ForEach-Object -Process { Invoke-Expression ". .\$_.ps1" }
Pop-Location

