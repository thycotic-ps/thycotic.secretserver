---
category: configurations
title: "TssConfigurationApplicationSettings"
last_modified_at: 2021-04-04T00:00:00-00:00
---

# TOPIC
    This help topic describes the TssConfigurationApplicationSettings class in the Thycotic.SecretServer module

# CLASS
    TssConfigurationApplicationSettings

# INHERITANCE
    None

# DESCRIPTION
    The TssConfigurationApplicationSettings class represents the ConfigurationApplicationSettingsModel returned by Secret Server endpoint GET /configuration/general

# CONSTRUCTORS
    new()

# PROPERTIES
    AllowSendTelemetry
        Send Anonymized System Metrics Information

    AllowSoftwareUpdateChecks
        Allow software update checks

    ApiRefreshTokensEnabled
        API Refresh Tokens Enabled

    ApiSessionTimeoutDays
        API session timeout days

    ApiSessionTimeoutHours
        API session timeout hours

    ApiSessionTimeoutMinutes
        API session timeout minutes

    ApiSessionTimeoutUnlimited
        API session timeout unlimited

    CustomUrl
        Outward accessible url to get to application

    EnableCredSsp
        Enable Cred SSP for win RM

    EnableSyslogCefLogging
        Enable Syslog/CEF Logging

    EnableWebServices
        Enable Web services

    MaximumTokenRefreshesAllowed
        Maximum Token Refreshes Allowed

    MaxSecretLogLength
        Maximum number of entries in secret log

    MobileMaxOfflineDays
        The Maximum Time for Offline Access on Mobile Devices setting in Secret Server determines how long to cache secret data on the mobile device

    MobileMaxOfflineHours
        The Maximum Time for Offline Access on Mobile Devices setting in Secret Server determines how long to cache secret data on the mobile device

    PreventApplicationFromSleeping
        A keep alive thread will run in the background pinging the web URL to make sure IIS does not stop running due to inactivity

    SyslogCefLogSite
        This is the site that the CEF/Syslogs will run on

    SyslogCefPort
        Syslog/CEF Protocol

    SyslogCefProtocol
        Syslog/CEF Protocol to use when sending logs (UPD, TCP, SECURE_TCP)

    SyslogCefServer
        Syslog/CEF Server Address

    SyslogCefTimeZone
        Time Zone to use when sending Syslog/CEF Protocol log entries (ServerTime, UtcTime)

    TmsInstallationPath
        If TMS is installed, the file location

    WinRmEndpointUrl
        Win RM endpoint url

    WriteSyslogToEventLog
        Enable syslog events to the windows event log

# METHODS

# RELATED LINKS:
    TssConfiguration
    Get-TssConfiguration