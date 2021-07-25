---
title: "UserExperience"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.Configuration.UserExperience class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.Configuration.UserExperience

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Configuration.UserExperience class represents the ConfigurationUserExperienceModel returned by Secret Server endpoint GET /configuration/general

# CONSTRUCTORS
    new()

# PROPERTIES
    ApplicationLanguage: integer (int32)
        The default application language for users and the language for non-user specific tasks like logging when applicable

    DefaultDateFormat: integer (int32)
        The default date format that everyone sees unless they override with a user preference

    DefaultNewUserRoleId: integer (int32)
        The role that should be assigned when a new user is created

    DefaultTimeFormat: integer (int32)
        The default time format that everyone sees unless they override with a user preference

    ForceInactivityTimeout: boolean
        Logout users that are inactive

    ForceInactivityTimeoutMinutes: integer (int32)
        Logout users that are inactive for this many minutes

    RequireFolderForSecret: boolean
        Secrets must be created within a folder

    SecretPasswordHistoryRestrictionAll: boolean
        No duplicate passwords on a Secret

    SecretPasswordHistoryRestrictionCount: integer (int32)
        How many passwords must be unique on a Secret

    SecretViewIntervalMinutes: integer (int32)
        How long entering comments to view a Secret last before being required again

    ServerTimeZoneId: string
        The timezone that the server shows by default and when job scheduling runs

    UiInactivitySleepMinutes: integer (int32)
        How long until the UI will go inactive and stop polling for updates

# METHODS

# RELATED LINKS:
    Get-TssConfiguration