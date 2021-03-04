class TssUser {
    [datetime]
    $AdAccountExpires

    [string]
    $AdGuid

    [datetime]
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

    [datetime]
    $LastLogin

    [datetime]
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

    [datetime]
    $PasswordLastChanged

    [boolean]
    $RadiusTwoFactor

    [string]
    $RadiusUserName

    [datetime]
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

    [datetime]
    $VerifyEmailSentDate
}