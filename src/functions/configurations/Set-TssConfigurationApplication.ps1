function Set-TssConfigurationApplication {
    <#
    .SYNOPSIS
    Set the application settings configuration

    .DESCRIPTION
    Updates the application settings configuration (API sessions and tokens, web services, Syslog/CEF logging, PII obfuscation, mobile offline access and related settings) and returns the full updated configuration.
    Only the parameters you pass are sent; everything else keeps its current value. Switch parameters send their value, so -Name:$false turns a setting off.
    Secret Server Cloud rejects AllowSoftwareUpdateChecks, ConfigurationEarlyAdopterEnabled, PreventApplicationFromSleeping, WriteSyslogToEventLog, TmsInstallationPath and CustomUrl.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER AllowSendTelemetry
    Send Anonymized System Metrics Information

    .PARAMETER AllowSoftwareUpdateChecks
    Allow software update checks. This setting is ignored in cloud environments

    .PARAMETER ApiRefreshTokensEnabled
    Allow API refresh tokens

    .PARAMETER ApiSessionTimeoutDays
    API session timeout, days part

    .PARAMETER ApiSessionTimeoutHours
    API session timeout, hours part

    .PARAMETER ApiSessionTimeoutMinutes
    API session timeout, minutes part

    .PARAMETER ApiSessionTimeoutUnlimited
    API sessions never time out

    .PARAMETER ConfigurationEarlyAdopterEnabled
    Notify when preview releases are available. False by default

    .PARAMETER CustomUrl
    Outward accessible url to get to application. This setting is ignored in cloud environments

    .PARAMETER DisplayDowntimeMessageToAdminsOnly
    Only show downtime messages to admins. This setting is only used in cloud environments

    .PARAMETER EnableCredSsp
    Use CredSSP for WinRM

    .PARAMETER EnableSyslogCefLogging
    Send audit events to a Syslog/CEF server

    .PARAMETER EnableWebServices
    Enable the web services (API)

    .PARAMETER MaximumTokenRefreshesAllowed
    Maximum number of times an API token can be refreshed

    .PARAMETER MaxSecretLogLength
    Maximum number of entries in secret log

    .PARAMETER MobileMaxOfflineDays
    Maximum offline access on mobile devices, days part

    .PARAMETER MobileMaxOfflineHours
    Maximum offline access on mobile devices, hours part

    .PARAMETER ObfuscatePersonallyIdentifiableInformation
    Should Secret Server obfuscate information that could identify a person

    .PARAMETER PiiObfuscationLevel
    Delimit or replace personally identifiable information and automatically remove from Audit Exports

    .PARAMETER PreventApplicationFromSleeping
    A keep alive thread will run in the background pinging the web URL to make sure IIS does not stop running due to inactivity. This setting is ignored in cloud environments

    .PARAMETER PreventDirectApiAuthentication
    Prevent non-Application Account users from directly authenticating against the API

    .PARAMETER SyslogCefDateTimeFormat
    DateTime Format for Syslog/CEF Protocol log timestamps. Syslog: Jun 23 2022 11:22:33; ISO 8601: 2022-06-23T11:22:33.000

    .PARAMETER SyslogCefLogSite
    Site id the Syslog/CEF logging runs on

    .PARAMETER SyslogCefPort
    Syslog/CEF server port

    .PARAMETER SyslogCefProtocol
    Syslog/CEF Protocol to use when sending logs

    .PARAMETER SyslogCefServer
    Syslog/CEF Server Address

    .PARAMETER SyslogCefTimeZone
    Time Zone to use when sending Syslog/CEF Protocol log entries

    .PARAMETER TmsInstallationPath
    If TMS is installed, the file location. This setting is ignored in cloud environments

    .PARAMETER WinRmEndpointUrl
    WinRM endpoint URL

    .PARAMETER WriteSyslogToEventLog
    Enable syslog events to the windows event log. This setting is ignored in cloud environments

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssConfigurationApplication -TssSession $session -ApiSessionTimeoutUnlimited:$false -ApiSessionTimeoutHours 8

    Expire API sessions after 8 hours

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssConfigurationApplication -TssSession $session -EnableSyslogCefLogging -SyslogCefServer 'syslog.example.com' -SyslogCefPort 514 -SyslogCefProtocol 'UDP'

    Send audit events to syslog.example.com over UDP port 514

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssConfigurationApplication

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssConfigurationApplication.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.ApplicationSettings')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $AllowSendTelemetry,

        [switch]
        $AllowSoftwareUpdateChecks,

        [switch]
        $ApiRefreshTokensEnabled,

        [int]
        $ApiSessionTimeoutDays,

        [int]
        $ApiSessionTimeoutHours,

        [int]
        $ApiSessionTimeoutMinutes,

        [switch]
        $ApiSessionTimeoutUnlimited,

        [switch]
        $ConfigurationEarlyAdopterEnabled,

        [string]
        $CustomUrl,

        [switch]
        $DisplayDowntimeMessageToAdminsOnly,

        [switch]
        $EnableCredSsp,

        [switch]
        $EnableSyslogCefLogging,

        [switch]
        $EnableWebServices,

        [int]
        $MaximumTokenRefreshesAllowed,

        [int]
        $MaxSecretLogLength,

        [int]
        $MobileMaxOfflineDays,

        [int]
        $MobileMaxOfflineHours,

        [switch]
        $ObfuscatePersonallyIdentifiableInformation,

        [string]
        $PiiObfuscationLevel,

        [switch]
        $PreventApplicationFromSleeping,

        [switch]
        $PreventDirectApiAuthentication,

        [ValidateSet('Syslog', 'ISO8601')]
        [string]
        $SyslogCefDateTimeFormat,

        [int]
        $SyslogCefLogSite,

        [int]
        $SyslogCefPort,

        [ValidateSet('UDP', 'TCP', 'SECURE_TCP')]
        [string]
        $SyslogCefProtocol,

        [string]
        $SyslogCefServer,

        [ValidateSet('ServerTime', 'UtcTime')]
        [string]
        $SyslogCefTimeZone,

        [string]
        $TmsInstallationPath,

        [string]
        $WinRmEndpointUrl,

        [switch]
        $WriteSyslogToEventLog
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'application-settings' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'AllowSendTelemetry' {
                    $body.data.Add('allowSendTelemetry', @{ dirty = $true; value = [boolean]$AllowSendTelemetry })
                }
                'AllowSoftwareUpdateChecks' {
                    $body.data.Add('allowSoftwareUpdateChecks', @{ dirty = $true; value = [boolean]$AllowSoftwareUpdateChecks })
                }
                'ApiRefreshTokensEnabled' {
                    $body.data.Add('apiRefreshTokensEnabled', @{ dirty = $true; value = [boolean]$ApiRefreshTokensEnabled })
                }
                'ApiSessionTimeoutDays' {
                    $body.data.Add('apiSessionTimeoutDays', @{ dirty = $true; value = $ApiSessionTimeoutDays })
                }
                'ApiSessionTimeoutHours' {
                    $body.data.Add('apiSessionTimeoutHours', @{ dirty = $true; value = $ApiSessionTimeoutHours })
                }
                'ApiSessionTimeoutMinutes' {
                    $body.data.Add('apiSessionTimeoutMinutes', @{ dirty = $true; value = $ApiSessionTimeoutMinutes })
                }
                'ApiSessionTimeoutUnlimited' {
                    $body.data.Add('apiSessionTimeoutUnlimited', @{ dirty = $true; value = [boolean]$ApiSessionTimeoutUnlimited })
                }
                'ConfigurationEarlyAdopterEnabled' {
                    $body.data.Add('configurationEarlyAdopterEnabled', @{ dirty = $true; value = [boolean]$ConfigurationEarlyAdopterEnabled })
                }
                'CustomUrl' {
                    $body.data.Add('customUrl', @{ dirty = $true; value = $CustomUrl })
                }
                'DisplayDowntimeMessageToAdminsOnly' {
                    $body.data.Add('displayDowntimeMessageToAdminsOnly', @{ dirty = $true; value = [boolean]$DisplayDowntimeMessageToAdminsOnly })
                }
                'EnableCredSsp' {
                    $body.data.Add('enableCredSsp', @{ dirty = $true; value = [boolean]$EnableCredSsp })
                }
                'EnableSyslogCefLogging' {
                    $body.data.Add('enableSyslogCefLogging', @{ dirty = $true; value = [boolean]$EnableSyslogCefLogging })
                }
                'EnableWebServices' {
                    $body.data.Add('enableWebServices', @{ dirty = $true; value = [boolean]$EnableWebServices })
                }
                'MaximumTokenRefreshesAllowed' {
                    $body.data.Add('maximumTokenRefreshesAllowed', @{ dirty = $true; value = $MaximumTokenRefreshesAllowed })
                }
                'MaxSecretLogLength' {
                    $body.data.Add('maxSecretLogLength', @{ dirty = $true; value = $MaxSecretLogLength })
                }
                'MobileMaxOfflineDays' {
                    $body.data.Add('mobileMaxOfflineDays', @{ dirty = $true; value = $MobileMaxOfflineDays })
                }
                'MobileMaxOfflineHours' {
                    $body.data.Add('mobileMaxOfflineHours', @{ dirty = $true; value = $MobileMaxOfflineHours })
                }
                'ObfuscatePersonallyIdentifiableInformation' {
                    $body.data.Add('obfuscatePersonallyIdentifiableInformation', @{ dirty = $true; value = [boolean]$ObfuscatePersonallyIdentifiableInformation })
                }
                'PiiObfuscationLevel' {
                    $body.data.Add('piiObfuscationLevel', @{ dirty = $true; value = $PiiObfuscationLevel })
                }
                'PreventApplicationFromSleeping' {
                    $body.data.Add('preventApplicationFromSleeping', @{ dirty = $true; value = [boolean]$PreventApplicationFromSleeping })
                }
                'PreventDirectApiAuthentication' {
                    $body.data.Add('preventDirectApiAuthentication', @{ dirty = $true; value = [boolean]$PreventDirectApiAuthentication })
                }
                'SyslogCefDateTimeFormat' {
                    $body.data.Add('syslogCefDateTimeFormat', @{ dirty = $true; value = $SyslogCefDateTimeFormat })
                }
                'SyslogCefLogSite' {
                    $body.data.Add('syslogCefLogSite', @{ dirty = $true; value = $SyslogCefLogSite })
                }
                'SyslogCefPort' {
                    $body.data.Add('syslogCefPort', @{ dirty = $true; value = $SyslogCefPort })
                }
                'SyslogCefProtocol' {
                    $body.data.Add('syslogCefProtocol', @{ dirty = $true; value = $SyslogCefProtocol })
                }
                'SyslogCefServer' {
                    $body.data.Add('syslogCefServer', @{ dirty = $true; value = $SyslogCefServer })
                }
                'SyslogCefTimeZone' {
                    $body.data.Add('syslogCefTimeZone', @{ dirty = $true; value = $SyslogCefTimeZone })
                }
                'TmsInstallationPath' {
                    $body.data.Add('tmsInstallationPath', @{ dirty = $true; value = $TmsInstallationPath })
                }
                'WinRmEndpointUrl' {
                    $body.data.Add('winRmEndpointUrl', @{ dirty = $true; value = $WinRmEndpointUrl })
                }
                'WriteSyslogToEventLog' {
                    $body.data.Add('writeSyslogToEventLog', @{ dirty = $true; value = [boolean]$WriteSyslogToEventLog })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Configuration application", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssConfigurationApplication request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.ApplicationSettings](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.ApplicationSettings]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
