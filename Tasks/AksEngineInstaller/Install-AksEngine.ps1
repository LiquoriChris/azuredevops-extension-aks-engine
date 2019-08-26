[CmdletBinding()]
param ()

$Version = Get-VstsInput -Name version
Try {
    $Release = 'https://api.github.com/repos/azure/aks-engine/releases'
    if ($Version -eq 'specificVersion') {
        $Tag = Get-VstsInput -Name aksEngineVersion
        $Tag = "v$Tag"
    }
    else {
        $Tag = (Invoke-WebRequest -Uri $Release |ConvertFrom-Json) |Select-Object -First 1 |Select-Object -ExpandProperty tag_name
    }
    Try {
        Resolve-Path -Path $env:Agent_ToolsDirectory/aks-engine/aks-engine-$($Tag)-windows-amd64 -ErrorAction Stop
        Write-Output "AKS-Engine version: $Tag is already installed."
    }
    Catch {
        Try {
            Write-Output "Downloading AKS-Engine version: $Tag"
            Invoke-WebRequest -Uri "https://github.com/azure/aks-engine/releases/download/$Tag/aks-engine-$($Tag)-windows-amd64.zip" -OutFile $env:Agent_TempDirectory/aksengine.zip -ErrorAction Stop
        }
        Catch {
            throw $_
        }
        Try {
            Expand-Archive -Path $env:Agent_TempDirectory/aksengine.zip -DestinationPath $env:Agent_ToolsDirectory/aks-engine -ErrorAction Stop
            [Environment]::SetEnvironmentVariable("Path", $env:Path + ";$env:Agent_ToolsDirectory/aks-engine/aks-engine-$($Tag)-windows-amd64", "Machine")
            $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
            aks-engine version
        }
        Catch {
            throw $_
        }
    }
}
Catch {
    throw $_
}