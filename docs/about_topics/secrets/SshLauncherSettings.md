---
title: "SshLauncherSettings"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.Secrets.SshLauncherSettings class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.Secrets.SshLauncherSettings

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Secrets.SshLauncherSettings class represents the SshLauncherSettingsModel object returned by Secret Server endpoint GET /secrets/{id}/settings

# CONSTRUCTORS
    new()

# PROPERTIES
    CanConnectAsCredentials
        Can Connect As Credentials

    LauncherType
        Launcher Type (ConnectAsSecret, ConnectAsDifferentSecret, UseSshKeyOnSecret)

    SecretId
        Secret Id

    SecretName
        Secret Name

    SshKeyExtendedTypeId
        SSH Key Extended Type Id

# METHODS

# RELATED LINKS:
    Thycotic.PowerShell.Secrets.DetailSettings
    Get-TssSecretSetting