class TssSecret {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingConvertToSecureStringWithPlainText', '', Scope = 'Class')]
    [int]
    $AccessRequestWorkflowMapId

    [boolean]
    $Active

    [boolean]
    $AllowOwnersUnrestrictedSshCommands

    [boolean]
    $AutoChangeEnabled

    [string]
    $AutoChangeNextPassword

    [boolean]
    $CheckedOut

    [boolean]
    $CheckOutChangePasswordEnabled

    [boolean]
    $CheckOutEnabled

    [int]
    $CheckOutIntervalMinutes

    [int]
    $CheckOutMinutesRemaining

    [string]
    $CheckOutUserDisplayName

    [int]
    $CheckOutUserId

    [int]
    $DoubleLockId

    [boolean]
    $EnableInheritPermissions

    [boolean]
    $EnableInheritSecretPolicy

    [int]
    $FailedPasswordChangeAttempts

    [int]
    $FolderId

    [int]
    $Id

    [boolean]
    $IsDoubleLock

    [boolean]
    $IsOutOfSync

    [boolean]
    $IsRestricted

    [TssSecretItem[]]
    $Items

    [datetime]
    $LastHeartBeatCheck

    [ValidateSet('Failed','Success','Pending','Disabled','UnableToConnect','UnknownError','IncompatibleHost','AccountLockedOut','DnsMismatch','UnableToValidateServerPublicKey','Processing','ArgumentError','AccessDenied')]
    [string]
    $LastHeartBeatStatus

    [datetime]
    $LastPasswordChangeAttempt

    [int]
    $LauncherConnectAsSecretId

    [string]
    $Name

    [string]
    $OutOfSyncReason

    [int]
    $PasswordTypeWebScriptId

    [boolean]
    $ProxyEnabled

    [boolean]
    $RequiresApprovalForAccess

    [boolean]
    $RequiresComment

    [boolean]
    $RestrictSshCommands

    [int]
    $SecretPolicyId

    [int]
    $SecretTemplateId

    [string]
    $SecretTemplateName

    [boolean]
    $SessionRecordingEnabled

    [int]
    $SiteId

    [boolean]
    $WebLauncherRequiresIncognitoMode

    hidden
    [string[]]
    $ResponseCodes

    [System.Management.Automation.PSCredential]
    GetCredential([string]$DomainField, [string]$UserField, [string]$PwdField) {
        $domain = ($this.Items.Where( { $_.FieldName -eq $DomainField })).ItemValue
        $username = ($this.Items.Where( { $_.FieldName -eq $UserField })).ItemValue
        $passwd = ($this.Items.Where( { $_.FieldName -eq $PwdField })).ItemValue
        return [pscredential]::new((($domain,$username -join '\').Trim('\')),(ConvertTo-SecureString -AsPlainText -Force -String $passwd))
    }

    [System.String]
    GetFieldValue([string]$Slug) {
        $value = $this.Items.Where( { $_.Slug -eq $Slug }).ItemValue
        return $value
    }

    [void]
    SetFieldValue([string]$Slug,$NewValue) {
        foreach ($i in $this.Items) {
            if ($i.Slug -eq $Slug) {
                $i.ItemValue = $NewValue
            }
        }
    }

    [pscustomobject]
    GetFileFields() {
        $files = @()
        foreach ($i in $this.Items) {
            if ($i.IsFile) {
                $fileInfo = [pscustomobject]@{
                    SecretId = $this.Id
                    SlugName = $i.Slug
                    Filename = $i.Filename
                }
                $files += $fileInfo
            }
        }
        return $files
    }
}