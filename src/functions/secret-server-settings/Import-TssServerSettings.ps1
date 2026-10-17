function Import-TssServerSettings {
    <#
    .SYNOPSIS
    Import Secret Server settings

    .DESCRIPTION
    Applies settings sections to Secret Server and returns the applied settings with errors and warnings per section.
    -Data is keyed by section (advancedSettings, applicationSettings, email, configurationEmailMessageHeaders, folderSettings, launcherSettings, licenses, localUserPasswords, login, permissionOptions, protocolHandlerSettings, saml, security, sessionRecording, sshCommands, ticketSystem, userExperience, userInterface). Each section uses the PATCH shape of its configuration endpoint: a field is set with @{ dirty = $true; value = <value> }.
    Only the sections present in -Data are imported. -Legacy uses the version 1 endpoint.
    Requires the Advanced Import and Administer Configuration role permissions.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Data
    Settings to import, keyed by section (hashtable or object)

    .PARAMETER Legacy
    Use the version 1 import endpoint

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $data = @{ applicationSettings = @{ maxSecretLogLength = @{ dirty = $true; value = 5000 } } }
    Import-TssServerSettings -TssSession $session -Data $data

    Imports one application setting

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $data = @{ login = @{ maximumLoginFailures = @{ dirty = $true; value = 5 } } }
    Import-TssServerSettings -TssSession $session -Data $data -Legacy -WhatIf

    Shows the version 1 import request for one login setting without sending it

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-server-settings/Import-TssServerSettings

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-server-settings/Import-TssServerSettings.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'v3', SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SecretServerSettings.ImportResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [object]
        $Data,

        [Parameter(Mandatory, ParameterSetName = 'v1')]
        [switch]
        $Legacy
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
        $sectionFilter = @{
            advancedSettings                 = 'loadAdvancedSettings'
            applicationSettings              = 'loadApplicationSettings'
            email                            = 'loadEmail'
            configurationEmailMessageHeaders = 'loadEmail'
            folderSettings                   = 'loadFolderSettings'
            launcherSettings                 = 'loadLauncherSettings'
            licenses                         = 'loadLicenses'
            localUserPasswords               = 'loadLocalUserPasswords'
            login                            = 'loadLogin'
            permissionOptions                = 'loadPermissionOptions'
            protocolHandlerSettings          = 'loadProtocolHandlerSettings'
            saml                             = 'loadSaml'
            security                         = 'loadSecurity'
            sessionRecording                 = 'loadSessionRecording'
            sshCommands                      = 'loadSshCommands'
            ticketSystem                     = 'loadTicketSystem'
            userExperience                   = 'loadUserExperience'
            userInterface                    = 'loadUserInterface'
        }
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            switch ($PSCmdlet.ParameterSetName) {
                'v3' {
                    $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v3'), 'secretserversettings', 'import' -join '/'
                }
                'v1' {
                    $uri = $TssSession.ApiUrl, 'secretserversettings', 'import' -join '/'
                }
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $sectionNames = if ($Data -is [System.Collections.IDictionary]) { $Data.Keys } else { $Data.PSObject.Properties.Name }
            $filter = @{ }
            foreach ($name in $sectionNames) {
                if ($sectionFilter.ContainsKey($name)) {
                    $filter[$sectionFilter[$name]] = $true
                }
            }
            $body = @{
                data   = $Data
                filter = $filter
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret Server settings: $(@($filter.Keys | Sort-Object) -join ', ')", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: settings can carry sensitive values)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Import-TssServerSettings request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SecretServerSettings.ImportResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretServerSettings.ImportResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
