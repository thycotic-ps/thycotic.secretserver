class TssUser {
    [Nullable[datetime]]
    $AdAccountExpires

    [string]
    $AdGuid

    [Nullable[datetime]]
    $Created

    [int]
    $DateOptionId

    [string]
    $DisplayName

    [int]
    $DomainId

    [boolean]
    $DuoTwoFactor

    [string]
    $EmailAddress

    [boolean]
    $Enabled

    [boolean]
    $Fido2TwoFactor

    [int]
    $Id

    [boolean]
    $IsApplicationAccount

    [boolean]
    $IsEmailCopiedFromAD

    [boolean]
    $IsEmailVerified

    [boolean]
    $IsLockedOut

    [Nullable[datetime]]
    $LastLogin

    [Nullable[datetime]]
    $LastSessionActivity

    [string]
    $LockOutReason

    [string]
    $LockOutReasonDescription

    [int]
    $LoginFailures

    [boolean]
    $MustVerifyEmail

    [boolean]
    $OathTwoFactor

    [boolean]
    $OathVerified

    [Nullable[datetime]]
    $PasswordLastChanged

    [boolean]
    $RadiusTwoFactor

    [string]
    $RadiusUserName

    [Nullable[datetime]]
    $ResetSessionStarted

    [int]
    $TimeOptionId

    [boolean]
    $TwoFactor

    [ValidateSet('Password','PublicKey','PassordOrPublicKey','PasswordAndPublicKey')]
    [string]
    $UnixAuthenticationMethod

    [int]
    $UserLcid

    [string]
    $Username

    [Nullable[datetime]]
    $VerifyEmailSentDate
}