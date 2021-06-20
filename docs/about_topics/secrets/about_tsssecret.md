---
title: "TssSecretItem"
---

# TOPIC
    This help topic describes the TssSecret class in the Thycotic.SecretServer module.

# CLASS
    TssSecret

# INHERITANCE
    None

# DESCRIPTION
    The TssSecret class represents the SecretModel object returned by Secret Server endpoint /secrets{id}.

# CONSTRUCTORS
    new()

# PROPERTIES
    AccessRequestWorkflowMapId
        Access Request Workflow Map Id

    Active
    Whether the secret is active

    AllowOwnersUnrestrictedSshCommands
        Allow Owners Unrestricted Ssh Commands

    AutoChangeEnabled
        Auto Change Enabled

    AutoChangeNextPassword
        Auto Change Next Password

    CheckedOut
        Whether the secret is currently checked out

    CheckOutChangePasswordEnabled
        Check Out Change Password Enabled

    CheckOutEnabled
        Whether secret checkout is enabled

    CheckOutIntervalMinutes
        Checkout interval, in minutes

    CheckOutMinutesRemaining
        Minutes remaining in current checkout interval

    CheckOutUserDisplayName
        Name of user who has checked out the secret

    CheckOutUserId
        ID of user who has checked out the secret

    DoubleLockId
        DoubleLockId

    EnableInheritPermissions
        EnableInheritPermissions

    EnableInheritSecretPolicy
        Whether the secret policy is inherited from the containing folder

    FailedPasswordChangeAttempts
        Number of failed password change attempts

    FolderId
        Containing folder ID

    Id
        Secret ID

    IsDoubleLock
        Whether double lock is enabled

    IsOutOfSync
        Out of sync indicates that a Password is setup for autochange and has failed its last password change attempt or has exceeded the maximum RPC attempts

    IsRestricted
        Whether the secret is restricted

    Items [TssSecretItem[]]
        Secret data fields

    LastHeartBeatCheck
        Time of last heartbeat check

    LastHeartBeatStatus
        Current status of heartbeat (Failed, Success, Pending, Disabled, UnableToConnect, UnknownError, IncompatibleHost, AccountLockedOut, DnsMismatch, UnableToValidateServerPublicKey, Processing, ArgumentError, AccessDenied)

    LastPasswordChangeAttempt
        Time of most recent password change attempt

    LauncherConnectAsSecretId
        Launcher Connect As SecretId

    Name
        Secret name

    OutOfSyncReason
        Reason message if the secret is out of sync

    PasswordTypeWebScriptId
        Password Type Web Script Id

    ProxyEnabled
        Proxy Enabled

    RequiresApprovalForAccess
        Requires Approval For Access

    RequiresComment
        Requires Comment

    RestrictSshCommands
        Restrict Ssh Commands

    SecretPolicyId
        Secret Policy Id

    SecretTemplateId
        Secret template ID

    SecretTemplateName
        Name of secret template

    SessionRecordingEnabled
        Whether session recording is enabled

    SiteId
        Site Id

    WebLauncherRequiresIncognitoMode
        Web Launcher Requires IncognitoMode

# METHODS

    [PSCredential] GetCredential(string DomainField, string UserField, string PwdField)
        Provide the desired slug names
        Outputs a System.Management.Automation.PSCredential object
        If DomainField is not required, provide $null or an empty string and it will be ignored

    [System.String] GetFieldValue(string Slug)
        Pulls the ItemValue of the field based on the slug name

    [Void] SetFieldValue(string Slug, Value)
        Sets the ItemValue value of a Field item

# RELATED LINKS:
    TssSecretItem
    Get-TssSecret
    Get-TssSecretStub
    New-TssSecret