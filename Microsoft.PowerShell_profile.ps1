Set-PoshPrompt avit

Push-Location (Split-Path $PROFILE)
"functions" | Where-Object { Test-Path "$_.ps1" } | ForEach-Object -Process { Invoke-Expression ". .\$_.ps1" }
Pop-Location
