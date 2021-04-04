---
category: configurations
title: "TssConfigurationEmailSettings"
last_modified_at: 2021-04-04T00:00:00-00:00
---

# TOPIC
    This help topic describes the TssConfigurationEmailSettings class in the Thycotic.SecretServer module

# CLASS
    TssConfigurationEmailSettings

# INHERITANCE
    None

# DESCRIPTION
    The TssConfigurationEmailSettings class represents the ConfigurationEmailModel returned by Secret Server endpoint GET /configuration/general

# CONSTRUCTORS
    new()

# PROPERTIES
    FromEmailAddress
        All emails will be sent from this address

    SmtpDomain
        SMTP user domain

    SmtpPassword
        SMTP user password

    SmtpPort
        Custom port, otherwise the default

    SmtpServer
        The resolvable and reachable host name for the outgoing SMTP server

    SmtpUseCredentials
        True if credentials are set, false if anonymous

    SmtpUserName
        SMTP user name

    smtpUseSSL
        Use SSL to connect

# METHODS

# RELATED LINKS:
    TssConfiguration
    Get-TssConfiguration