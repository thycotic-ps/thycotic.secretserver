class TssSecretItem {
    [string]$fieldDescription
    [int]$fieldId
    [string]$fieldName
    [int]$fileAttachmentId
    [string]$filename
    [boolean]$isFile
    [boolean]$isNotes
    [boolean]$isPassword
    [int]$itemId
    [string]$itemValue
    [string]$slug
}

class TssSecret {

    [int]$Id
    [string]$Name
    [int]$FolderId
    [boolean]$Active
    [int]$SecretTemplateId
    [string]$SecretTemplateName
    [int]$SiteId
    [boolean]$CheckedOut
    [datetime]$LastHeartBeatCheck
    [string]$LastHeartBeatStatus
    [datetime]$LastPasswordChangeAttempt
    [int]$AccessRequestWorkflowMapId
    [boolean]$AllowOwnersUnrestrictedSshCommands
    [boolean]$AutoChangeEnabled
    [string]$AutoChangeNextPassword
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
    [boolean]$IsDoubleLock
    [boolean]$IsOutOfSync
    [boolean]$IsRestricted
    [int]$LauncherConnectAsSecretId
    [string]$OutOfSyncReason
    [int]$PasswordTypeWebScriptId
    [boolean]$ProxyEnabled
    [boolean]$RequiresApprovalForAccess
    [boolean]$RequiresComment
    [boolean]$RestrictSshCommands
    [int]$SecretPolicyId
    [boolean]$SessionRecordingEnabled
    [TssSecretItem[]]$Items

    [System.Management.Automation.PSCredential] GetCredential()
    {
        $username = ($this.Items | Where-Object FieldName -eq 'username').ItemValue
        $passwd = ($this.Items | Where-Object IsPassword).ItemValue
        return [pscredential]::new($username,(ConvertTo-SecureString -AsPlainText -Force -String $passwd))
    }
}