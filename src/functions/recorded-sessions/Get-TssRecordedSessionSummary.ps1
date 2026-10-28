function Get-TssRecordedSessionSummary {
    <#
    .SYNOPSIS
    Get the summary of a recorded session

    .DESCRIPTION
    Returns the summary row of one or more recorded sessions, the same shape Search-TssRecordedSession returns, looked up by launcher session GUID.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Recorded session ID: the launcher session GUID (LauncherSessionGuid in Search-TssRecordedSession output)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssRecordedSessionSummary -TssSession $session -Id 0d1e5c8a-6f3b-4c2e-9a7d-3b2f1e4c5d6a

    Get the summary of recorded session 0d1e5c8a-6f3b-4c2e-9a7d-3b2f1e4c5d6a

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssRecordedSessionSummary

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssRecordedSessionSummary.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.RecordedSessions.RecordedSessionItem')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('LauncherSessionGuid')]
        [guid[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'recorded-sessions', $currentId, 'summary' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssRecordedSessionSummary request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.RecordedSessions.RecordedSessionItem](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.RecordedSessions.RecordedSessionItem]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
