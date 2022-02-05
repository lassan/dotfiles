#Requires -RunAsAdministrator

$profileDir = (Split-Path $PROFILE)

function New-SymLink {
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true, ValueFromPipeline = $true)] 
        [string]
        $target)

    process {
        $filePath = Resolve-Path $target -Relative        
        Write-Host $filePath
        $pathToWrite = (Join-Path -Path $profileDir -ChildPath $filePath)
        
        Write-Host $pathToWrite

        if (-not (Test-Path $pathToWrite)) {
            New-Item -ItemType SymbolicLink -Target $target -Path $pathToWrite
        }
    }
}

function Copy-Scripts {
    Get-ChildItem | Where-Object { $_.Extension -eq ".ps1" } | Where-Object { $_.FullName -ne $PSCommandPath } | New-SymLink
}

function Copy-OhMyPoshTheme {
    "./omp.json" | New-SymLink
}



function Copy-GitConfig {
    param(
        [parameter(Mandatory = $true)]    
        [string] $email,
        [parameter(Mandatory = $true)]    
        [string] $fullName)
    

    Get-Content -Path ".\.gitconfig" | ForEach-Object { 
        $_ -Replace '\$email\$', $email `
            -Replace '\$name\$', $fullName
    } | Set-Content "~\.gitconfig"
}

Copy-Scripts
#Copy-GitConfig
Copy-OhMyPoshTheme
