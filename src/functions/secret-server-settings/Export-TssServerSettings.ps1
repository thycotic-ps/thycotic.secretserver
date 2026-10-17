function Export-TssServerSettings {
    <#
    .SYNOPSIS
    Export Secret Server settings

    .DESCRIPTION
    Exports the chosen settings sections and returns them as an object (SecretServerSettings) and as file text (ExportedSecretSettingsFileText).
    Secret Server re-checks the password of the session user (-Password) or the DoubleLock password (-DoubleLockPassword) before exporting.
    Requires the Administer Export and Administer Configuration role permissions.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Section
    Settings sections to export. Default All

    .PARAMETER Password
    Password of the session user. Secret Server checks it before exporting

    .PARAMETER DoubleLockPassword
    DoubleLock password of the session user, used instead of -Password

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $export = Export-TssServerSettings -TssSession $session -Section Email, Login -Password (Read-Host -AsSecureString)
    Set-Content -Path ./ss-settings.json -Value $export.ExportedSecretSettingsFileText

    Exports the email and login settings and saves the file text

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Export-TssServerSettings -TssSession $session -Password (Read-Host -AsSecureString)

    Exports every settings section

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-server-settings/Export-TssServerSettings

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-server-settings/Export-TssServerSettings.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'password')]
    [OutputType('Thycotic.PowerShell.SecretServerSettings.ExportResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [ValidateSet('All', 'AdvancedSettings', 'ApplicationSettings', 'Email', 'FolderSettings', 'LauncherSettings', 'Licenses', 'LocalUserPasswords', 'Login', 'PermissionOptions', 'ProtocolHandlerSettings', 'Saml', 'Security', 'SessionRecording', 'SshCommands', 'TicketSystem', 'UserExperience', 'UserInterface')]
        [string[]]
        $Section = 'All',

        [Parameter(Mandatory, ParameterSetName = 'password')]
        [securestring]
        $Password,

        [Parameter(Mandatory, ParameterSetName = 'doubleLock')]
        [securestring]
        $DoubleLockPassword
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v3'), 'secretserversettings', 'export' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            foreach ($name in $Section) {
                $body.data["load$name"] = $true
            }
            switch ($tssParams.Keys) {
                'Password' {
                    $body.data.Add('password', [System.Net.NetworkCredential]::new('', $Password).Password)
                }
                'DoubleLockPassword' {
                    $body.data.Add('doubleLockPassword', [System.Net.NetworkCredential]::new('', $DoubleLockPassword).Password)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Export-TssServerSettings request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.SecretServerSettings.ExportResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretServerSettings.ExportResult]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
