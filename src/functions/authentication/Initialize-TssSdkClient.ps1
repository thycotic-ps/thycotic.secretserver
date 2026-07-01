function Initialize-TssSdkClient {
    <#
    .SYNOPSIS
    Initialize SDK Client for the module

    .DESCRIPTION
    Initialize SDK Client for the module to utilize token request using machine authentication via SDK Client Management feature in Secret Server (see notes section)
    See help for New-TssSession using the associated UseSdkClient/ConfigPath parameters

    .EXAMPLE
    Initialize-TssSdkClient -SecretServer 'http://alpha.local/SecretServer' -RuleName tss_module -ConfigPath $env:HOME

    On Ubuntu 20.04 client, initialize SDK Client saving the configuration files in the user's HOME path

    .EXAMPLE
    Initialize-TssSdkClient -SecretServer 'http://alpha.local/SecretServer' -RuleName tss_module -ConfigPath c:\thycotic -Force

    Initializes SDK Client saving the configuration files to c:\thycotic, with Force provided configuration will drop current configs (if exist) and recreate

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/authentication/Initialize-TssSdkClient

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/authentication/Initialize-TssSdkClient.ps1

    .NOTES
    Secret Server docs cover configuring Application Account and SDK Client rule
    https://docs.delinea.com/online-help/secret-server/api-scripting/sdk-cli/index.htm#Task1ConfiguringSecretServer
    #>
    [cmdletbinding()]
    param(
        # Secret Server
        [Parameter(Mandatory, ParameterSetName = 'init')]
        [string]
        $SecretServer,

        # SDK Client Management rule name
        [Parameter(Mandatory, ParameterSetName = 'init')]
        [string]
        $RuleName,

        # SDK Client Management rule onboarding key
        [Parameter(ParameterSetName = 'init')]
        [string]
        $OnboardingKey,

        # Config path for the key/config files
        [Parameter(Mandatory, ParameterSetName = 'init')]
        [ValidateScript( { Test-Path $_ -PathType Container })]
        [string]
        $ConfigPath,

        # Overwrite configuration (drop and create a new)
        [switch]
        $Force
    )
    begin {
        $tssParams = $PSBoundParameters
        $tssExe = [IO.Path]::Combine($clientSdkPath, 'tss.exe')

        if ($IsLinux) {
            Write-Verbose 'SDK Client, tss utility, has some dependencies required on certain Linux distributions, more details: https://docs.thycotic.com/ss/10.9.0/api-scripting/sdk-cli#task_2__installing_the_sdk_client'
        }
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation

        if ($tssParams.ContainsKey('Force')) {
            $tssRmInfo = New-Object System.Diagnostics.ProcessStartInfo
            $tssRmInfo.FileName = $tssExe
            $tssRmInfo.ArgumentList.Add('remove')
            $tssRmInfo.ArgumentList.Add('--confirm')
            $tssRmInfo.ArgumentList.Add('--key-directory')
            $tssRmInfo.ArgumentList.Add($ConfigPath)
            $tssRmInfo.ArgumentList.Add('--config-directory')
            $tssRmInfo.ArgumentList.Add($ConfigPath)
            $tssRmInfo.RedirectStandardError = $true
            $tssRmInfo.RedirectStandardOutput = $true
            $tssRmInfo.UseShellExecute = $false
            Write-Verbose "arguments for tss remove: $($tssRmInfo.ArgumentList -join ' ')"
            try {
                $tssRmProcess = New-Object System.Diagnostics.Process
                $tssRmProcess.StartInfo = $tssRmInfo
                $tssRmProcess.Start() | Out-Null
                $tssRmProcess.WaitForExit()
                $tssRmOutput = $tssRmProcess.StandardOutput.ReadToEnd()
                $tssRmOutput += $tssRmProcess.StandardError.ReadToEnd()

                Write-Verbose "SDK Client raw output: $tssRmOutput"
                if ($tssRmOutput -match 'Your configuration settings have been removed.') {
                    Write-Verbose 'SDK Client configuration has been removed'
                } else {
                    Write-Warning "Issue removing configuration files for [$SecretServer]: $tssRmOutput"
                    return
                }
            } catch {
                Write-Warning "Issue removing SDK Client (tss) config files for [$SecretServer]"
                $err = $_
                . $ErrorHandling $err
            }
        }

        $tssInitInfo = New-Object System.Diagnostics.ProcessStartInfo
        $tssInitInfo.FileName = $tssExe
        $tssInitInfo.ArgumentList.Add('init')
        if ($tssParams.ContainsKey('SecretServer')) {
            $tssInitInfo.ArgumentList.Add('--url')
            $tssInitInfo.ArgumentList.Add($SecretServer)
        }
        if ($tssParams.ContainsKey('RuleName')) {
            $tssInitInfo.ArgumentList.Add('--rule-name')
            $tssInitInfo.ArgumentList.Add($RuleName)
        }
        if ($tssParams.ContainsKey('OnboardingKey')) {
            $tssInitInfo.ArgumentList.Add('--onboarding-key')
            $tssInitInfo.ArgumentList.Add($OnboardingKey)
        }
        if ($tssParams.ContainsKey('ConfigPath')) {
            $tssInitInfo.ArgumentList.Add('--key-directory')
            $tssInitInfo.ArgumentList.Add($ConfigPath)
            $tssInitInfo.ArgumentList.Add('--config-directory')
            $tssInitInfo.ArgumentList.Add($ConfigPath)
        }
        $tssInitInfo.RedirectStandardError = $true
        $tssInitInfo.RedirectStandardOutput = $true
        $tssInitInfo.UseShellExecute = $false

        # Redact the value following '--onboarding-key' before writing to the verbose stream,
        # so users capturing -Verbose transcripts for support tickets don't leak the key.
        $argsForLog = @()
        for ($i = 0; $i -lt $tssInitInfo.ArgumentList.Count; $i++) {
            if ($i -gt 0 -and $tssInitInfo.ArgumentList[$i - 1] -eq '--onboarding-key') {
                $argsForLog += '***REDACTED***'
            } else {
                $argsForLog += $tssInitInfo.ArgumentList[$i]
            }
        }
        Write-Verbose "arguments for tss init: $($argsForLog -join ' ')"
        try {
            $tssProcess = New-Object System.Diagnostics.Process
            $tssProcess.StartInfo = $tssInitInfo
            $tssProcess.Start() | Out-Null
            $tssProcess.WaitForExit()
            $tssInitOutput = $tssProcess.StandardOutput.ReadToEnd()
            $tssInitOutput += $tssProcess.StandardError.ReadToEnd()

            Write-Verbose "SDK Client raw output: $tssInitOutput"
            if ($tssInitOutput -eq 'Your SDK client account registration is complete.') {
                Write-Host 'SDK Client initialization completed successfully'
            }
            if ($tssInitOutput -match 'This machine is already initialized. Remove the configuration settings.') {
                Write-Warning 'Initialization has already been run for this host, include -Force parameter if you want to drop and reinitialize'
            }
        } catch {
            Write-Warning "Issue initializing SDK Client (tss) for [$SecretServer]"
            Write-Error $_
            $err = $_
            . $ErrorHandling $err
        }
    }
}
