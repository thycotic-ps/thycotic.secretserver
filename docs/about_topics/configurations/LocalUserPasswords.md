---
title: "LocalUserPasswords"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.Configuration.LocalUserPasswords" class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.Configuration.LocalUserPasswords"

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Configuration.LocalUserPasswords" class represents the ConfigurationLocalUserPasswords returned by Secret Server endpoint GET /configuration/general

# CONSTRUCTORS
    new()

# PROPERTIES
    AllowUsersToResetForgottenPasswords: boolean
        Whether or not the local password can be reset by the user

    EnableLocalUserPasswordExpiration: boolean
        Indicates whether or not local users must change their password when it is reset or expires.

    EnableMinimumPasswordAge: boolean
        Local users cannot change their password until it meets this age

    EnablePasswordHistory: boolean
        Passwords cannot be reused when enabled and still in stored history

    LocalUserPasswordExpirationDays: integer (int32)
        How many days until the password expires

    LocalUserPasswordExpirationHours: integer (int32)
        How many hours until the password expires

    LocalUserPasswordExpirationMinutes: integer (int32)
        How many minutes until the password expires

    MinimumPasswordAgeDays: integer (int32)
        How many days until password can be changed

    MinimumPasswordAgeHours: integer (int32)
        How many hours until password can be changed

    MinimumPasswordAgeMinutes: integer (int32)
        How many minutes until password can be changed

    PasswordHistoryItems: integer (int32)
        How many passwords should be stored in history.

    PasswordMinimumLength: integer (int32)
        The minimum length required for local user passwords

    PasswordRequireLowercase: boolean
        Whether or not the local password must include a lowercase letter

    PasswordRequireNumbers: boolean
        Whether or not the local password must include a number

    PasswordRequireSymbols: boolean
        Whether or not the local password must include a symbol

    PasswordRequireUppercase: boolean
        Whether or not the local password must include an uppercase letter

# METHODS

# RELATED LINKS:
    Get-TssConfiguration