---
category: secrets
title: "TssSecretDetailSettings"
last_modified_at: 2021-03-18T00:00:00-00:00
---

# TOPIC
    This help topic describes the TssSecretDetailSettings class in the Thycotic.SecretServer module

# CLASS
    TssSecretDetailSettings

# INHERITANCE
    None

# DESCRIPTION
    The TssSecretDetailSettings class represents the SecretDetailSettingsModel object returned by Secret Server endpoint GET /secrets/{id}/settings

# CONSTRUCTORS
    new()

# PROPERTIES
    ExpirationDate
        Expiration Date

    ExpirationDayInterval
        Expiration Day Interval

    ExpirationTemplateText
        Expiration Template Text

    ExpirationType
        Expiration Type (Template, DayInterval, SpecificDate, Disabled)

    OneTimePasswordSettings
        One Time Password Settings

    RdpLauncherSettings
        RDP Launcher Settings

    SendEmailWhenChanged
        Send Email When Changed

    SendEmailWhenHeartbeatFails
        Send Email When Heartbeat Fails

    SendEmailWhenViewed
        Send Email When Viewed

    SshLauncherSettings
        SSH Launcher Settings

# METHODS

# RELATED LINKS:
    TssOneTimePasswordSettings
    TssRdpLauncherSettings
    TssSshLauncherSettings
    Get-TssSecretSetting