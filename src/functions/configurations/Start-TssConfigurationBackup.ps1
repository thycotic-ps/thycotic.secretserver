function Start-TssConfigurationBackup {
    <#
    .SYNOPSIS
    Start the database and application backup for Secret Server

    .DESCRIPTION
    Start the database and application backup for Secret Server

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Start-TssConfigurationBackup -TssSession $session

    Run the backup for the Secret Server as configured

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Start-TssConfigurationBackup

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Start-TssConfigurationBackup.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'backup', 'run-now' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            if (-not $PSCmdlet.ShouldProcess("Backup", "$($invokeParams.Method) $($invokeParams.Uri)")) { return }
            Write-Verbose "Performing the operation: $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                Write-Verbose "Backup started successfully"
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}