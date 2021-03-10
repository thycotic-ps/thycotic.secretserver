class TssConfigurationApplicationSettings {
    [boolean]
    $AllowSendTelemetry

    [boolean]
    $AllowSoftwareUpdateChecks

    [boolean]
    $ApiRefreshTokensEnabled

    [int]
    $ApiSessionTimeoutDays

    [int]
    $ApiSessionTimeoutHours

    [int]
    $ApiSessionTimeoutMinutes

    [boolean]
    $ApiSessionTimeoutUnlimited

    [string]
    $CustomUrl

    [boolean]
    $EnableCredSsp

    [boolean]
    $EnableSyslogCefLogging

    [boolean]
    $EnableWebServices

    [int]
    $MaximumTokenRefreshesAllowed

    [int]
    $MaxSecretLogLength

    [int]
    $MobileMaxOfflineDays

    [int]
    $MobileMaxOfflineHours

    [boolean]
    $PreventApplicationFromSleeping

    [int]
    $SyslogCefLogSite

    [int]
    $SyslogCefPort

    [ValidateSet('UDP','TCP','SECURE_TCP')]
    [string]
    $SyslogCefProtocol

    [string]
    $SyslogCefServer

    [ValidateSet('ServerTime','UtcTime')]
    [string]
    $SyslogCefTimeZone

    [string]
    $TmsInstallationPath

    [string]
    $WinRmEndpointUrl

    [boolean]
    $WriteSyslogToEventLog
}