---
title: "Thycotic.PowerShell.Authentication.Session"
---

# TOPIC
    This help topic describes the Session class in the Thycotic.SecretServer module.

# CLASS
    Thycotic.PowerShell.Authentication.Session

# INHERITANCE
    None

# DESCRIPTION
    The TssSession class represents an authenticated object to Secret Server.
    New-TssSession is used to create an instance of this class type.

# CONSTRUCTORS
    new()

# PROPERTIES
    SecretServer:
        Secret Server base URL

    ApiVersion:
        Default value of `api/v1`

    WindowsAuth: readonly
        Default to `winauthwebservices`, utilized with IWA

    AccessToken:
        Authentication token

    RefreshToken:
        Authentication token (when using refresh_token grant type)

    TokenType:
        Based on the authentication method (possible values: bearer, ExternalToken, or WindowsAuth)

    ExpiresIn:
        Authentication token expiration time, in seconds

    StartTime:
        Current date and time when session was created

    TimeOfDeath:
        Expiration date and time based on ExpiresIn value.
        Provides the time when the authentication token will no longer be valid.

    Take:
        Endpoints that allow paging, defaults to max value allowed

# METHODS

    [boolean] IsValidSession()
        Validates the AccessToken and RefreshToken are set on the object
        Checks that StartTime is not set to '0001-01-01 00:00:00'
        If WindowsAuth is the TokenType will return true

    [boolean] IsValidToken()
        Validates AccessToken is set
        Validates that TimeOfDeath is less than current time
        Validates that TimeOfDeath is not greater than current time
        If ExternalToken or WindowsAuth is the TokenType will return true

    [boolean] CheckTokenTtl( [int]Value )
        Checks the timespan for the TimeOfDeath and current datetime TotalMinutes is within the value. (TimeOfDeath - Now)
        If it is the method returns true, if not returns false.

    [boolean] SessionExpire()
        POST to oauth-expiration endpoint of Secret Server to expire the session
        for the current AccessToken
        If endpoint call fails will return false
        If WindowsAuth is TokenType will return false (unsupported)

    [boolean] SessionRefresh()
        Post to oauth2/token endpoint of Secret Server utilizing the RefreshToken
        to re-authenticate
        It will update the current object properties with the new associated values
        I endpoint call fails will return error
        If TokenType is ExternalToken or WindowsAuth will return false (unsupported)

# RELATED LINKS:
    New-TssSession