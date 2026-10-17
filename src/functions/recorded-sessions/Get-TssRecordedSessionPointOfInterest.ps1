function Get-TssRecordedSessionPointOfInterest {
    <#
    .SYNOPSIS
    Get the points of interest of a recorded session

    .DESCRIPTION
    Returns the points of interest of one or more recorded sessions: keystrokes, applications and other activity captured during the session, with their offset from the session start.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Recorded session ID: the launcher session GUID (LauncherSessionGuid in Search-TssRecordedSession output)

    .PARAMETER SearchText
    Text to filter the SSH keystroke points of interest by. Secret Server applies it only to SSH (proxied) sessions; RDP keystroke and application points of interest are always returned unfiltered

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssRecordedSessionPointOfInterest -TssSession $session -Id 0d1e5c8a-6f3b-4c2e-9a7d-3b2f1e4c5d6a

    Get the points of interest of recorded session 0d1e5c8a-6f3b-4c2e-9a7d-3b2f1e4c5d6a

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssRecordedSessionPointOfInterest -TssSession $session -Id 0d1e5c8a-6f3b-4c2e-9a7d-3b2f1e4c5d6a -SearchText sudo

    Get the SSH keystroke points of interest of recorded session 0d1e5c8a-6f3b-4c2e-9a7d-3b2f1e4c5d6a that match sudo

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssRecordedSessionPointOfInterest

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssRecordedSessionPointOfInterest.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.RecordedSessions.PointOfInterest[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('LauncherSessionGuid')]
        [guid[]]
        $Id,

        [string]
        $SearchText
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
                $uri = $TssSession.ApiUrl, 'recorded-sessions', $currentId, 'points-of-interest' -join '/'
                $queryParams = @()
                $queryParams += "take=$($TssSession.Take)"
                switch ($tssParams.Keys) {
                    'SearchText' {
                        $queryParams += "filter.searchText=$([uri]::EscapeDataString($SearchText))"
                    }
                }
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
                    Write-Warning 'Issue with Get-TssRecordedSessionPointOfInterest request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.RecordedSessions.PointOfInterest[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.RecordedSessions.PointOfInterest]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
