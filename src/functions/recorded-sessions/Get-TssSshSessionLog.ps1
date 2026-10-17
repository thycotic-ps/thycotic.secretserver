function Get-TssSshSessionLog {
    <#
    .SYNOPSIS
    Save the log of an SSH proxy session

    .DESCRIPTION
    Downloads the text log of an SSH proxy session to a folder and returns the saved file.
    Identify the session by one of SecretSessionId, SecretSessionKey, SessionGuid or AuditSecretId.
    The file is named SSHSessionLog-<session>.txt.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER SecretSessionId
    Secret session ID (SecretSessionId in Search-TssRecordedSession output)

    .PARAMETER SecretSessionKey
    Secret session key

    .PARAMETER SessionGuid
    Launcher session GUID

    .PARAMETER AuditSecretId
    Secret audit record ID of the launch

    .PARAMETER FilterType
    Side of the SSH transcript to save: Both, Client or Server (default Both)

    .PARAMETER SearchTerm
    Save only the lines matching this text

    .PARAMETER Output
    Folder to save the file in

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSshSessionLog -TssSession $session -SecretSessionId 786 -Output .\logs

    Saves the log of SSH proxy session 786 to the logs folder

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSshSessionLog -TssSession $session -SecretSessionId 786 -FilterType Client -Output .\logs

    Saves only the client side of SSH proxy session 786

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/recorded-sessions/Get-TssSshSessionLog

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/recorded-sessions/Get-TssSshSessionLog.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('System.IO.FileInfo')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(ValueFromPipelineByPropertyName)]
        [int]
        $SecretSessionId,

        [string]
        $SecretSessionKey,

        [string]
        $SessionGuid,

        [int]
        $AuditSecretId,

        [ValidateSet('Both', 'Client', 'Server')]
        [string]
        $FilterType,

        [string]
        $SearchTerm,

        [Parameter(Mandatory)]
        [ValidateScript( { Test-Path $_ -PathType Container })]
        [string]
        $Output
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $outputFolder = (Resolve-Path -Path $Output).ProviderPath
            $apiResponse = $null
            $uri = $TssSession.ApiUrl, 'recorded-sessions', 'ssh-session-file' -join '/'
            $queryParams = @()
            $sessionLabel = $null
            switch ($tssParams.Keys) {
                'SecretSessionId' {
                    $queryParams += "secretSessionId=$($SecretSessionId)"
                    $sessionLabel = $SecretSessionId
                }
                'SecretSessionKey' {
                    $queryParams += "secretSessionKey=$([uri]::EscapeDataString($SecretSessionKey))"
                    if (-not $sessionLabel) { $sessionLabel = $SecretSessionKey }
                }
                'SessionGuid' {
                    $queryParams += "sessionGuid=$([uri]::EscapeDataString($SessionGuid))"
                    if (-not $sessionLabel) { $sessionLabel = $SessionGuid }
                }
                'AuditSecretId' {
                    $queryParams += "auditSecretId=$($AuditSecretId)"
                    if (-not $sessionLabel) { $sessionLabel = "audit$AuditSecretId" }
                }
                'FilterType' {
                    $queryParams += "filterType=$($FilterType)"
                }
                'SearchTerm' {
                    $queryParams += "searchTerm=$([uri]::EscapeDataString($SearchTerm))"
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
                $null = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue downloading the SSH session log'
                $err = $_
                . $ErrorHandling $err
            }
            if ($apiResponse.IsSuccessful -and $apiResponse.RawBytes) {
                $fileLabel = ([string]$sessionLabel) -replace '[^A-Za-z0-9-]', '_'
                $filePath = [IO.Path]::Combine($outputFolder, "SSHSessionLog-$fileLabel.txt")
                [IO.File]::WriteAllBytes($filePath, $apiResponse.RawBytes)
                Get-Item -LiteralPath $filePath
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
