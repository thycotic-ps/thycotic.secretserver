function Get-TssRecordedSessionPointOfInterestSummary {
    <#
    .SYNOPSIS
    Get the points of interest summary of a recorded session

    .DESCRIPTION
    Returns the points of interest of one or more recorded sessions grouped by activity type, with a score and the seconds from the session start, as the session timeline shows them.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Recorded session ID: the launcher session GUID (LauncherSessionGuid in Search-TssRecordedSession output)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssRecordedSessionPointOfInterestSummary -TssSession $session -Id 0d1e5c8a-6f3b-4c2e-9a7d-3b2f1e4c5d6a

    Get the points of interest summary of recorded session 0d1e5c8a-6f3b-4c2e-9a7d-3b2f1e4c5d6a

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssRecordedSessionPointOfInterestSummary

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssRecordedSessionPointOfInterestSummary.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.RecordedSessions.PointOfInterestSummary[]')]
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
                $uri = $TssSession.ApiUrl, 'recorded-sessions', $currentId, 'points-of-interest-summary' -join '/'
                $queryParams = @()
                $queryParams += "take=$($TssSession.Take)"
                if ($queryParams) {
                    $uri = $uri, ($queryParams -join '&') -join '?'
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssRecordedSessionPointOfInterestSummary request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.RecordedSessions.PointOfInterestSummary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.RecordedSessions.PointOfInterestSummary]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
