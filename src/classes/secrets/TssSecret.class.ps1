class TssSecretItem {
    [string]$FieldDescription
    [int]$FieldId
    [string]$FieldName
    [int]$FileAttachmentId
    [string]$Filename
    [boolean]$IsFile
    [boolean]$IsNotes
    [boolean]$IsPassword
    [int]$ItemId
    [string]$ItemValue
    [string]$Slug

    [boolean] SetFieldValue([string]$Slug,$Value) {
        if ($this.Slug -eq $Slug) {
            $this.ItemValue = $Value
        }
        return $true
    }
}

class TssSecret {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingConvertToSecureStringWithPlainText', '', Scope = 'Class')]
    [int]$AccessRequestWorkflowMapId
    [boolean]$Active
    [boolean]$AllowOwnersUnrestrictedSshCommands
    [boolean]$AutoChangeEnabled
    [string]$AutoChangeNextPassword
    [boolean]$CheckedOut
    [boolean]$CheckOutChangePasswordEnabled
    [boolean]$CheckOutEnabled
    [int]$CheckOutIntervalMinutes
    [int]$CheckOutMinutesRemaining
    [string]$CheckOutUserDisplayName
    [int]$CheckOutUserId
    [int]$DoubleLockId
    [boolean]$EnableInheritPermissions
    [boolean]$EnableInheritSecretPolicy
    [int]$FailedPasswordChangeAttempts
    [int]$FolderId
    [int]$Id
    [boolean]$IsDoubleLock
    [boolean]$IsOutOfSync
    [boolean]$IsRestricted
    [TssSecretItem[]]$Items
    [datetime]$LastHeartBeatCheck
    [ValidateSet('Failed','Success','Pending','Disabled','UnableToConnect','UnknownError','IncompatibleHost','AccountLockedOut','DnsMismatch','UnableToValidateServerPublicKey','Processing','ArgumentError','AccessDenied')]
    [string]$LastHeartBeatStatus
    [datetime]$LastPasswordChangeAttempt
    [int]$LauncherConnectAsSecretId
    [string]$Name
    [string]$OutOfSyncReason
    [int]$PasswordTypeWebScriptId
    [boolean]$ProxyEnabled
    [boolean]$RequiresApprovalForAccess
    [boolean]$RequiresComment
    [boolean]$RestrictSshCommands
    [int]$SecretPolicyId
    [int]$SecretTemplateId
    [string]$SecretTemplateName
    [boolean]$SessionRecordingEnabled
    [int]$SiteId
    [boolean]$WebLauncherRequiresIncognitoMode

    [System.Management.Automation.PSCredential] GetCredential() {
        $username = ($this.Items | Where-Object FieldName -EQ 'username').ItemValue
        $passwd = ($this.Items | Where-Object IsPassword).ItemValue
        return [pscredential]::new($username,(ConvertTo-SecureString -AsPlainText -Force -String $passwd))
    }
    [System.String] GetFieldValue([string]$Slug) {
        $value = $this.Items.Where( { $_.Slug -eq $Slug }).ItemValue
        return $value
    }
}