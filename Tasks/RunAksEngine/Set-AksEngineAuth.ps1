Write-Output 'Getting service principal information'
$ClientId = Get-VstsInput -Name clientId
$ClientSecret = Get-VstsInput -Name clientSecret
$Argument += '--client-id'
$Argument += $ClientId
$Argument += '--client-secret'
$Argument += $ClientSecret