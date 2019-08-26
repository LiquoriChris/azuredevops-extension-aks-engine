[CmdletBinding()]
param ()

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
$ApiModel = Get-VstsInput -Name apiModel
$CaCertificatePath = Get-VstsInput -Name caCertificatePath
$CaCertificateKey = Get-VstsInput -Name caCertificateKeyPath
$SetValue = Get-VstsInput -Name setValue
$OutputDirectory = Get-VstsInput -Name outputDirectory
$Debug = Get-VstsInput -Name debug
$Argument = New-Object 'System.Collections.Generic.List[System.Object]'
$Argument.Add('--api-model')
$Argument.Add($ApiModel)

if ($OutputDirectory) {
    $Argument.Add('--output-directory')
    $Argument.Add($OutputDirectory)
}

if ($CaCertificatePath -and $CaCertificateKey) {
    $Argument.Add('--ca-certificate-path')
    $Argument.Add($CaCertificatePath)
    $Argument.Add('--ca-private-key-path')
    $Argument.Add($CaCertificateKey)
}

if ($SetValue) {
    $Argument.Add('--set')
    $Argument.Add($SetValue)
}

if ($Debug) {
    $Argument.Add('--debug')
}

aks-engine generate $Argument
if ($LASTEXITCODE -gt 0) {
    throw 'An error was thrown.'
}