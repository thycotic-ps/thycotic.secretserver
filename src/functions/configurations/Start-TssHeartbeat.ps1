function Start-TssHeartbeat {
    <#
    .SYNOPSIS
    Run the heartbeat scheduler now

    .DESCRIPTION
    Runs the Secret Server heartbeat scheduler now, the same as Run Now on the heartbeat configuration page.
    The scheduler processes every pending heartbeat, not a single secret. To check one secret now, use Start-TssSecretHeartbeat alone: it already runs the check without waiting for the next scheduled run.
    Returns True when Secret Server accepted the request. Heartbeat must be enabled in the Secret Server configuration: while it is off, the request still returns True but no heartbeat runs.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Start-TssHeartbeat -TssSession $session

    Run the heartbeat scheduler now

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Start-TssHeartbeat

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Start-TssHeartbeat.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.Boolean')]
    param (
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
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'heartbeat', 'run-now' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($PSCmdlet.ShouldProcess("Heartbeat scheduler", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Start-TssHeartbeat request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [boolean]$restResponse.success
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
