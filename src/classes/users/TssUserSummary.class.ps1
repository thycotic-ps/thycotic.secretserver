class TssUserSummary {
    [datetime]
    $Created

    [string]
    $DisplayName

    [int]
    $DomainId

    [string]
    $DomainName

    [string]
    $EmailAddress

    [boolean]
    $Enabled

    [int]
    $Id

    [boolean]
    $IsApplicationAccount

    [boolean]
    $IsLockedOut

    [datetime]
    $LastLogin

    [int]
    $LoginFailures

    [string]
    $Username
    
    [ValidateSet('None', 'Radius', 'TOTPAuthenticator', 'Duo', 'Fido2', 'Email')]
    [string]
    $TwoFactorMethod
}