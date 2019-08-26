[CmdletBinding()]
param ()

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
$ApiModel = Get-VstsInput -Name apiModel
$Subscription = Get-VstsInput -Name subscription
$ResourceGroupName = Get-VstsInput -Name resourceGroupName
$Location = Get-VstsInput -Name location
$AuthMethod = Get-VstsInput -Name authMethod
$UpgradeVersion = Get-VstsInput -Name upgradeVersion
$Debug = Get-VstsInput -Name debug
$Argument = New-Object 'System.Collections.Generic.List[System.Object]'
$Argument.Add('--api-model')
$Argument.Add($ApiModel)
$Argument.Add('--subscription-id')
$Argument.Add($Subscription)
$Argument.Add('--resource-group')
$Argument.Add($ResourceGroupName)
$Argument.Add('--location')
$Argument.Add($Location)
$Argument.Add('--upgrade-version')
$Argument.Add($UpgradeVersion)

if ($AuthMethod -eq 'client_secret') {
    . $PSScriptRoot/Set-AksEngineAuth.ps1
}
else {
    $Argument.Add('--auth-method')
    $Argument.Add($AuthMethod)
}

if ($Debug) {
    $Argument.Add('--debug')
}

aks-engine scale $Argument
if ($LASTEXITCODE -gt 0) {
    throw 'An error was thrown.'
}