function Set-TssSecretLauncherSession {
    <#
    .SYNOPSIS
    Act on an active secret launcher session

    .DESCRIPTION
    Terminate an active secret launcher session, limit it, or send its user a message. Identify the session by -SecretSessionId, -SecretSessionKey or -SessionGuid together with -SecretId.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Action
    Terminate, LimitSession or MessageOnly

    .PARAMETER Message
    Message shown to the session user (needed for MessageOnly)

    .PARAMETER SecretId
    Id of the secret the session belongs to

    .PARAMETER SecretSessionId
    Secret session Id

    .PARAMETER SecretSessionKey
    Secret session key

    .PARAMETER SessionGuid
    Launcher session GUID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecretLauncherSession -TssSession $session -SecretId 42 | Set-TssSecretLauncherSession -TssSession $session -Action Terminate

    Terminate every active launcher session of secret 42

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecretLauncherSession -TssSession $session -SecretId 42 -SecretSessionId 7 -Action MessageOnly -Message 'Session ends in 5 minutes'

    Send a message to the user of session 7

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Set-TssSecretLauncherSession

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Set-TssSecretLauncherSession.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Secrets.LauncherSessionActionResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [ValidateSet('Terminate', 'LimitSession', 'MessageOnly')]
        [string]
        $Action,

        [string]
        $Message,

        [Parameter(ValueFromPipelineByPropertyName)]
        [int]
        $SecretId,

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
            $uri = $TssSession.ApiUrl, 'secrets', 'launcher-sessions' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ }
            switch ($tssParams.Keys) {
                'Action' {
                    $body.Add('action', $Action)
                }
                'Message' {
                    $body.Add('message', $Message)
                }
                'SecretId' {
                    $body.Add('secretId', $SecretId)
                }
                'SecretSessionId' {
                    $body.Add('secretSessionId', $SecretSessionId)
                }
                'SecretSessionKey' {
                    $body.Add('secretSessionKey', $SecretSessionKey)
                }
                'SessionGuid' {
                    $body.Add('sessionGuid', $SessionGuid)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret launcher session", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssSecretLauncherSession request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Secrets.LauncherSessionActionResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Secrets.LauncherSessionActionResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
