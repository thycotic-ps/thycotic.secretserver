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
    https://docs.thycotic.com/ss/10.9.0/api-scripting/sdk-cli/index.md#task_1__configuring_secret_server
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

        # Config path for the key/config files, no folder names with spaces allowed
        [Parameter(Mandatory, ParameterSetName = 'init')]
        [ValidateScript( { Test-Path $_ -PathType Container })]
        [ValidateScript( { $_ -notmatch '\s' })]
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
            $tssRemoveArgs = "remove --confirm --key-directory $ConfigPath --config-directory $ConfigPath"
            Write-Verbose "arguments for tss init: $tssRemoveArgs"
            try {
                $tssRmInfo = New-Object System.Diagnostics.ProcessStartInfo
                $tssRmInfo.FileName = $tssExe
                $tssRmInfo.Arguments = $tssRemoveArgs
                $tssRmInfo.RedirectStandardError = $true
                $tssRmInfo.RedirectStandardOutput = $true
                $tssRmInfo.UseShellExecute = $false
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
                    Write-Waring "Issue removing configuration files for [$SecretServer]: $tssRmProcessOutput"
                    return
                }
            } catch {
                Write-Warning "Issue removing SDK Client (tss) config files for [$SecretServer]"
                $err = $_
                . $ErrorHandling $err
            }
        }

        $tssArgs = [ordered]@{}
        switch ($tssParams.Keys) {
            'SecretServer' { $tssArgs.SecretServer = "--url $SecretServer" }
            'RuleName' { $tssArgs.RuleName = "--rule-name $RuleName" }
            'OnboardingKey' { $tssArgs.OnboardingKey = "--onboarding-key $OnboardingKey" }
            'ConfigPath' { $tssArgs.ConfigDirectory = "--key-directory $ConfigPath --config-directory $ConfigPath" }
        }

        $tssInitArgs = "init $($tssArgs['SecretServer']) $($tssArgs['RuleName']) $($tssArgs['OnboardingKey']) $($tssArgs['ConfigDirectory'])"
        Write-Verbose "arguments for tss init: $tssInitArgs"
        try {
            $tssInitInfo = New-Object System.Diagnostics.ProcessStartInfo
            $tssInitInfo.FileName = $tssExe
            $tssInitInfo.Arguments = $tssInitArgs
            $tssInitInfo.RedirectStandardError = $true
            $tssInitInfo.RedirectStandardOutput = $true
            $tssInitInfo.UseShellExecute = $false
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
