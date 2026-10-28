function Get-TssSessionMonitoringConfiguration {
    <#
    .SYNOPSIS
    Get the Session Monitoring configuration

    .DESCRIPTION
    Returns the Session Monitoring page configuration: the default number of days the session search is bounded to.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSessionMonitoringConfiguration -TssSession $session

    Get the Session Monitoring configuration

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssSessionMonitoringConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssSessionMonitoringConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.RecordedSessions.SessionMonitoringConfiguration')]
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
            $uri = $TssSession.ApiUrl, 'recorded-sessions', 'configuration' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssSessionMonitoringConfiguration request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.RecordedSessions.SessionMonitoringConfiguration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.RecordedSessions.SessionMonitoringConfiguration]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
