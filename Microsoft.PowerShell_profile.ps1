function LoadModule {
    param([string] $module)

    if (!(Get-Module -ListAvailable -Name $module)) {
        Install-Module $module
    }
}

LoadModule("posh-git")

# on-my-posh
LoadModule("oh-my-posh")
Import-Module posh-git
$env:POSH_GIT_ENABLED = $true
Set-PoshPrompt avit

# PSReadLine
LoadModule("PSReadLine")
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView -MaximumHistoryCount 10 -EditMode Windows

Push-Location (Split-Path $PROFILE)
"functions", "machine_specific" | Where-Object { Test-Path "$_.ps1" } | ForEach-Object -Process { Invoke-Expression ". .\$_.ps1" }
Pop-Location

