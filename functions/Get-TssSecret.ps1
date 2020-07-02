function Get-TssSecret {
    [cmdletbinding()]
    param(
        # Return only specific Secret, Secret Id
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("SecretId")]
        [int[]]
        $Id,

        # Only grab a specific item name from the Secret ID
        [Alias('Items')]
        [string]
        $Item,

        # output the raw response from the API endpoint
        [switch]
        $Raw
    )
    begin {
        $invokeParams = @{ }
    }

    process {
        . $TestTssSession -Session

        foreach ($sid in $Id) {
            $uri = $TssSession.SecretServerUrl, $TssSession.ApiVersion, "secrets", $sid.ToString() -join '/'

            $invokeParams.Uri = $Uri
            $invokeParams.PersonalAccessToken = $TssSession.AuthToken
            $invokeParams.Method = 'GET'
            $restResponse = Invoke-TssRestApi @invokeParams
            if ($Raw) {
                return $restResponse
            } else {
                $outSecret = [PSCustomObject]@{
                    SecretId = $restResponse.id
                    TemplateId = $restResponse.secretTemplateId
                    FolderId = if ($restResponse.folderId -eq -1) { $null } else { $restResponse.folderId }
                    Active = $restResponse.active
                    LauncherConnectSecretId = if ($restResponse.launcherConnectAsSecretId -eq -1) { $null } else { $restResponse.launcherConnectAsSecretId }
                    Restricted = $restResponse.isRestricted
                    OutOfSync = $restResponse.isOutOfSync
                    OutOfSyncReason = $restResponse.outOfSyncReason
                    AutoChangeEnabled = $restResponse.autoChangeEnabled
                    AutoChangeNextPassword = $restResponse.AutoChangeNextPassword
                    ApprovalForAccessRequired = $restResponse.requiresApprovalForAccess
                    CommentRequired = $restResponse.requiresComment
                    Checkout = $restResponse.checkOutEnabled
                    CheckoutUserId = if ($restResponse.checkOutUserId -eq -1) { $null } else { $restResponse.checkOutUserId }
                    CheckoutIntervalMinutes = if ($restResponse.CheckoutIntervalMinutes -eq -1) { $null } else { $restResponse.checkOutIntervalMinutes }
                    CheckoutChangePassword = $restResponse.checkOutChangePasswordEnabled
                    AccessRequestWorkflowMapId = if ($restResponse.accessRequestWorkflowMapId -eq -1) { $null } else { $restResponse.accessRequestWorkflowMapId }
                    Proxy = $restResponse.proxyEnabled
                    SessionRecording = $restResponse.sessionRecordingEnabled
                    SSHCommandsRestricted = $restResponse.restrictSshCommands
                    SSHCommandsOwnersUnrestricted = $restResponse.allowOwnersUnrestrictedSshCommands
                    DoubleLock = $restResponse.isDoubleLock
                    DoubleLockId = if ($restResponse.doubleLockId -eq -1) { $null } else { $restResponse.doubleLockId }
                    InheritPermissions = $restResponse.enableInheritPermissions
                    InheritSecretPolicy = if ($restResponse.enableInheritSecretPolicy -eq -1) { $null } else { $restResponse.enableInheritSecretPolicy }
                    SiteId = $restResponse.siteId
                    SecretPolicyId = if ($restResponse.secretPolicyId -eq -1) { $null } else { $restResponse.secretPolicyId }
                    HeartbeatStatus = $restResponse.lastHeartBeatStatus
                    HeartbeatDate = [datetime]$restResponse.lastHeartBeatCheck
                    PasswordChangeFailedCount = $restResponse.failedPasswordChangeAttempts
                    PasswordChangeDate = [datetime]$restResponse.lastPasswordChangeAttempt
                    TemplateName = $restResponse.secretTemplateName
                }
                foreach ($itemDetail in $restResponse.items) {
                    $name = $itemDetail.fieldName
                    $value = $itemDetail.itemValue
                    $outSecret.PSObject.Properties.Add([PSNoteProperty]::new($name,$value))
                }
                $properties = $outSecret.PSObject.Properties | Sort-Object Name
                $final = [PSCustomObject]@{}
                foreach ($prop in $properties) {
                    $final.PSObject.Properties.Add([PSNoteProperty]::new($prop.Name,$prop.Value))
                }
                $final
            }
        }
    }
}