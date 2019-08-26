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
$Argument = @()
$Argument += '--api-model'
$Argument += $ApiModel
$Argument += '--subscription-id'
$Argument += $Subscription
$Argument += '--resource-group'
$Argument += $ResourceGroupName
$Argument += '--location'
$Argument += $Location
$Argument += '--upgrade-version'
$Argument += $UpgradeVersion

if ($AuthMethod -eq 'client_secret') {
    . $PSScriptRoot/Set-AksEngineAuth.ps1
}
else {
    $Argument += '--auth-method'
    $Argument += $AuthMethod
}

if ($Debug) {
    $Argument += '--debug'
}

aks-engine scale $Argument $Argument
if ($LASTEXITCODE -gt 0) {
    throw 'An error was thrown.'
}