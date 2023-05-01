#Install-Module DellBIOSProvider
#Import-Module DellBIOSProvider
$ErrorActionPreference = 'Stop'

try   {
            "$(Get-Date -Format "yyyy.MM.dd hh:mm:ss") - Importing the Dell BIOS Provider 2.7.0 module" | Out-File -FilePath "$PSScriptRoot\DellBIOSProvider.2.7.0.log" 
            Import-Module "$PSScriptRoot\dellbiosprovider.2.7.0\DellBIOSProvider.PSd1" -Force -Scope Local
            $SettingsList = (Get-ChildItem DellSmBIOS:\).category  
      }
catch {
    "$(Get-Date -Format "yyyy.MM.dd hh:mm:ss") - Could not load the module properly`n" | Out-File -FilePath "$PSScriptRoot\DellBIOSProvider.2.7.0.log" 
    "Error Exception type: $($_.Exception.getType().FullName)" | Out-File -FilePath "$PSScriptRoot\DellBIOSProvider.2.7.0.log" 
    break
}

$Output = New-Object System.Collections.ArrayList
$i      = 1
$t      = $SettingsList.count

foreach ($Unit in $SettingsList)
{
    Write-Progress -Activity "$i/$t - Working on $unit category" -Id 10 -PercentComplete $(($i++/$t)*100)
    $BIOSSettings = Get-ChildItem -Path ("DellSmBIOS:\" + $Unit) -WarningVariable +BIOS_Warning -WarningAction SilentlyContinue

    $j = 1
    foreach ($Junit in $BIOSSettings)
    {
        Write-Progress -Activity "Getting the $($Junit.Attribute) Attribute info" -ParentId 10 -PercentComplete $(($j++/$t)*100)
        $objProp = @{
                'Category'         = $unit;
                'Attribute'        = $Junit.Attribute;
                'CurrentValue'     = $Junit.CurrentValue;
                'ShortDescription' = $Junit.ShortDescription
            }
        $Obj = New-Object PSCustomObject -Property $objProp
        $Output.Add($obj) | Out-Null

        Clear-Variable JUNIT,objProp,Obj
    }
}

#region Output
    "Generating results" | Out-File -FilePath "$PSScriptRoot\DellBIOSProvider.2.7.0.log" 
    $JSONOutput = $output | ConvertTo-Json
    $JSONOutput   | Out-File -FilePath "$PSScriptRoot\BIOSSettings.json"
    $BIOS_Warning | Out-File -FilePath "$PSScriptRoot\BIOS_Warnings.txt"

    if ((Test-Path "$PSScriptRoot\BiosSettings.csv") -eq $true) {Remove-Item "$PSScriptRoot\BiosSettings.csv" -Force -Confirm:$false}
    $Output       | Export-Csv -Path "$PSScriptRoot\BiosSettings.csv" -NoClobber -NoTypeInformation -Force -Confirm:$false
    "Closing script" | Out-File -FilePath "$PSScriptRoot\DellBIOSProvider.2.7.0.log" 
#endregion Output


