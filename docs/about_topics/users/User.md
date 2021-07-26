---
title: "User"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.Users.User class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.Users.User

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Users.User class represents the UserModel object returned by Secret Server endpoint GET /users/{id}

# CONSTRUCTORS
    new()

# PROPERTIES
    AdAccountExpires
        Active Directory account expiration time

    AdGuid
        Active Directory unique identifier

    Created
        User creation time

    DateOptionId
        DateOptionId

    DisplayName
        Display name

    DomainId
        Active Directory domain ID

    DuoTwoFactor
        Whether Duo two-factor authentication is enabled

    EmailAddress
        Email address

    Enabled
        Whether the user account is enabled

    Fido2TwoFactor
        Whether FIDO2 two-factor authentication is enabled

    Id
        User ID

    IsApplicationAccount
        IsApplicationAccount

    IsEmailCopiedFromAD
        Whether the email address is derived from the Active Directory account

    IsEmailVerified
        Whether the email address has been verified

    IsLockedOut
        Whether the user is locked out

    LastLogin
        Time of last login

    LastSessionActivity
        Time of last session activity

    LockOutReason
        The reason for the lock out

    LockOutReasonDescription
        An optional description of the reason for the lock out

    LoginFailures
        Number of login failures

    MustVerifyEmail
        Whether the user must verify their email address

    OathTwoFactor
        Whether OATH two-factor authentication is enabled

    OathVerified
        Whether OATH has been verified

    PasswordLastChanged
        Time when the password was last changed

    RadiusTwoFactor
        Whether RADIUS two-factor authentication is enabled

    RadiusUserName
        RADIUS username

    ResetSessionStarted
        ResetSessionStarted

    TimeOptionId
        TimeOptionId

    TwoFactor
        Whether two-factor authentication is enabled

    UnixAuthenticationMethod
        Check password, public key, either, or both

    UserLcid
        UserLcid

    Username
        Username

    VerifyEmailSentDate
        Time when the verification email was sent

# METHODS

# RELATED LINKS:
    Get-TssUser
    New-TssUser