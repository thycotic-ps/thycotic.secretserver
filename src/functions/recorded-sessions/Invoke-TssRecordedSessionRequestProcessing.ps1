function Invoke-TssRecordedSessionRequestProcessing {
    <#
    .SYNOPSIS
    Request processing of a recorded session video

    .DESCRIPTION
    Asks Secret Server to encode or transcode the video of one or more recorded sessions now instead of waiting for the scheduled processing. Returns the processing status and the time estimate Secret Server reports.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Recorded session ID: the launcher session GUID (LauncherSessionGuid in Search-TssRecordedSession output)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Invoke-TssRecordedSessionRequestProcessing -TssSession $session -Id 0d1e5c8a-6f3b-4c2e-9a7d-3b2f1e4c5d6a

    Request processing of the video of recorded session 0d1e5c8a-6f3b-4c2e-9a7d-3b2f1e4c5d6a

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Invoke-TssRecordedSessionRequestProcessing

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Invoke-TssRecordedSessionRequestProcessing.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.RecordedSessions.ProcessingRequest')]
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
                $uri = $TssSession.ApiUrl, 'recorded-sessions', $currentId, 'request-processing' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Invoke-TssRecordedSessionRequestProcessing request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.model) {
                    [Thycotic.PowerShell.RecordedSessions.ProcessingRequest](. $FilterTssResponse $restResponse.model ([Thycotic.PowerShell.RecordedSessions.ProcessingRequest]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
