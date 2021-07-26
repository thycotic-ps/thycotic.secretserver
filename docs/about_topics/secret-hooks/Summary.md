---
title: "Summary"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.SecretHooks.Summary class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.SecretHooks.Summary

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.SecretHooks.Summary class represents the object returned by Secret Server GET /secret-detail/{secretId}/hooks

# CONSTRUCTORS
    new()

# PROPERTIES
    Description string
        Hook Description

    EventActionName string
        Event Action Name

    HookId integer <int32>
        Hook Id

    Name string
        Hook Name

    PrePostOption string
        Hook PRE or POST Option

    ScriptName string
        Script Name

    ScriptTypeName string
        Script Type Name

    SecretHookId integer <int32>
        Secret Hook Id

    SortOrder integer <int32>
        Hook Sort Order

    Status boolean
        Hook Status

    StopOnFailure boolean
        Stop On Failure

# METHODS

# RELATED LINKS:
    Search-TssSecretHook