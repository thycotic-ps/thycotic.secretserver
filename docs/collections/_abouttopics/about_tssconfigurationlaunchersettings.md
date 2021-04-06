---
category: configurations
title: "TssConfigurationGeneral"
last_modified_at: 2021-04-04T00:00:00-00:00
---

# TOPIC
    This help topic describes the TssConfigurationLauncherSettings class in the Thycotic.SecretServer module

# CLASS
    TssConfigurationLauncherSettings

# INHERITANCE
    None

# DESCRIPTION
    The TssConfigurationLauncherSettings class represents the ConfigurationLauncherSettingsModel object returned by Secret Server endpoint GET /configuration/general

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
    TssConfigurationGeneral
    Get-TssConfiguration