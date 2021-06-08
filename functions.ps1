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

function Open-Location {
    [alias("explore")]
    param([string] $path)

    if ($path) { explorer.exe $path }
    else { explorer.exe . }
}