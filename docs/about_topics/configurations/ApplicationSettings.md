---
title: "Thycotic.PowerShell.Configuration.ApplicationSettings"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.Configuration.ApplicationSettings class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.Configuration.ApplicationSettings

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Configuration.ApplicationSettings class represents the ConfigurationApplicationSettingsModel returned by Secret Server endpoint GET /configuration/general

# CONSTRUCTORS
    new()

# PROPERTIES
    AllowSendTelemetry: boolean
        Send Anonymized System Metrics Information

    AllowSoftwareUpdateChecks: boolean
        Allow software update checks. This setting is ignored in cloud environments.

    ApiRefreshTokensEnabled: boolean
        API Refresh Tokens Enabled

    ApiSessionTimeoutDays: integer (int32)
        API session timeout days

    ApiSessionTimeoutHours: integer (int32)
        API session timeout hours

    ApiSessionTimeoutMinutes: integer (int32)
        API session timeout minutes

    ApiSessionTimeoutUnlimited: boolean
        API session timeout unlimited

    ConfigurationEarlyAdopterEnabled: boolean
        Notify when preview releases are available. False by default

    CustomUrl: string
        Outward accessible url to get to application. This setting is ignored in cloud environments.

    DisplayDowntimeMessageToAdminsOnly: boolean
        Display Downtime Message To Admins Only

    EnableCredSsp: boolean
        Enable Cred SSP for win RM

    EnableSyslogCefLogging: boolean
        Enable Syslog/CEF Logging

    EnableWebServices: boolean
        Enable Web services

    MaximumTokenRefreshesAllowed: integer (int32)
        Maximum Token Refreshes Allowed

    MaxSecretLogLength: integer (int32)
        Maximum number of entries in secret log

    MobileMaxOfflineDays: integer (int32)
        The Maximum Time for Offline Access on Mobile Devices setting in Secret Server determines how long to cache secret data on the mobile device

    MobileMaxOfflineHours: integer (int32)
        The Maximum Time for Offline Access on Mobile Devices setting in Secret Server determines how long to cache secret data on the mobile device

    PreventApplicationFromSleeping: boolean
        A keep alive thread will run in the background pinging the web URL to make sure IIS does not stop running due to inactivity. This setting is ignored in cloud environments.

    SyslogCefLogSite: integer (int32)
        This is the site that the CEF/Syslogs will run on

    SyslogCefPort: integer (int32)
        Syslog/CEF Protocol

    SyslogCefProtocol: string
        Syslog/CEF Protocol to use when sending logs

    SyslogCefServer: string
        Syslog/CEF Server Address

    SyslogCefTimeZone: string
        Time Zone to use when sending Syslog/CEF Protocol log entries

    TmsInstallationPath: string
        If TMS is installed, the file location. This setting is ignored in cloud environments.

    WinRmEndpointUrl: string
        Win RM endpoint url

    WriteSyslogToEventLog: boolean
        Enable syslog events to the windows event log. This setting is ignored in cloud environments.

# METHODS

# RELATED LINKS:
    Get-TssConfiguration