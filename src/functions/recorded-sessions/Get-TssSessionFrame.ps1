function Get-TssSessionFrame {
    <#
    .SYNOPSIS
    Get the captured frames of a recorded session

    .DESCRIPTION
    Returns up to 1000 captured screen frames of a recorded session, oldest first, with their image ID and capture time. Pass the last image ID returned as TopImageIdRecovered to get the next frames. Use Get-TssSessionImage to download a frame.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER SecretSessionId
    Secret session ID (SecretSessionId in Search-TssRecordedSession output)

    .PARAMETER TopImageIdRecovered
    Return only frames after this image ID (default 0, from the start of the session)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSessionFrame -TssSession $session -SecretSessionId 786

    Get the first 1000 captured frames of secret session 786

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSessionFrame -TssSession $session -SecretSessionId 786 -TopImageIdRecovered 1000

    Get the next frames after image 1000

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssSessionFrame

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssSessionFrame.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.RecordedSessions.SessionFrame[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $SecretSessionId,

        [Parameter(ValueFromPipelineByPropertyName)]
        [int]
        $TopImageIdRecovered
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'recorded-sessions', 'session-frames', $SecretSessionId, $TopImageIdRecovered -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssSessionFrame request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.RecordedSessions.SessionFrame[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.RecordedSessions.SessionFrame]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
