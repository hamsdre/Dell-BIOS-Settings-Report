<#
.Synopsis
   Version | Date       | Author                   | Description
   1.0     | 2023.04.30 | Gabriel Valenitn Nedelcu | New Script
.DESCRIPTION
   The script will extract log files from the system
.EXAMPLE
   & .\logs.ps1
.NOTES
   General notes
.COMPONENT
   The component this cmdlet belongs to
.ROLE
   The role this cmdlet belongs to
.FUNCTIONALITY
   The functionality that best describes this cmdlet
#>

<# Initialize #>
$Location = "E:\Work\GitHub\Dell-BIOS-Settings-Report\GetBIOSSettings"
#$Location = $PSScriptRoot

<# System 32 apps#>
msinfo32 /nfo    "$Location\LogFiles\MSinfo32.csv"
msinfo32 /report "$Location\LogFiles\MSinfo32.txt"

SYSTEMINFO  /FO CSV | Out-File -FilePath "$Location\LogFiles\SystemInfo.csv"
DRIVERQUERY /FO CSV /SI | Out-File -FilePath "$Location\LogFiles\DriverQuery.csv"

<# WMI Classes#>

Get-WmiObject -Class win32_BIOS           | ConvertTo-Json | Out-File "$Location\LogFiles\WMI_BIOS.json"
Get-WmiObject -Class win32_BaseBoard      | ConvertTo-Json | Out-File "$Location\LogFiles\WMI_BaseBoard.json"
Get-WmiObject -Class win32_ComputerSystem | ConvertTo-Json | Out-File "$Location\LogFiles\WMI_ComputerSystem.json"
Get-WmiObject -Class win32_Processor      | ConvertTo-Json | Out-File "$Location\LogFiles\WMI_Processor.json"


