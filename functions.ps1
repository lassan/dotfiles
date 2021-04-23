function Copy-CurrentLocation {
    param (       
        [switch]$BackSlash = $false
    )

    $path = (Get-Location).Path 
    
    if (!$BaclSlash) { $path = $path -replace "\\", "/" }

    Set-Clipboard $path
    
    $path
}