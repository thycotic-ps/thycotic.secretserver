function Get-TssSshSession {
    <#
    .SYNOPSIS
    Get the data of an SSH proxy session

    .DESCRIPTION
    Returns the recorded data of an SSH proxy session: the commands and output of the session.
    Identify the session by one of SecretSessionId, SecretSessionKey, SessionGuid or AuditSecretId.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER AuditSecretId
    Secret audit record ID of the launch

    .PARAMETER ByteLimit
    Maximum number of bytes of session data to return

    .PARAMETER FilterType
    Side of the SSH transcript to return: Both, Client or Server (default Both)

    .PARAMETER SearchTerm
    Return only session data matching this text

    .PARAMETER SecretSessionId
    Secret session ID (SecretSessionId in Search-TssRecordedSession output)

    .PARAMETER SecretSessionKey
    Secret session key

    .PARAMETER SessionGuid
    Launcher session GUID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSshSession -TssSession $session -SecretSessionId 786

    Get the data of SSH proxy session 786

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSshSession -TssSession $session -SecretSessionId 786 -FilterType Client -SearchTerm sudo

    Get the client side lines of SSH proxy session 786 that match sudo

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssSshSession

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssSshSession.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.RecordedSessions.SshSession')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [int]
        $AuditSecretId,

        [long]
        $ByteLimit,

        [ValidateSet('Both', 'Client', 'Server')]
        [string]
        $FilterType,

        [string]
        $SearchTerm,

        [Parameter(ValueFromPipelineByPropertyName)]
        [int]
        $SecretSessionId,

        [string]
        $SecretSessionKey,

        [string]
        $SessionGuid
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'recorded-sessions', 'ssh-session' -join '/'
            $queryParams = @()
            switch ($tssParams.Keys) {
                'AuditSecretId' {
                    $queryParams += "auditSecretId=$($AuditSecretId)"
                }
                'ByteLimit' {
                    $queryParams += "byteLimit=$($ByteLimit)"
                }
                'FilterType' {
                    $queryParams += "filterType=$([uri]::EscapeDataString($FilterType))"
                }
                'SearchTerm' {
                    $queryParams += "searchTerm=$([uri]::EscapeDataString($SearchTerm))"
                }
                'SecretSessionId' {
                    $queryParams += "secretSessionId=$($SecretSessionId)"
                }
                'SecretSessionKey' {
                    $queryParams += "secretSessionKey=$([uri]::EscapeDataString($SecretSessionKey))"
                }
                'SessionGuid' {
                    $queryParams += "sessionGuid=$([uri]::EscapeDataString($SessionGuid))"
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
                Write-Warning 'Issue with Get-TssSshSession request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.RecordedSessions.SshSession](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.RecordedSessions.SshSession]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
