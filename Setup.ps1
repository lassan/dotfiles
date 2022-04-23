#Requires -RunAsAdministrator

$profileDir = (Split-Path $PROFILE)
$onOneDrive = $profileDir -like "*OneDrive*"

if ($onOneDrive) {
    Write-Warning "Powershell profile is in a OneDrive folder. As a result, symbolink links will not be created - files will be copied instead."

}

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

        if (-not (Test-Path $profileDir)) {
            New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
        }

        if (-not (Test-Path $pathToWrite)) {
            New-Item -ItemType SymbolicLink -Target $target -Path $pathToWrite
        }
    }
}

function CopyOrCreateSymLink {
    [cmdletbinding()]

    param(
        [parameter(Mandatory = $true, ValueFromPipeline = $true)] 
        [string]
        $target)

    process {
        
        $filePath = Resolve-Path $target -Relative        
        $pathToWrite = (Join-Path -Path $profileDir -ChildPath $filePath)
        
        
        if (-not (Test-Path $pathToWrite)) {
            if ($onOneDrive) {
                New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
                Copy-Item -Path $filePath -Destination $pathToWrite
            }
            else {
                New-Item -ItemType SymbolicLink -Target $target -Path $pathToWrite
            }
        }
        else {
            Write-Warning "$pathToWrite to exists already. Skipping" 
        }
    }   
}

function Copy-Scripts {
    Get-ChildItem | Where-Object { $_.Extension -eq ".ps1" } | Where-Object { $_.FullName -ne $PSCommandPath } | CopyOrCreateSymLink
}

function Copy-OhMyPoshTheme {
    Get-ChildItem | Where-Object { $_.Name -contains "omp.json" } |  CopyOrCreateSymLink
}

function Install-Modules {
    Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted

    if (!(Get-Module -ListAvailable -Name "oh-my-posh")) {
        Install-Module oh-my-posh
    }

    if (!(Get-Module -ListAvailable -Name "posh-git")) {
        Install-Module posh-git
    }

    if (!(Get-Module -ListAvailable -Name "PSScriptTools")) {
        Install-Module PSScriptTools
    }

    if (!(Get-Module -ListAvailable -Name "PSReadLine")) {
        Install-Module PSReadLine -AllowPrerelease
    }

    if (!(Get-Module -ListAvailable -Name "Terminal-Icons")) {
        Install-Module Terminal-Icons
    }

    if (!(Get-Module -ListAvailable -Name "z")) {
        Install-Module z
    }
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

Install-Modules
Copy-Scripts
Copy-GitConfig
Copy-OhMyPoshTheme
