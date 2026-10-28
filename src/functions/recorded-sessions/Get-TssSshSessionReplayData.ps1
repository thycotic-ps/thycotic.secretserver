function Get-TssSshSessionReplayData {
    <#
    .SYNOPSIS
    Get the replay data of an SSH proxy session

    .DESCRIPTION
    Returns the replay data of an SSH proxy session, the JSON text the web replay viewer plays back. Secret Server returns an error for a session with no replay data.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER SecretSessionId
    Secret session ID (SecretSessionId in Search-TssRecordedSession output)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSshSessionReplayData -TssSession $session -SecretSessionId 786

    Get the replay data of SSH proxy session 786

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssSshSessionReplayData

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssSshSessionReplayData.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('System.String')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $SecretSessionId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'recorded-sessions', 'ssh-session', 'replay-data' -join '/'
            $queryParams = @()
            switch ($tssParams.Keys) {
                'SecretSessionId' {
                    $queryParams += "secretSessionId=$($SecretSessionId)"
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
                Write-Warning 'Issue with Get-TssSshSessionReplayData request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                $restResponse | ConvertFrom-Json
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
