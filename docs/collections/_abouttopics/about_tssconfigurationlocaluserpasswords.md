---
category: configurations
title: "TssConfigurationLocalUserPasswords"
last_modified_at: 2021-04-04T00:00:00-00:00
---

# TOPIC
    This help topic describes the TssConfigurationLocalUserPasswords class in the Thycotic.SecretServer module

# CLASS
    TssConfigurationLocalUserPasswords

# INHERITANCE
    None

# DESCRIPTION
    The TssConfigurationLocalUserPasswords class represents the ConfigurationLocalUserPasswords returned by Secret Server endpoint GET /configuration/general

# CONSTRUCTORS
    new()

# PROPERTIES
    AllowUsersToResetForgottenPasswords
        Whether or not the local password can be reset by the user

    EnableLocalUserPasswordExpiration
        Indicates whether or not local users must change their password when it is reset or expires.

    EnableMinimumPasswordAge
        Local users cannot change their password until it meets this age

    EnablePasswordHistory
        Passwords cannot be reused when enabled and still in stored history

    LocalUserPasswordExpirationDays
        How many days until the password expires

    LocalUserPasswordExpirationHours
        How many hours until the password expires

    LocalUserPasswordExpirationMinutes
        How many minutes until the password expires

    MinimumPasswordAgeDays
        How many days until password can be changed

    MinimumPasswordAgeHours
        How many hours until password can be changed

    MinimumPasswordAgeMinutes
        How many minutes until password can be changed

    PasswordHistoryItems
        How many passwords should be stored in history.

    PasswordMinimumLength
        The minimum length required for local user passwords

    PasswordRequireLowercase
        Whether or not the local password must include a lowercase letter

    PasswordRequireNumbers
        Whether or not the local password must include a number

    PasswordRequireSymbols
        Whether or not the local password must include a symbol

    PasswordRequireUppercase
        Whether or not the local password must include an uppercase letter

# METHODS

# RELATED LINKS:
    TssConfiguration
    Get-TssConfiguration