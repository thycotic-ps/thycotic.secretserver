function Get-TssHeartbeatStatusOverview {
    <#
    .SYNOPSIS
    Get the heartbeat status overview

    .DESCRIPTION
    Gets the heartbeat dashboard counts: the number of heartbeat-enabled secrets in each heartbeat status, such as Success, Failed or Pending.
    Also returns the ids of the heartbeat history, pending and failed reports when the caller can view them, for use with Invoke-TssReport.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssHeartbeatStatusOverview -TssSession $session

    Get the heartbeat status counts and report ids

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssHeartbeatStatusOverview -TssSession $session).Statuses

    List the number of secrets in each heartbeat status

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Get-TssHeartbeatStatusOverview

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Get-TssHeartbeatStatusOverview.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Rpc.HeartbeatStatusOverview')]
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
            $uri = $TssSession.ApiUrl, 'remote-password-changing', 'heartbeat-status-overview' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssHeartbeatStatusOverview request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Rpc.HeartbeatStatusOverview](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Rpc.HeartbeatStatusOverview]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
