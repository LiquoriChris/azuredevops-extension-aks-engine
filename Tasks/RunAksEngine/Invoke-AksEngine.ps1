[CmdletBinding()]
param ()

$Command = Get-VstsInput -Name command
if ($Command -eq 'generate') {
    . $PSScriptRoot\Start-AksEngineGenerate.ps1
}

if ($Command -eq 'scale') {
    . $PSScriptRoot\Start-AksEngineScale.ps1
}

if ($Command -eq 'upgrade') {
    . $PSScriptRoot\Start-AksEngineUpgrade.ps1
}

if ($Command -eq 'deploy') {
    . $PSScriptRoot\Start-AksEngineDeploy.ps1
}