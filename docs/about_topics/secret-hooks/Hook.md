---
title: "Hook"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.SecretHooks.Hook class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.SecretHooks.Hook

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.SecretHooks.Hook class represents the object returned by endpoint GET /secret-details/{secretId}/get/{secretHookId}

# CONSTRUCTORS
    new()

# PROPERTIES
    Arguments string
        Arguments

    Database string
        Database

    Description string
        Hook Description

    EventActionId integer <int32>
        Event Action Id

    FailureMessage string
        Failure Message

    HookId integer <int32>
        Hook Id

    Name string
        Hook Name

    Parameters Array of objects (Parameter)
        Parameters

    Port string
        Port

    PrePostOption string
        Hook PRE or POST Option

    PrivilegedSecretId integer <int32>
        Privileged Secret Id

    ScriptId integer <int32>
        Script Id

    ScriptTypeId integer <int32>
        Script Type Id

    SecretHookId integer <int32>
        Secret Hook Id

    ServerKeyDigest string
        Server Key Digest

    ServerName string
        Server Name

    SortOrder integer <int32>
        Hook Sort Order

    SshKeySecretId integer <int32>
        SSH Key Secret Id

    Status boolean
        Hook Status

    StopOnFailure boolean
        Stop on Failure

# METHODS

# RELATED LINKS:
    Get-TssSecretHookStub
    New-TssSecretHook
    Update-TssSecretHook