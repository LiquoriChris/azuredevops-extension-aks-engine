Write-Output 'Getting service principal information'
$ClientId = Get-VstsInput -Name clientId
$ClientSecret = Get-VstsInput -Name clientSecret
$Argument.Add('--client-id')
$Argument.Add($ClientId)
$Argument.Add('--client-secret')
$Argument.Add($ClientSecret)