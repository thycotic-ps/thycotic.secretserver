function Get-TssSecretSessionSummary {
    <#
    .SYNOPSIS
    Get the summary of a secret session

    .DESCRIPTION
    Returns the summary of one or more secret sessions by secret session ID: secret, user, machine, start and end time, and whether the recording can be played back.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret session ID (SecretSessionId in Search-TssRecordedSession output)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretSessionSummary -TssSession $session -Id 786

    Get the summary of secret session 786

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssRecordedSession -TssSession $session -Active | Get-TssSecretSessionSummary -TssSession $session

    Get the secret session summary of every active recorded session

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssSecretSessionSummary

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssSecretSessionSummary.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.RecordedSessions.SecretSessionSummary')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretSessionId')]
        [int[]]
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
                $uri = $TssSession.ApiUrl, 'secret-sessions', $currentId, 'summary' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssSecretSessionSummary request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.RecordedSessions.SecretSessionSummary](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.RecordedSessions.SecretSessionSummary]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
