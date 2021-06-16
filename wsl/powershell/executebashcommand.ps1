# This allows you to execute bash scripts within powershell

param ([string] $command, $commandargs)

If ($command -eq "") {
    Write-Host "No script path given. -command"
    exit
}

$command = $command -replace '\\', '/'
$command = $command -replace 'U:', ''

$commandargs = $commandargs -replace 'U:', ''
$commandargs = $commandargs -replace '\\', '/'

wsl --exec $command $commandargs
