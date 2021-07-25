---
title: "LauncherSettings"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.Configuration.LauncherSettings" class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.Configuration.LauncherSettings"

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Configuration.LauncherSettings" class represents the ConfigurationLauncherSettingsModel object returned by Secret Server endpoint GET /configuration/general

# CONSTRUCTORS
    new()

# PROPERTIES
    CheckInSecretOnLastLauncherClose: boolean
        Forces Check In of Secret when user closes their only active launcher.

    CloseLauncherOnCheckInSecret: boolean
        When Secret is Checked In, all active launchers associated with it will close.

    EnableDomainDownload: boolean
        Allow the user to download existing and tested mappings from Thycotic.com.

    EnableDomainUpload: boolean
        Allow the user to upload mappings

    EnableLauncher: boolean
        Enable Launcher

    EnableLauncherAutoUpdate: boolean
        Enable Launcher Auto Update

    EnableWebParsing: boolean
        Allow Secret Server to retrieve and parse the mapped website when using the web launcher.

    LauncherDeploymentType: string
        Launcher Deployment Type

    SendSecretUrlToLauncher: boolean
        Send the URL that is on the Secret to the web password launcher in addition to the bookmarklet

# METHODS

# RELATED LINKS:
    Get-TssConfiguration