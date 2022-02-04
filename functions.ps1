function Copy-CurrentLocation {
    [alias("ccl")]
    param (       
        [switch]$BackSlash = $false
    )

    $path = (Get-Location).Path 
    
    if (!$BackSlash) { $path = $path -replace "\\", "/" }

    Set-Clipboard $path
    
    $path
}

function Update-Env {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
}