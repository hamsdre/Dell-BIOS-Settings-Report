# Import the helper functions

Import-Module $PSScriptRoot\..\..\Misc\helper.psm1 -Verbose:$false

function Get-TargetResource
{
	[CmdletBinding()]
	[OutputType([System.Collections.Hashtable])]
	param
	(
		[parameter(Mandatory = $true)]
		[System.String]
		$Category
	)

	#Write-Verbose "Use this cmdlet to deliver information about command processing."

	#Write-Debug "Use this cmdlet to write debug information while troubleshooting."


	<#
	$returnValue = @{
		Category = [System.String]
		MultiCoreSupport = [System.String]
		IntelSpeedStep = [System.String]
		CStates = [System.String]
		IntelTurboBoost = [System.String]
		HyperThreadControl = [System.String]
		Password = [System.String]
		SecurePassword = [System.String]
		PathToKey = [System.String]
	}

	$returnValue
	#>
	
				   # Check if module DellBIOSprovider is already loaded. If not, load it.
   try{
    $bool = Confirm-DellPSDrive -verbose
    }
    catch 
    {
        write-Verbose $_
        $msg = "Get-TargetResource: $($_.Exception.Message)"
        Write-DellEventLog -Message $msg -EventID 1 -EntryType 'Error'
        write-Verbose "Exiting Get-TargetResource"
        return
    }
    if ($bool) {                      
        Write-Verbose "Dell PS-Drive DellSmbios is found."
    }
    else{
        $Message = “Get-TargetResource: Module DellBiosProvider was imported correctly."
        Write-DellEventLog -Message $Message -EventID 2 
    }

    $Get = get-childitem -path @("DellSmbios:\" + $Category)
     # Removing Verbose and Debug from output
    $PSBoundParameters.Remove("Verbose") | out-null
    $PSBoundParameters.Remove("Debug") | out-null

  
    $out = @{}   
    $Get | foreach-Object {$out.Add($_.Attribute, $_.CurrentValue)}
    $out.add('Category', $Category )
    $out

}


function Set-TargetResource
{
	[CmdletBinding()]
	param
	(
		[parameter(Mandatory = $true)]
		[System.String]
		$Category,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$WatchdogTimer,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$MEMSSensors,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$KeyboardBacklightOnAc,
		
		[ValidateSet("Enabled","Disabled","Auto")]
		[System.String]
		$IntegratedAudio,
		
		[ValidateSet("Enabled","Disabled","Low","Medium","High")]
		[System.String]
		$InternalSpeaker,
		
		[ValidateSet("Enabled","Disabled","EnabledPxe","OnWithImageServerBoot","EnabledwithRPLBoot","EnabledwithISCSIBoot")]
		[System.String]
		$EmbNic1,
		
		[ValidateSet("Off","25","50","75","100","Auto")]
		[System.String]
		$KeyboardIllumination,
		
		[ValidateSet("Ata","Disabled","Ahci","Raid")]
		[System.String]
		$EmbSataRaid,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$PowerButton,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$OnboardSoundDevice,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$IoModule,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$CanBus,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$UefiNwStack,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Sata0,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Sata1,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Sata2,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Sata3,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Sata4,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Sata5,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Sata6,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Sata7,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Minisas0,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Minisas1,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Minisas2,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Minisas3,
		
		[ValidateSet("Unused","ADCInput","DACOutput","DACAndADC","GPIO")]
		[System.String]
		$AnalogDigitalInterfaceModeChannel1,

		[ValidateSet("Unused","ADCInput","DACOutput","DACAndADC","GPIO")]
		[System.String]
		$AnalogDigitalInterfaceModeChannel2,

		[ValidateSet("Unused","ADCInput","DACOutput","DACAndADC","GPIO")]
		[System.String]
		$AnalogDigitalInterfaceModeChannel3,

		[ValidateSet("Unused","ADCInput","DACOutput","DACAndADC","GPIO")]
		[System.String]
		$AnalogDigitalInterfaceModeChannel4,

		[ValidateSet("Unused","ADCInput","DACOutput","DACAndADC","GPIO")]
		[System.String]
		$AnalogDigitalInterfaceModeChannel5,

		[ValidateSet("Unused","ADCInput","DACOutput","DACAndADC","GPIO")]
		[System.String]
		$AnalogDigitalInterfaceModeChannel6,

		[ValidateSet("Unused","ADCInput","DACOutput","DACAndADC","GPIO")]
		[System.String]
		$AnalogDigitalInterfaceModeChannel7,

		[ValidateSet("Unused","ADCInput","DACOutput","DACAndADC","GPIO")]
		[System.String]
		$AnalogDigitalInterfaceModeChannel8,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$SmartErrors,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$DisOsdBtn,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Hdd1FanEnable,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Hdd2FanEnable,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Hdd3FanEnable,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$LiquidCooler1,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$LiquidCooler2,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$UsbPowerShare,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Microphone,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$DockSupportOnBattery,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$UnobtrusiveMode,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Touchscreen,		

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$M2PcieSsd0,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$M2PcieSsd1,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$MmioAbove4Gb,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$IntegratedSas,		
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$OptionalBootSequence,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$NearFieldComputing,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$ForcePxeNextBoot,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$ForcePXEasFirstBootDevice,
				
		[ValidateSet("Auto","Disabled")]
		[System.String]
		$VmdPcieSlot,
						
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$VmdNvmePcie0,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$VmdNvmePcie1,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$VmdNvmePcie0Cpu1,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$VmdNvmePcie1Cpu1,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Sata8,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$EMMCDevice,
		
		[System.String]
		$Password,

		[System.String]
		$SecurePassword,

		[System.String]
		$PathToKey
	)

    if (-not(CheckModuleLoaded)) {
        Write-Verbose -Message 'Required module DellBiosProvider does not exist. Exiting.'
        return $true
    }

    $DellPSDrive = get-psdrive -name Dellsmbios
    if ( !$DellPSDrive)
    {
        $Message = "Drive DellSmbios is not found. Exiting."
        Write-Verbose $Message
        Write-DellEventLog -Message $Message -EventID 3 -EntryType "Error"
        return $true
    }
    $attributes_desired = $PSBoundParameters
    $atts = $attributes_desired

    $pathToCategory = $DellPSDrive.Name + ':\' + $atts["Category"]
    
    Dir $pathToCategory -verbose

    $atts.Remove("Verbose") | out-null
    $atts.Remove("Category") | out-null
    $atts.Remove("Debug") | out-null
    $securePwd=$atts["SecurePassword"]
    $passwordSet=$atts["Password"]
    $atts.Remove("Password") | Out-Null
    $atts.Remove("SecurePassword") | Out-Null
    $pathToKey=$atts["PathToKey"]
	if(-Not [string]::IsNullOrEmpty($pathToKey))
	{  
		if(Test-Path $pathToKey)
		{
		$key=Get-Content $pathToKey
		}
		else
		{
		$key=""
		}
	}
    $atts.Remove("PathToKey") | Out-Null
    
    #foreach($a in Import-Csv((Get-DellBIOSEncryptionKey)))
    #{
   # $key+=$a
   # }
    $atts.Keys | foreach-object { 
                   # $atts[$_]
                    $path = $pathToCategory + '\' + $($_)
                    $value = $atts[$_]
		    if(-Not [string]::IsNullOrEmpty($securePwd))
		    {                
			$pasvar=ConvertTo-SecureString $securePwd.ToString() -Key $key
            Set-Item  -path $path -value $value -verbose -ErrorVariable ev -ErrorAction SilentlyContinue -PasswordSecure $pasvar
		    }

		    elseif(-Not [string]::IsNullOrEmpty($passwordSet))
		    {
			Set-Item  -path $path -value $value -verbose -ErrorVariable ev -ErrorAction SilentlyContinue -Password $passwordSet
		    }

		    else
		    {
			Set-Item  -path $path -value $value -verbose -ErrorVariable ev -ErrorAction SilentlyContinue
		    }
                    if ( $ev) { 
                        $cmdline = $ExecutionContext.InvokeCommand.ExpandString($ev.InvocationInfo.Line)
                        $Message = "An error occured in executing " + $cmdline + "`nError message: $($ev.ErrorDetails)"
                        Write-Verbose $Message
                        Write-DellEventLog -Message $Message -EventID 5 -EntryType "Error"
                    }
                    
                 }



}


function Test-TargetResource
{
	[CmdletBinding()]
	[OutputType([System.Boolean])]
	param
	(
		[parameter(Mandatory = $true)]
		[System.String]
		$Category,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$WatchdogTimer,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$MEMSSensors,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$KeyboardBacklightOnAc,
		
		[ValidateSet("Enabled","Disabled","Auto")]
		[System.String]
		$IntegratedAudio,
		
		[ValidateSet("Enabled","Disabled","Low","Medium","High")]
		[System.String]
		$InternalSpeaker,
		
		[ValidateSet("Enabled","Disabled","EnabledPxe","OnWithImageServerBoot","EnabledwithRPLBoot","EnabledwithISCSIBoot")]
		[System.String]
		$EmbNic1,
		
		[ValidateSet("Ata","Disabled","Ahci","Raid")]
		[System.String]
		$EmbSataRaid,
		
		[ValidateSet("Off","25","50","75","100","Auto")]
		[System.String]
		$KeyboardIllumination,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$PowerButton,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$OnboardSoundDevice,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$IoModule,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$CanBus,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$UefiNwStack,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Sata0,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Sata1,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Sata2,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Sata3,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Sata4,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Sata5,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Sata6,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Sata7,
				
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Minisas0,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Minisas1,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Minisas2,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Minisas3,
		
		[ValidateSet("Unused","ADCInput","DACOutput","DACAndADC","GPIO")]
		[System.String]
		$AnalogDigitalInterfaceModeChannel1,

		[ValidateSet("Unused","ADCInput","DACOutput","DACAndADC","GPIO")]
		[System.String]
		$AnalogDigitalInterfaceModeChannel2,

		[ValidateSet("Unused","ADCInput","DACOutput","DACAndADC","GPIO")]
		[System.String]
		$AnalogDigitalInterfaceModeChannel3,

		[ValidateSet("Unused","ADCInput","DACOutput","DACAndADC","GPIO")]
		[System.String]
		$AnalogDigitalInterfaceModeChannel4,

		[ValidateSet("Unused","ADCInput","DACOutput","DACAndADC","GPIO")]
		[System.String]
		$AnalogDigitalInterfaceModeChannel5,

		[ValidateSet("Unused","ADCInput","DACOutput","DACAndADC","GPIO")]
		[System.String]
		$AnalogDigitalInterfaceModeChannel6,

		[ValidateSet("Unused","ADCInput","DACOutput","DACAndADC","GPIO")]
		[System.String]
		$AnalogDigitalInterfaceModeChannel7,

		[ValidateSet("Unused","ADCInput","DACOutput","DACAndADC","GPIO")]
		[System.String]
		$AnalogDigitalInterfaceModeChannel8,		
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$SmartErrors,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$DisOsdBtn,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Hdd1FanEnable,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Hdd2FanEnable,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Hdd3FanEnable,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$LiquidCooler1,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$LiquidCooler2,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$UsbPowerShare,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Microphone,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$DockSupportOnBattery,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$UnobtrusiveMode,

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Touchscreen,		

		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$M2PcieSsd0,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$M2PcieSsd1,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$MmioAbove4Gb,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$IntegratedSas,		
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$OptionalBootSequence,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$NearFieldComputing,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$ForcePxeNextBoot,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$ForcePXEasFirstBootDevice,
		
		[ValidateSet("Auto","Disabled")]
		[System.String]
		$VmdPcieSlot,
						
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$VmdNvmePcie0,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$VmdNvmePcie1,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$VmdNvmePcie0Cpu1,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$VmdNvmePcie1Cpu1,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$Sata8,
		
		[ValidateSet("Enabled","Disabled")]
		[System.String]
		$EMMCDevice,

		[System.String]
		$Password,

		[System.String]
		$SecurePassword,

		[System.String]
		$PathToKey
	)

    $Get = Get-TargetResource $PSBoundParameters['Category'] -verbose

    New-DellEventLog
 
    $PSBoundParameters.Remove("Verbose") | out-null
    $PSBoundParameters.Remove("Debug") | out-null
    $PSBoundParameters.Remove("Category") | out-null
    $PSBoundParameters.Remove("Password") | out-null
    $PSBoundParameters.Remove("SecurePassword") | out-null

    $attributes_desired = $PSBoundParameters

    $bool = $true

    foreach ($config_att in  $PSBoundParameters.GetEnumerator())
    {
        if ($Get.ContainsKey($config_att.Key)) {
            $currentvalue = $Get[$config_att.Key]
            $currentvalue_nospace = $currentvalue -replace " ", ""
            if ($config_att.Value -ne $currentvalue_nospace){
                $bool = $false
                $drift  = "`nCurrentValue: $currentvalue_nospace`nDesiredValue: $($config_att.value)"
                $message = "Configuration is drifted in category $Category for $($config_att.Key). $drift"
                write-verbose $message
                Write-DellEventLog -Message $message -EventID 4 -EntryType Warning
            
            }
            else {
                write-Debug "Configuration is same for $config_att."
            }
    }
    else
    {
        $message = "Unsupported attribute $($config_att)"
        Write-Verbose $message
    }
   }
   return $bool

}


Export-ModuleMember -Function *-TargetResource


# SIG # Begin signature block
# MIIkoQYJKoZIhvcNAQcCoIIkkjCCJI4CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCAutvu2XJ+Y3i6x
# ciaLSDjNeo4h80R6JdS8+EOqCXlDw6CCExYwggXfMIIEx6ADAgECAhBOQOQ3VO3m
# jAAAAABR05R/MA0GCSqGSIb3DQEBCwUAMIG+MQswCQYDVQQGEwJVUzEWMBQGA1UE
# ChMNRW50cnVzdCwgSW5jLjEoMCYGA1UECxMfU2VlIHd3dy5lbnRydXN0Lm5ldC9s
# ZWdhbC10ZXJtczE5MDcGA1UECxMwKGMpIDIwMDkgRW50cnVzdCwgSW5jLiAtIGZv
# ciBhdXRob3JpemVkIHVzZSBvbmx5MTIwMAYDVQQDEylFbnRydXN0IFJvb3QgQ2Vy
# dGlmaWNhdGlvbiBBdXRob3JpdHkgLSBHMjAeFw0yMTA1MDcxNTQzNDVaFw0zMDEx
# MDcxNjEzNDVaMGkxCzAJBgNVBAYTAlVTMRYwFAYDVQQKDA1FbnRydXN0LCBJbmMu
# MUIwQAYDVQQDDDlFbnRydXN0IENvZGUgU2lnbmluZyBSb290IENlcnRpZmljYXRp
# b24gQXV0aG9yaXR5IC0gQ1NCUjEwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIK
# AoICAQCngY/3FEW2YkPy2K7TJV5IT1G/xX2fUBw10dZ+YSqUGW0nRqSmGl33VFFq
# gCLGqGZ1TVSDyV5oG6v2W2Swra0gvVTvRmttAudFrnX2joq5Mi6LuHccUk15iF+l
# OhjJUCyXJy2/2gB9Y3/vMuxGh2Pbmp/DWiE2e/mb1cqgbnIs/OHxnnBNCFYVb5Cr
# +0i6udfBgniFZS5/tcnA4hS3NxFBBuKK4Kj25X62eAUBw2DtTwdBLgoTSeOQm3/d
# vfqsv2RR0VybtPVc51z/O5uloBrXfQmywrf/bhy8yH3m6Sv8crMU6UpVEoScRCV1
# HfYq8E+lID1oJethl3wP5bY9867DwRG8G47M4EcwXkIAhnHjWKwGymUfe5SmS1dn
# DH5erXhnW1XjXuvH2OxMbobL89z4n4eqclgSD32m+PhCOTs8LOQyTUmM4OEAwjig
# nPqEPkHcblauxhpb9GdoBQHNG7+uh7ydU/Yu6LZr5JnexU+HWKjSZR7IH9Vybu5Z
# HFc7CXKd18q3kMbNe0WSkUIDTH0/yvKquMIOhvMQn0YupGaGaFpoGHApOBGAYGuK
# Q6NzbOOzazf/5p1nAZKG3y9I0ftQYNVc/iHTAUJj/u9wtBfAj6ju08FLXxLq/f0u
# DodEYOOp9MIYo+P9zgyEIg3zp3jak/PbOM+5LzPG/wc8Xr5F0wIDAQABo4IBKzCC
# AScwDgYDVR0PAQH/BAQDAgGGMBIGA1UdEwEB/wQIMAYBAf8CAQEwHQYDVR0lBBYw
# FAYIKwYBBQUHAwMGCCsGAQUFBwMIMDsGA1UdIAQ0MDIwMAYEVR0gADAoMCYGCCsG
# AQUFBwIBFhpodHRwOi8vd3d3LmVudHJ1c3QubmV0L3JwYTAzBggrBgEFBQcBAQQn
# MCUwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3NwLmVudHJ1c3QubmV0MDAGA1UdHwQp
# MCcwJaAjoCGGH2h0dHA6Ly9jcmwuZW50cnVzdC5uZXQvZzJjYS5jcmwwHQYDVR0O
# BBYEFIK61j2Xzp/PceiSN6/9s7VpNVfPMB8GA1UdIwQYMBaAFGpyJnrQHu995ztp
# UdRsjZ+QEmarMA0GCSqGSIb3DQEBCwUAA4IBAQAfXkEEtoNwJFMsVXMdZTrA7LR7
# BJheWTgTCaRZlEJeUL9PbG4lIJCTWEAN9Rm0Yu4kXsIBWBUCHRAJb6jU+5J+Nzg+
# LxR9jx1DNmSzZhNfFMylcfdbIUvGl77clfxwfREc0yHd0CQ5KcX+Chqlz3t57jpv
# 3ty/6RHdFoMI0yyNf02oFHkvBWFSOOtg8xRofcuyiq3AlFzkJg4sit1Gw87kVlHF
# VuOFuE2bRXKLB/GK+0m4X9HyloFdaVIk8Qgj0tYjD+uL136LwZNr+vFie1jpUJuX
# bheIDeHGQ5jXgWG2hZ1H7LGerj8gO0Od2KIc4NR8CMKvdgb4YmZ6tvf6yK81MIIG
# gzCCBGugAwIBAgIQNa+3e500H2r8j4RGqzE1KzANBgkqhkiG9w0BAQ0FADBpMQsw
# CQYDVQQGEwJVUzEWMBQGA1UECgwNRW50cnVzdCwgSW5jLjFCMEAGA1UEAww5RW50
# cnVzdCBDb2RlIFNpZ25pbmcgUm9vdCBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSAt
# IENTQlIxMB4XDTIxMDUwNzE5MTk1MloXDTQwMTIyOTIzNTkwMFowYzELMAkGA1UE
# BhMCVVMxFjAUBgNVBAoTDUVudHJ1c3QsIEluYy4xPDA6BgNVBAMTM0VudHJ1c3Qg
# RXh0ZW5kZWQgVmFsaWRhdGlvbiBDb2RlIFNpZ25pbmcgQ0EgLSBFVkNTMjCCAiIw
# DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAL69pznJpX3sXWXx9Cuph9DnrRrF
# GjsYzuGhUY1y+s5YH1y4JEIPRtUxl9BKTeObMMm6l6ic/kU2zyeA53u4bsEkt9+n
# dNyF8qMkWEXMlJQ7AuvEjXxG9VxmguOkwdMfrG4MUyMO1Dr62kLxg1RfNTJW8rV4
# m1cASB6pYWEnDnMDQ7bWcJL71IWaMMaz5ppeS+8dKthmqxZG/wvYD6aJSgJRV0E8
# QThOl8dRMm1njmahXk2fNSKv1Wq3f0BfaDXMafrxBfDqhabqMoXLwcHKg2lFSQbc
# CWy6SWUZjPm3NyeMZJ414+Xs5wegnahyvG+FOiymFk49nM8I5oL1RH0owL2JrWwv
# 3C94eRHXHHBL3Z0ITF4u+o29p91j9n/wUjGEbjrY2VyFRJ5jBmnQhlh4iZuHu1gc
# pChsxv5pCpwerBFgal7JaWUu7UMtafF4tzstNfKqT+If4wFvkEaq1agNBFegtKzj
# bb2dGyiAJ0bH2qpnlfHRh3vHyCXphAyPiTbSvjPhhcAz1aA8GYuvOPLlk4C/xsOr
# e5PEPZ257kV2wNRobzBePLQ2+ddFQuASBoDbpSH85wV6KI20jmB798i1SkesFGaX
# oFppcjFXa1OEzWG6cwcVcDt7AfynP4wtPYeM+wjX5S8Xg36Cq08J8inhflV3ZZQF
# HVnUCt2TfuMUXeK7AgMBAAGjggErMIIBJzASBgNVHRMBAf8ECDAGAQH/AgEAMB0G
# A1UdDgQWBBTOiU+CUaoVooRiyjEjYdJh+/j+eDAfBgNVHSMEGDAWgBSCutY9l86f
# z3Hokjev/bO1aTVXzzAzBggrBgEFBQcBAQQnMCUwIwYIKwYBBQUHMAGGF2h0dHA6
# Ly9vY3NwLmVudHJ1c3QubmV0MDEGA1UdHwQqMCgwJqAkoCKGIGh0dHA6Ly9jcmwu
# ZW50cnVzdC5uZXQvY3NicjEuY3JsMA4GA1UdDwEB/wQEAwIBhjATBgNVHSUEDDAK
# BggrBgEFBQcDAzBEBgNVHSAEPTA7MDAGBFUdIAAwKDAmBggrBgEFBQcCARYaaHR0
# cDovL3d3dy5lbnRydXN0Lm5ldC9ycGEwBwYFZ4EMAQMwDQYJKoZIhvcNAQENBQAD
# ggIBAD4AVLgq849mr2EWxFiTZPRBi2RVjRs1M6GbkdirRsqrX7y+fnDk0tcHqJYH
# 14bRVwoI0NB4Tfgq37IE85rh13zwwQB6wUCh34qMt8u0HQFh8piapt24gwXKqSwW
# 3JwtDv6nl+RQqZeVwUsqjFHjxALga3w1TVO8S5QTi1MYFl6mCqe4NMFssess5DF9
# DCzGfOGkVugtdtWyE3XqgwCuAHfGb6k97mMUgVAW/FtPEhkOWw+N6kvOBkyJS64g
# zI5HpnXWZe4vMOhdNI8fgk1cQqbyFExQIJwJonQkXDnYiTKFPK+M5Wqe5gQ6pRP/
# qh3NR0suAgW0ao/rhU+B7wrbfZ8pj6XCP1I4UkGVO7w+W1QwQiMJY95QjYk1Rfqr
# uA+Poq17ehGT8Y8ohHtoeUdq6GQpTR/0HS9tHsiUhjzTWpl6a3yrNfcrOUtPuT8W
# ku8pjI2rrAEazHFEOctAPiASzghw40f+3IDXCADRC2rqIbV5ZhfpaqpW3c0VeLED
# wBStPkcYde0KU0syk83/gLGQ1hPl5EF4Iu1BguUO37DOlSFF5osB0xn39CtVrNlW
# c2MQ4LigbctUlpigmSFRBqqmDDorY8t52kO50hLM3o9VeukJ8+Ka0yXBezaS2uDl
# UmfN4+ZUCqWd1HOj0y9dBmSFA3d/YNjCvHTJlZFot7d+YRl1MIIGqDCCBJCgAwIB
# AgIQAe4UxLGsyd7P5PzHxoWYOTANBgkqhkiG9w0BAQsFADBjMQswCQYDVQQGEwJV
# UzEWMBQGA1UEChMNRW50cnVzdCwgSW5jLjE8MDoGA1UEAxMzRW50cnVzdCBFeHRl
# bmRlZCBWYWxpZGF0aW9uIENvZGUgU2lnbmluZyBDQSAtIEVWQ1MyMB4XDTIxMTEx
# ODIzMDczOVoXDTIyMTIxMjIzMDczOVowgdgxCzAJBgNVBAYTAlVTMQ4wDAYDVQQI
# EwVUZXhhczETMBEGA1UEBxMKUm91bmQgUm9jazETMBEGCysGAQQBgjc8AgEDEwJV
# UzEZMBcGCysGAQQBgjc8AgECEwhEZWxhd2FyZTERMA8GA1UEChMIRGVsbCBJbmMx
# HTAbBgNVBA8TFFByaXZhdGUgT3JnYW5pemF0aW9uMR0wGwYDVQQLExRDbGllbnQg
# UHJvZHVjdCBHcm91cDEQMA4GA1UEBRMHMjE0MTU0MTERMA8GA1UEAxMIRGVsbCBJ
# bmMwggGiMA0GCSqGSIb3DQEBAQUAA4IBjwAwggGKAoIBgQCcnoY5qeZB6eKg6TA0
# u4F4EOiljq6evB9RAQVNoxAiM/LCe2DdMC6NJZ65D+NvuoqdJOwFfFF4XsDZ1Ejt
# GIKSkFWi4UrgdG/VAh8QUru2zJc7Loun9WlgixCc3+umiC+BepYwkzRwCA6fnXDd
# pn7leFV6+hfTZxLZ+3FM+apPHrCA06ediV7TTqE2D+8OiO2ltOzTMGBSIFd+6QS3
# 9yqKiEFgU6Fj/XrZ/daJ7M3Y9E1HJGcmKB5I+7tO7WMcFXElJiCkXt8MJiKZWf9v
# sQUwz95YEwFHyQq28CIqSwhzTsu1RTr2ntYztWusyggBmeRMOZbpBCPwov/uH3Qg
# p3fss43WHpTOvrrOxy/aNi3l4wiAzE76I/Ormena6Q5KeDDRspg39LMopZqujyB3
# 0n1+MLt7AT+Rn/Wo8QEWmHWTPKxNgDLLGzmUdtwfNgkkBuh9d7QM4RQVm97Q/yCI
# OrVDpGpJic3WcgiWoeBNYGHjml0FQC0Y3wkmgOgUND7xL5ECAwEAAaOCAWAwggFc
# MAwGA1UdEwEB/wQCMAAwHQYDVR0OBBYEFLo0bmGFz/lpCSH/8Bb/n9HscUq3MB8G
# A1UdIwQYMBaAFM6JT4JRqhWihGLKMSNh0mH7+P54MGcGCCsGAQUFBwEBBFswWTAj
# BggrBgEFBQcwAYYXaHR0cDovL29jc3AuZW50cnVzdC5uZXQwMgYIKwYBBQUHMAKG
# Jmh0dHA6Ly9haWEuZW50cnVzdC5uZXQvZXZjczItY2hhaW4ucDdjMDEGA1UdHwQq
# MCgwJqAkoCKGIGh0dHA6Ly9jcmwuZW50cnVzdC5uZXQvZXZjczIuY3JsMA4GA1Ud
# DwEB/wQEAwIHgDATBgNVHSUEDDAKBggrBgEFBQcDAzBLBgNVHSAERDBCMDcGCmCG
# SAGG+mwKAQIwKTAnBggrBgEFBQcCARYbaHR0cHM6Ly93d3cuZW50cnVzdC5uZXQv
# cnBhMAcGBWeBDAEDMA0GCSqGSIb3DQEBCwUAA4ICAQCeCAC5jie90k3LIkOSD8lh
# F5ljcQDkp7HGkCvIVqNJ0hLHoLTubqURUWOBh0XVln6oGG80NVLVz/NqW4kGpLoC
# ntX/BGb68IbyyEh/uA2ODqRkFfnHhOqtoBlfn6A02/1GbW8Gjuc90MsK89ANVUyo
# g9l4DG+jjVjWpsRu21YypDNwnuHTzjbvl1E85zNDUJgq1P/9lxwvXr/DKQgwHsQs
# /7bflgYQsf2BS0aj1mDvnqUmFOVR6lEdbnxYo2cEmw3Uvx+Zd3oAkP+Cd8uxDn4b
# h+9DhnL+D7NNzbgAnDwB5RAiHp4yCIvHwHE+IZhUEGWLSqph81+oUUDwaeOohdMf
# NA3ZJYd8aSDgldapLuG3kfP91eMDu59AWtdFW1JZ0tGr8I24+LS4NeD6dsdb7RUj
# Z8VsK8S5VDKYyHzxQPYFI78w8wjIKZ9d1M7BrRiQMhg3U3gP9kj4GRVWIjJyxqPx
# JXahtIULNreCnfZzMi0w3QcLt1KwH4hYYQ9sO2EZYOUoZ4wWVodb5NQiM5Ksjmli
# 8262L7zhW5fb9LIzlvNf10z9Ab8nf+QN6dMWqydnHmB0kL6H1i515cE3cmBDo+b2
# QKQFbpI5d2AilrbsD3s9OD2siDrmTj+aFsZ3h/OZB2xiYkewm0QTpFDG5q715634
# kdBK9cjmdy5Y5OJ8+LSZkzGCEOEwghDdAgEBMHcwYzELMAkGA1UEBhMCVVMxFjAU
# BgNVBAoTDUVudHJ1c3QsIEluYy4xPDA6BgNVBAMTM0VudHJ1c3QgRXh0ZW5kZWQg
# VmFsaWRhdGlvbiBDb2RlIFNpZ25pbmcgQ0EgLSBFVkNTMgIQAe4UxLGsyd7P5PzH
# xoWYOTANBglghkgBZQMEAgEFAKB8MBAGCisGAQQBgjcCAQwxAjAAMBkGCSqGSIb3
# DQEJAzEMBgorBgEEAYI3AgEEMBwGCisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEV
# MC8GCSqGSIb3DQEJBDEiBCASvqCdxxtKUE65VxM0pp9z7+wV8cZ+3nGqCDFk2wRB
# pDANBgkqhkiG9w0BAQEFAASCAYBHPhOo1YhgSCW8vNq+Qbde2VABqKqNEI7JNcoW
# Ot1oWn3Pot2WnYvA+kpnYK+VB1hfK/EUArVDSz4vvpagJziP9dx894xv4JgUPZV0
# 9R6fAI4rFK/4/tqEK7c1Z1KFD+MK2Txvt0Jk56FGTfrHcsqPcM8r13Vl/VQ4e2f8
# yDrNylEFceaoqhDy+8uGq4jx8L8Q+M9KrwieMIleExUuYZH6MykzR8hUsh/zgl/o
# yjKkt/WbBF79XNRA2uIt3xY1f7KqB4TMfOa8uP8qq7jx/OARrOcwMB6JAx0/kpMo
# qOv0L8Q0JAzM3B2SqJJpRxiQVh5cjXO21MNkGppzInpBe+kdjlwvYfc0tfSuazSa
# cl5RtQKSIs7o/FVYQ+dK06cFnbaRwbHFnj+2aZ21gYOzzGQ+FBM9H7LawTbKYl5+
# ZOX5g2nbj3t7oR0dM3J6XML1Ql4pswizKoQFclJsEVsIJ9gAX/bfqJKbdCtGQGb/
# 0nrGpPT4ca3FAQ+LoAzLpGoNdd6hgg49MIIOOQYKKwYBBAGCNwMDATGCDikwgg4l
# BgkqhkiG9w0BBwKggg4WMIIOEgIBAzENMAsGCWCGSAFlAwQCATCCAQ8GCyqGSIb3
# DQEJEAEEoIH/BIH8MIH5AgEBBgtghkgBhvhFAQcXAzAxMA0GCWCGSAFlAwQCAQUA
# BCCKy60+iJnMJmYivs5acOVPcHg18CI2W6RRulPYSzdFggIVAIZOEKgyzn77irR0
# 1qLHzJMf6qoBGA8yMDIyMDkyOTEwNDI1NlowAwIBHqCBhqSBgzCBgDELMAkGA1UE
# BhMCVVMxHTAbBgNVBAoTFFN5bWFudGVjIENvcnBvcmF0aW9uMR8wHQYDVQQLExZT
# eW1hbnRlYyBUcnVzdCBOZXR3b3JrMTEwLwYDVQQDEyhTeW1hbnRlYyBTSEEyNTYg
# VGltZVN0YW1waW5nIFNpZ25lciAtIEczoIIKizCCBTgwggQgoAMCAQICEHsFsdRJ
# aFFE98mJ0pwZnRIwDQYJKoZIhvcNAQELBQAwgb0xCzAJBgNVBAYTAlVTMRcwFQYD
# VQQKEw5WZXJpU2lnbiwgSW5jLjEfMB0GA1UECxMWVmVyaVNpZ24gVHJ1c3QgTmV0
# d29yazE6MDgGA1UECxMxKGMpIDIwMDggVmVyaVNpZ24sIEluYy4gLSBGb3IgYXV0
# aG9yaXplZCB1c2Ugb25seTE4MDYGA1UEAxMvVmVyaVNpZ24gVW5pdmVyc2FsIFJv
# b3QgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkwHhcNMTYwMTEyMDAwMDAwWhcNMzEw
# MTExMjM1OTU5WjB3MQswCQYDVQQGEwJVUzEdMBsGA1UEChMUU3ltYW50ZWMgQ29y
# cG9yYXRpb24xHzAdBgNVBAsTFlN5bWFudGVjIFRydXN0IE5ldHdvcmsxKDAmBgNV
# BAMTH1N5bWFudGVjIFNIQTI1NiBUaW1lU3RhbXBpbmcgQ0EwggEiMA0GCSqGSIb3
# DQEBAQUAA4IBDwAwggEKAoIBAQC7WZ1ZVU+djHJdGoGi61XzsAGtPHGsMo8Fa4aa
# JwAyl2pNyWQUSym7wtkpuS7sY7Phzz8LVpD4Yht+66YH4t5/Xm1AONSRBudBfHkc
# y8utG7/YlZHz8O5s+K2WOS5/wSe4eDnFhKXt7a+Hjs6Nx23q0pi1Oh8eOZ3D9Jqo
# 9IThxNF8ccYGKbQ/5IMNJsN7CD5N+Qq3M0n/yjvU9bKbS+GImRr1wOkzFNbfx4Db
# ke7+vJJXcnf0zajM/gn1kze+lYhqxdz0sUvUzugJkV+1hHk1inisGTKPI8EyQRtZ
# Dqk+scz51ivvt9jk1R1tETqS9pPJnONI7rtTDtQ2l4Z4xaE3AgMBAAGjggF3MIIB
# czAOBgNVHQ8BAf8EBAMCAQYwEgYDVR0TAQH/BAgwBgEB/wIBADBmBgNVHSAEXzBd
# MFsGC2CGSAGG+EUBBxcDMEwwIwYIKwYBBQUHAgEWF2h0dHBzOi8vZC5zeW1jYi5j
# b20vY3BzMCUGCCsGAQUFBwICMBkaF2h0dHBzOi8vZC5zeW1jYi5jb20vcnBhMC4G
# CCsGAQUFBwEBBCIwIDAeBggrBgEFBQcwAYYSaHR0cDovL3Muc3ltY2QuY29tMDYG
# A1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9zLnN5bWNiLmNvbS91bml2ZXJzYWwtcm9v
# dC5jcmwwEwYDVR0lBAwwCgYIKwYBBQUHAwgwKAYDVR0RBCEwH6QdMBsxGTAXBgNV
# BAMTEFRpbWVTdGFtcC0yMDQ4LTMwHQYDVR0OBBYEFK9j1sqjToVy4Ke8QfMpojh/
# gHViMB8GA1UdIwQYMBaAFLZ3+mlIR59TEtXC6gcydgfRlwcZMA0GCSqGSIb3DQEB
# CwUAA4IBAQB16rAt1TQZXDJF/g7h1E+meMFv1+rd3E/zociBiPenjxXmQCmt5l30
# otlWZIRxMCrdHmEXZiBWBpgZjV1x8viXvAn9HJFHyeLojQP7zJAv1gpsTjPs1rST
# yEyQY0g5QCHE3dZuiZg8tZiX6KkGtwnJj1NXQZAv4R5NTtzKEHhsQm7wtsX4YVxS
# 9U72a433Snq+8839A9fZ9gOoD+NT9wp17MZ1LqpmhQSZt/gGV+HGDvbor9rsmxgf
# qrnjOgC/zoqUywHbnsc4uw9Sq9HjlANgCk2g/idtFDL8P5dA4b+ZidvkORS92uTT
# w+orWrOVWFUEfcea7CMDjYUq0v+uqWGBMIIFSzCCBDOgAwIBAgIQe9Tlr7rMBz+h
# ASMEIkFNEjANBgkqhkiG9w0BAQsFADB3MQswCQYDVQQGEwJVUzEdMBsGA1UEChMU
# U3ltYW50ZWMgQ29ycG9yYXRpb24xHzAdBgNVBAsTFlN5bWFudGVjIFRydXN0IE5l
# dHdvcmsxKDAmBgNVBAMTH1N5bWFudGVjIFNIQTI1NiBUaW1lU3RhbXBpbmcgQ0Ew
# HhcNMTcxMjIzMDAwMDAwWhcNMjkwMzIyMjM1OTU5WjCBgDELMAkGA1UEBhMCVVMx
# HTAbBgNVBAoTFFN5bWFudGVjIENvcnBvcmF0aW9uMR8wHQYDVQQLExZTeW1hbnRl
# YyBUcnVzdCBOZXR3b3JrMTEwLwYDVQQDEyhTeW1hbnRlYyBTSEEyNTYgVGltZVN0
# YW1waW5nIFNpZ25lciAtIEczMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
# AQEArw6Kqvjcv2l7VBdxRwm9jTyB+HQVd2eQnP3eTgKeS3b25TY+ZdUkIG0w+d0d
# g+k/J0ozTm0WiuSNQI0iqr6nCxvSB7Y8tRokKPgbclE9yAmIJgg6+fpDI3VHcAyz
# X1uPCB1ySFdlTa8CPED39N0yOJM/5Sym81kjy4DeE035EMmqChhsVWFX0fECLMS1
# q/JsI9KfDQ8ZbK2FYmn9ToXBilIxq1vYyXRS41dsIr9Vf2/KBqs/SrcidmXs7Dby
# lpWBJiz9u5iqATjTryVAmwlT8ClXhVhe6oVIQSGH5d600yaye0BTWHmOUjEGTZQD
# RcTOPAPstwDyOiLFtG/l77CKmwIDAQABo4IBxzCCAcMwDAYDVR0TAQH/BAIwADBm
# BgNVHSAEXzBdMFsGC2CGSAGG+EUBBxcDMEwwIwYIKwYBBQUHAgEWF2h0dHBzOi8v
# ZC5zeW1jYi5jb20vY3BzMCUGCCsGAQUFBwICMBkaF2h0dHBzOi8vZC5zeW1jYi5j
# b20vcnBhMEAGA1UdHwQ5MDcwNaAzoDGGL2h0dHA6Ly90cy1jcmwud3Muc3ltYW50
# ZWMuY29tL3NoYTI1Ni10c3MtY2EuY3JsMBYGA1UdJQEB/wQMMAoGCCsGAQUFBwMI
# MA4GA1UdDwEB/wQEAwIHgDB3BggrBgEFBQcBAQRrMGkwKgYIKwYBBQUHMAGGHmh0
# dHA6Ly90cy1vY3NwLndzLnN5bWFudGVjLmNvbTA7BggrBgEFBQcwAoYvaHR0cDov
# L3RzLWFpYS53cy5zeW1hbnRlYy5jb20vc2hhMjU2LXRzcy1jYS5jZXIwKAYDVR0R
# BCEwH6QdMBsxGTAXBgNVBAMTEFRpbWVTdGFtcC0yMDQ4LTYwHQYDVR0OBBYEFKUT
# AamfhcwbbhYeXzsxqnk2AHsdMB8GA1UdIwQYMBaAFK9j1sqjToVy4Ke8QfMpojh/
# gHViMA0GCSqGSIb3DQEBCwUAA4IBAQBGnq/wuKJfoplIz6gnSyHNsrmmcnBjL+NV
# KXs5Rk7nfmUGWIu8V4qSDQjYELo2JPoKe/s702K/SpQV5oLbilRt/yj+Z89xP+Yz
# CdmiWRD0Hkr+Zcze1GvjUil1AEorpczLm+ipTfe0F1mSQcO3P4bm9sB/RDxGXBda
# 46Q71Wkm1SF94YBnfmKst04uFZrlnCOvWxHqcalB+Q15OKmhDc+0sdo+mnrHIsV0
# zd9HCYbE/JElshuW6YUI6N3qdGBuYKVWeg3IRFjc5vlIFJ7lv94AvXexmBRyFCTf
# xxEsHwA/w0sUxmcczB4Go5BfXFSLPuMzW4IPxbeGAk5xn+lmRT92MYICWjCCAlYC
# AQEwgYswdzELMAkGA1UEBhMCVVMxHTAbBgNVBAoTFFN5bWFudGVjIENvcnBvcmF0
# aW9uMR8wHQYDVQQLExZTeW1hbnRlYyBUcnVzdCBOZXR3b3JrMSgwJgYDVQQDEx9T
# eW1hbnRlYyBTSEEyNTYgVGltZVN0YW1waW5nIENBAhB71OWvuswHP6EBIwQiQU0S
# MAsGCWCGSAFlAwQCAaCBpDAaBgkqhkiG9w0BCQMxDQYLKoZIhvcNAQkQAQQwHAYJ
# KoZIhvcNAQkFMQ8XDTIyMDkyOTEwNDI1NlowLwYJKoZIhvcNAQkEMSIEIGXjlcB3
# JVZdz1rbK1IMIlwbm69/wWpoGkfr0973MVP/MDcGCyqGSIb3DQEJEAIvMSgwJjAk
# MCIEIMR0znYAfQI5Tg2l5N58FMaA+eKCATz+9lPvXbcf32H4MAsGCSqGSIb3DQEB
# AQSCAQAfknTWz9I4kCEKfU/WQPz1bPQOJ3XGs043ke6a474se9lES776reXaGG1g
# 9ZCWwe4+q/0eNBjM+X4PdXnTzg7K861bUrHHk9jrT8uNu3wKyuVz6YOZokSOtDSr
# 0TSrgHwikSpuNC3LtrrNZYaE032Gkpg+qbTloNALgjz1XjYr6oRcInbUdHtSVkid
# lim5VNAsWuILNHqtsSQsdL+01n0Jw7C0MOjHP8KxXJUf7O2axkwU4C4RxfKTH949
# ZqnReEwp+5c0dv8+j1wtDKwcRyO7Qh8QnbTdDpoGNvQc1aqjS73sELqa5RxnDd9Y
# RNjTzO6/Kw+jlWSD3ZHjs6OCR0nQ
# SIG # End signature block
