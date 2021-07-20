---
title: "Thycotic.PowerShell.Secrets.DetailSettings"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.Secrets.DetailSettings class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.Secrets.DetailSettings

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Secrets.DetailSettings class represents the SecretDetailSettingsModel object returned by Secret Server endpoint GET /secrets/{id}/settings

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
    Thycotic.PowerShell.Secrets.OneTimePasswordSettings
    Thycotic.PowerShell.Secrets.RdpLauncherSettings
    Thycotic.PowerShell.Secrets.SshLauncherSettings
    Get-TssSecretSetting