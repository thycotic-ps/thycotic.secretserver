---
category: configurations
title: "TssConfigurationUserExperience"
last_modified_at: 2021-04-04T00:00:00-00:00
---

# TOPIC
    This help topic describes the TssConfigurationUserExperience class in the Thycotic.SecretServer module

# CLASS
    TssConfigurationUserExperience

# INHERITANCE
    None

# DESCRIPTION
    The TssConfigurationUserExperience class represents the ConfigurationUserExperienceModel returned by Secret Server endpoint GET /configuration/general

# CONSTRUCTORS
    new()

# PROPERTIES
    ApplicationLanguage
        The default application language for users and the language for non-user specific tasks like logging when applicable

    DefaultDateFormat
        The default date format that everyone sees unless they override with a user preference

    DefaultNewUserRoleId
        The role that should be assigned when a new user is created

    DefaultTimeFormat
        The default time format that everyone sees unless they override with a user preference

    ForceInactivityTimeout
        Logout users that are inactive

    ForceInactivityTimeoutMinutes
        Logout users that are inactive for this many minutes

    RequireFolderForSecret
        Secrets must be created within a folder

    SecretPasswordHistoryRestrictionAll
        No duplicate passwords on a Secret

    SecretPasswordHistoryRestrictionCount
        How many passwords must be unique on a Secret

    SecretViewIntervalMinutes
        How long entering comments to view a Secret last before being required again

    ServerTimeZoneId
        The timezone that the server shows by default and when job scheduling runs

    UiInactivitySleepMinutes
        How long until the UI will go inactive and stop polling for updates

# METHODS

# RELATED LINKS:
    TssConfiguration
    Get-TssConfiguration