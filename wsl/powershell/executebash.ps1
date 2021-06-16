# This allows you to execute bash scripts within powershell

param ([string] $scriptpath, $scriptargs)

If ($scriptpath -eq "") {
    Write-Host "No script path given. -scriptpath"
    exit
}

$scriptpath = $scriptpath -replace '\\', '/'
$scriptpath = $scriptpath -replace 'U:', ''

$scriptargs = $scriptargs -replace 'U:', ''
$scriptargs = $scriptargs -replace '\\', '/'

wsl --exec $scriptpath $scriptargs
