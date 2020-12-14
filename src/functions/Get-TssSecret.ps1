function Get-TssSecret {
    <#
    .SYNOPSIS
    Get a secret from Secret Server

    .DESCRIPTION
    Get a secret(s) from Secret Server

    .PARAMETER TssSession
    TssSession object created by New-TssSession

    .PARAMETER Id
    Secret ID to retrieve, accepts an array of IDs

    .PARAMETER Comment
    Comment to provide for restricted secret (Require Comment is enabled)

    .PARAMETER Raw
    Output the raw response from the REST API endpoint

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Get-TssSecret -TssSession $session -Id 93

    Returns secret associated with the Secret ID, 93

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Get-TssSecret -TssSession $session -Id 1723 -Comment "Accessing application Y"

    Returns secret associated with the Secret ID, 1723, providing required comment

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding()]
    param(
        # TssSession object passed for auth info
        [Parameter(Mandatory,ValueFromPipeline)]
        [TssSession]$TssSession,

        # Return only specific Secret, Secret Id
        [Parameter(Mandatory,ValueFromPipelineByPropertyName,ParameterSetName = "norm")]
        [Alias("SecretId")]
        [int[]]
        $Id,

        # Provide comment for restricted secret
        [string]
        $Comment,

        # output the raw response from the API endpoint
        [switch]
        $Raw
    )
    begin {
        $tssParams = . $GetParams $PSBoundParameters 'Get-TssSecret'
        $invokeParams = @{ }
    }

    process {
        if ($tssParams.Contains('TssSession') -and $TssSession.IsValidSession()) {
            foreach ($secret in $Id) {
                $restResponse = $null
                $uri = $TssSession.SecretServer + ($TssSession.ApiVersion, "secrets", $secret.ToString() -join '/')
                if ($Comment) {
                    $uri = $uri, "restricted" -join "/"
                    $body = "{'comment':'$Comment', 'includeInactive':'$true'}"
                    $invokeParams.Uri = $Uri
                    $invokeParams.Method = 'POST'
                    $invokeParams.Body = $body
                } else {
                    $uri = $uri, "includeInactive=true" -join "?"
                    $invokeParams.Uri = $Uri
                    $invokeParams.Method = 'GET'
                }

                $invokeParams.PersonalAccessToken = $TssSession.AccessToken
                $restResponse = Invoke-TssRestApi @invokeParams

                if ($Raw) {
                    return $restResponse
                }
                if ($restResponse) {
                    $outSecret = [PSCustomObject]@{
                        PSTypeName                         = 'TssSecret'
                        Id                                 = $restResponse.id
                        Name                               = $restResponse.name
                        SecretTemplateId                   = $restResponse.secretTemplateId
                        SecretTemplateName                 = $restResponse.secretTemplateName
                        FolderId                           = if ($restResponse.folderId -eq -1) { $null } else { $restResponse.folderId }
                        Active                             = $restResponse.active
                        LauncherConnectSecretId            = if ($restResponse.launcherConnectAsSecretId -eq -1) { $null } else { $restResponse.launcherConnectAsSecretId }
                        IsRestricted                       = $restResponse.isRestricted
                        IsOutOfSync                        = $restResponse.isOutOfSync
                        OutOfSyncReason                    = $restResponse.outOfSyncReason
                        AutoChangeEnabled                  = $restResponse.autoChangeEnabled
                        AutoChangeNextPassword             = $restResponse.AutoChangeNextPassword
                        RequiresApprovalForAccess          = $restResponse.requiresApprovalForAccess
                        RequiresComment                    = $restResponse.requiresComment
                        CheckedOut                         = $restResponse.checkedOut
                        CheckoutEnabled                    = $restResponse.checkOutEnabled
                        CheckoutUserId                     = if ($restResponse.checkOutUserId -eq -1) { $null } else { $restResponse.checkOutUserId }
                        CheckoutUserDisplayName            = if ($restResponse.checkOutUserDisplayName -eq -1) { $null } else { $restResponse.checkOutUserDisplayName }
                        CheckoutIntervalMinutes            = if ($restResponse.CheckoutIntervalMinutes -eq -1) { $null } else { $restResponse.checkOutIntervalMinutes }
                        CheckoutChangePassword             = $restResponse.checkOutChangePasswordEnabled
                        AccessRequestWorkflowMapId         = if ($restResponse.accessRequestWorkflowMapId -eq -1) { $null } else { $restResponse.accessRequestWorkflowMapId }
                        ProxyEnabled                       = $restResponse.proxyEnabled
                        SessionRecordingEnabled            = $restResponse.sessionRecordingEnabled
                        RestrictSshCommands                = $restResponse.restrictSshCommands
                        AllowOwnersUnrestrictedSshCommands = $restResponse.allowOwnersUnrestrictedSshCommands
                        IsDoubleLock                       = $restResponse.isDoubleLock
                        DoubleLockId                       = if ($restResponse.doubleLockId -eq -1) { $null } else { $restResponse.doubleLockId }
                        EnableInheritsPermissions          = $restResponse.enableInheritPermissions
                        EnableInheritsSecretPolicy         = if ($restResponse.enableInheritSecretPolicy -eq -1) { $null } else { $restResponse.enableInheritSecretPolicy }
                        SiteId                             = $restResponse.siteId
                        SecretPolicyId                     = if ($restResponse.secretPolicyId -eq -1) { $null } else { $restResponse.secretPolicyId }
                        LastHeartbeatStatus                = $restResponse.lastHeartBeatStatus
                        LastHeartbeatCheck                 = [datetime]$restResponse.lastHeartBeatCheck
                        FailedPasswordChangeAttempts       = $restResponse.failedPasswordChangeAttempts
                        LastPasswordChangeAttempt          = [datetime]$restResponse.lastPasswordChangeAttempt
                        PasswordTypeWebscriptId            = if ($restResponse.passwordTypeWebScriptId -eq -1) { $null } else { $restResponse.passwordTypeWebScriptId }
                    }

                    $items = foreach ($itemDetail in $restResponse.items) {
                        [pscustomobject]@{
                            PSTypeName       = 'TssSecretItem'
                            ItemId           = $itemDetail.itemId
                            ItemValue        = $itemDetail.itemValue
                            FieldId          = $itemDetail.fieldId
                            FieldName        = $itemDetail.fieldName
                            Slug             = $itemDetail.slug
                            FieldDescription = $itemDetail.fieldDescription
                            IsFile           = $itemDetail.isFile
                            FileAttachmentId = $itemDetail.fileAttachmentId
                            FileName         = $itemDetail.fileName
                            IsNotes          = $itemDetail.isNotes
                            IsPassword       = $itemDetail.isPassword
                        }
                    }
                    $outSecret.PSObject.Properties.Add([PSNoteProperty]::new('Items',$items))
                    $outSecret
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}