param (
  [Parameter(Mandatory = $True)]
  [string]$u
)
try {
  Start-Process $u
}
catch {
  Write-Host $_
}
