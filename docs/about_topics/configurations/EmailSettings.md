---
title: "Thycotic.PowerShell.Configuration.EmailSettings"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.Configuration.EmailSettings class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.Configuration.EmailSettings

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Configuration.EmailSettings class represents the ConfigurationEmailModel returned by Secret Server endpoint GET /configuration/general

# CONSTRUCTORS
    new()

# PROPERTIES
    FromEmailAddress: string
        All emails will be sent from this address

    SmtpCheckCertificateRevocation: boolean
        Check Certificate Revocation when in Implicit SSL Connection Mode

    SmtpDomain: string
        SMTP user domain

    SmtpPassword: string
        SMTP user password

    SmtpPort: integer (int32)
        Custom port, otherwise the default

    SmtpServer: string
        The resolvable and reachable host name for the outgoing SMTP server

    SmtpUseCredentials: boolean
        True if credentials are set, false if anonymous

    SmtpUseImplicitSSL: boolean
        Implicit SSL Connection Mode

    SmtpUserName: string
        SMTP user name

    SmtpUseSSL: boolean
        Use SSL to connect

# METHODS

# RELATED LINKS:
    Get-TssConfiguration