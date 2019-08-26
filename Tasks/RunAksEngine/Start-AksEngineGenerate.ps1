[CmdletBinding()]
param ()

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
$ApiModel = Get-VstsInput -Name apiModel
$CaCertificatePath = Get-VstsInput -Name caCertificatePath
$CaCertificateKey = Get-VstsInput -Name caCertificateKeyPath
$SetValue = Get-VstsInput -Name setValue
$OutputDirectory = Get-VstsInput -Name outputDirectory
$Debug = Get-VstsInput -Name debug
$Argument = @()
$Argument += '--api-model'
$Argument += $ApiModel

if ($OutputDirectory) {
    $Argument += '--output-directory'
    $Argument += $OutputDirectory
}

if ($CaCertificatePath -and $CaCertificateKey) {
    $Argument += '--ca-certificate-path'
    $Argument += $CaCertificatePath
    $Argument += '--ca-private-key-path'
    $Argument += $CaCertificateKey
}

if ($SetValue) {
    $Argument += '--set'
    $Argument += $SetValue
}

if ($Debug) {
    $Argument += '--debug'
}

aks-engine generate $Argument $Argument
if ($LASTEXITCODE -gt 0) {
    throw 'An error was thrown.'
}