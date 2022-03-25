$env:POSH_GIT_ENABLED = $true

Import-Module posh-git
Import-Module oh-my-posh
# Set-PoshPrompt -Theme "./omp.json"
Set-PoshPrompt star
# oh-my-posh --init --shell pwsh --config ./omp.json | Invoke-Expression


Push-Location (Split-Path $PROFILE)
"functions" | Where-Object { Test-Path "$_.ps1" } | ForEach-Object -Process { Invoke-Expression ". .\$_.ps1" }
Pop-Location

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

