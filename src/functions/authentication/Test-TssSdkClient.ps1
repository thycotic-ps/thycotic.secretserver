function Test-TssSdkClient {
    <#
    .SYNOPSIS
    Test the SDK Client configuration based on the ConfigPath

    .DESCRIPTION
    Test the SDK Client configuration based on the ConfigPath.
    Based on status message returned:
    - "Connected to endpoint <Secret Server URL>" = true
    - "Not connected" = false

    .EXAMPLE
    Test-TssSdkClient -SecretServer 'http://alpha.local/SecretServer' -RuleName tss_module -ConfigPath $env:HOME

    On Ubuntu 20.04 client, will test SDK Client configuration and return true if connected

    .EXAMPLE
    Test-TssSdkClient -SecretServer 'http://alpha.local/SecretServer' -RuleName tss_module -ConfigPath c:\thycotic -Force

    Tests SDK Client configuration and return true if connected

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/authentication/Test-TssSdkClient

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/authentication/Test-TssSdkClient.ps1

    .NOTES
    Secret Server docs cover configuring Application Account and SDK Client rule
    https://docs.thycotic.com/ss/10.9.0/api-scripting/sdk-cli/index.md#task_1__configuring_secret_server
    #>
    [cmdletbinding()]
    [OutputType('System.Boolean')]
    param(
        # Secret Server
        [Parameter(Mandatory)]
        [string]
        $SecretServer,

        # Config path for the key/config files, no folder names with spaces allowed
        [Parameter(Mandatory)]
        [ValidateScript( { Test-Path $_ -PathType Container })]
        [ValidateScript( { $_ -notmatch '\s' })]
        [string]
        $ConfigPath
    )
    begin {
        $tssExe = [IO.Path]::Combine($clientSdkPath, 'tss.exe')

        if ($IsLinux) {
            Write-Verbose 'SDK Client, tss utility, has some dependencies required on certain Linux distributions, more details: https://docs.thycotic.com/ss/10.9.0/api-scripting/sdk-cli#task_2__installing_the_sdk_client'
        }
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation

        $tssArgs = [ordered]@{}
        $tssArgs.ConfigDirectory = "--key-directory $ConfigPath --config-directory $ConfigPath"

        $tssStatusArgs = "status $($tssArgs['ConfigDirectory'])"
        Write-Verbose "arguments for tss status: $tssStatusArgs"
        try {
            $tssInitInfo = New-Object System.Diagnostics.ProcessStartInfo
            $tssInitInfo.FileName = $tssExe
            $tssInitInfo.Arguments = $tssStatusArgs
            $tssInitInfo.RedirectStandardError = $true
            $tssInitInfo.RedirectStandardOutput = $true
            $tssInitInfo.UseShellExecute = $false
            $tssProcess = New-Object System.Diagnostics.Process
            $tssProcess.StartInfo = $tssInitInfo
            $tssProcess.Start() | Out-Null
            $tssProcess.WaitForExit()
            $tssStatusOutput = $tssProcess.StandardOutput.ReadToEnd()
            $tssStatusOutput += $tssProcess.StandardError.ReadToEnd()

            Write-Verbose "SDK Client raw output: $tssStatusOutput"
            if ($tssStatusOutput -match "Connected to endpoint") {
                if ($tssStatusOutput -match $SecretServer) {
                    return $true
                } else {
                    return $false
                }
            } else {
                if ($tssStatusOutput -match 'Not connected') {
                    return $false
                } else {
                    return $false
                }
            }
        } catch {
            Write-Warning "Issue checking status of SDK Client (tss) for [$SecretServer]"
            Write-Error $_
            $err = $_
            . $ErrorHandling $err
        }
    }
}