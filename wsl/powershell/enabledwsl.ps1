param([switch]$elevated)

function Test-Admin {
  $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false) {
  if ($elevated) {
    # tried to elevate, did not work, aborting
  }
  else {
    Start-Process powershell.exe -Verb RunAs -ArgumentList ('-WindowStyle hidden -noprofile -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
  }
  exit
}

dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

cd $HOME\Downloads
curl 'https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi'

explorer.exe $HOME\Downloads
Read-Host -Prompt "Press any key to continue after you installed the update"
wsl --set-default-version 2
$distro = Read-Host -Prompt "Please install your preferred distro"


wsl --set-version $distro 2
