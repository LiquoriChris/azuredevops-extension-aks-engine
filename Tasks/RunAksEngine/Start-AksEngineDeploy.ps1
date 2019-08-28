[CmdletBinding()]
param ()

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
$ApiModel = Get-VstsInput -Name apiModel
$SubscriptionId = Get-VstsInput -Name subscriptionId
$ResourceGroupName = Get-VstsInput -Name resourceGroupName
$Location = Get-VstsInput -Name location
$DnsPrefix = Get-VstsInput -Name dnsPrefix
$OutputDirectory = Get-VstsInput -Name outputDirectory
$AuthMethod = Get-VstsInput -Name authMethod
$SetValue = Get-VstsInput -Name setValue
$Debug = Get-VstsInput -Name debug
$ForceOverwrite = Get-VstsInput -Name forceOverwrite
$Argument = New-Object 'System.Collections.Generic.List[System.Object]'
$Argument.Add('--api-model')
$Argument.Add($ApiModel)
$Argument.Add('--subscription-id')
$Argument.Add($SubscriptionId)
$Argument.Add('--resource-group')
$Argument.Add($ResourceGroupName)
$Argument.Add('--location')
$Argument.Add($Location)

if ($AuthMethod -eq 'client_secret') {
    . $PSScriptRoot/Set-AksEngineAuth.ps1
}
else {
    $Argument.Add('--auth-method')
    $Argument.Add($AuthMethod)
}

if ($DnsPrefix) {
    $Argument.Add('--dns-prefix')
    $Argument.Add($DnsPrefix)
}

if ($OutputDirectory) {
    $Argument.Add('--output-directory')
    $Argument.Add($OutputDirectory)
}

if ($SetValue) {
    $Argument.Add('--set')
    $Argument.Add($SetValue)
}

if ($Debug) {
    $Argument.Add('--debug')
}

if ($ForceOverwrite) {
    $Argument.Add('--force-overwrite')
}

aks-engine deploy $Argument
if ($LASTEXITCODE -gt 0) {
    throw 'An error was thrown.'
}