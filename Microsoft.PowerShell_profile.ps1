if (!(Get-Module -ListAvailable -Name "oh-my-posh")) {
    Install-Module oh-my-posh
}
if(!(Get-Module -ListAvailable -Name "posh-git")) {
    Install-Module posh-git
}

$env:POSH_GIT_ENABLED = $true

Set-PoshPrompt avit

Push-Location (Split-Path $PROFILE)
"functions" | Where-Object { Test-Path "$_.ps1" } | ForEach-Object -Process { Invoke-Expression ". .\$_.ps1" }
Pop-Location
