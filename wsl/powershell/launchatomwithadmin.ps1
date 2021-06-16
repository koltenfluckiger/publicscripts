param([switch]$Elevated, [string]$lc)
function Test-Admin {
  $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false) {
  if ($elevated) {
    # tried to elevate, did not work, aborting
  }
  else {
    Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -elevated -file "{0}" -lc {1}' -f ($myinvocation.MyCommand.Definition, $MyInvocation.BoundParameters.lc))
  }
  exit
}

powershell.exe Start-Process atom "$lc"
exit
