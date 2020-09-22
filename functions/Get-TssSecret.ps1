function Get-TssSecret {
    <#
    .SYNOPSIS
    Get a secret from Secret Server

    .DESCRIPTION
    Get a secret(s) from Secret Server

    .PARAMETER Id
    Secret ID to retrieve, accepts an array of IDs

    .PARAMETER Comment
    Comment to provide for restricted secret (Require Comment is enabled)

    .PARAMETER Raw
    Output the raw response from the REST API endpoint

    .EXAMPLE
    PS C:\> Get-TssSecret -Id 93

    Returns secret associated with the Secret ID, 93

    .EXAMPLE
    PS C:\> Get-TssSecret -Id 1723 -Comment "Accessing application Y"

    Returns secret associated with the Secret ID, 1723, providing required comment

    .NOTES
    Requires New-TssSession session be set
    #>
    [cmdletbinding()]
    param(
        # Return only specific Secret, Secret Id
        [Parameter(Mandatory,ValueFromPipelineByPropertyName,ParameterSetName="norm")]
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
        $invokeParams = @{ }
    }

    process {
        . $TestTssSession -Session

        foreach ($secret in $Id) {
            $restResponse = $null
            $errorResponse = $null
            $uri = $TssSession.SecretServerUrl, $TssSession.ApiVersion, "secrets", $secret.ToString() -join '/'
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
            try {
                $restResponse = Invoke-TssRestApi @invokeParams -ErrorAction Stop
            } catch {
                $errorResponse = $_.ErrorDetails.Message | ConvertFrom-Json
            }

            if ($Raw -and $restResponse) {
                $restResponse
            } elseif ($restResponse -and -not $restResponse.code) {
                $outSecret = [PSCustomObject]@{
                    SecretId                      = $restResponse.id
                    SecretName                    = $restResponse.name
                    TemplateId                    = $restResponse.secretTemplateId
                    FolderId                      = if ($restResponse.folderId -eq -1) { $null } else { $restResponse.folderId }
                    Status                        = if ($restResponse.active) { "Active" } else { "Inactive" }
                    LauncherConnectSecretId       = if ($restResponse.launcherConnectAsSecretId -eq -1) { $null } else { $restResponse.launcherConnectAsSecretId }
                    Restricted                    = $restResponse.isRestricted
                    OutOfSync                     = $restResponse.isOutOfSync
                    OutOfSyncReason               = $restResponse.outOfSyncReason
                    AutoChangeEnabled             = $restResponse.autoChangeEnabled
                    AutoChangeNextPassword        = $restResponse.AutoChangeNextPassword
                    ApprovalForAccessRequired     = $restResponse.requiresApprovalForAccess
                    CommentRequired               = $restResponse.requiresComment
                    CheckedOut                    = $restResponse.checkedOut
                    CheckoutEnabled               = $restResponse.checkOutEnabled
                    CheckoutUserId                = if ($restResponse.checkOutUserId -eq -1) { $null } else { $restResponse.checkOutUserId }
                    CheckoutUserName              = if ($restResponse.checkOutUserDisplayName -eq -1) { $null } else { $restResponse.checkOutUserDisplayName }
                    CheckoutIntervalMinutes       = if ($restResponse.CheckoutIntervalMinutes -eq -1) { $null } else { $restResponse.checkOutIntervalMinutes }
                    CheckoutChangePassword        = $restResponse.checkOutChangePasswordEnabled
                    AccessRequestWorkflowMapId    = if ($restResponse.accessRequestWorkflowMapId -eq -1) { $null } else { $restResponse.accessRequestWorkflowMapId }
                    Proxy                         = $restResponse.proxyEnabled
                    SessionRecording              = $restResponse.sessionRecordingEnabled
                    SSHCommandsRestricted         = $restResponse.restrictSshCommands
                    SSHCommandsOwnersUnrestricted = $restResponse.allowOwnersUnrestrictedSshCommands
                    DoubleLockEnabled             = $restResponse.isDoubleLock
                    DoubleLockId                  = if ($restResponse.doubleLockId -eq -1) { $null } else { $restResponse.doubleLockId }
                    InheritsPermissions            = $restResponse.enableInheritPermissions
                    InheritsSecretPolicy           = if ($restResponse.enableInheritSecretPolicy -eq -1) { $null } else { $restResponse.enableInheritSecretPolicy }
                    SiteId                        = $restResponse.siteId
                    SecretPolicyId                = if ($restResponse.secretPolicyId -eq -1) { $null } else { $restResponse.secretPolicyId }
                    HeartbeatStatus               = $restResponse.lastHeartBeatStatus
                    HeartbeatDate                 = [datetime]$restResponse.lastHeartBeatCheck
                    PasswordChangeFailedCount     = $restResponse.failedPasswordChangeAttempts
                    PasswordChangeAttempt         = [datetime]$restResponse.lastPasswordChangeAttempt
                    TemplateName                  = $restResponse.secretTemplateName
                    PasswordTypeWebscriptId       = if ($restResponse.passwordTypeWebScriptId -eq -1) { $null } else { $restResponse.passwordTypeWebScriptId }
                }
                foreach ($itemDetail in $restResponse.items) {
                    $name = $itemDetail.fieldName
                    $value = $itemDetail.itemValue
                    $outSecret.PSObject.Properties.Add([PSNoteProperty]::new($name,$value))
                }
                $properties = $outSecret.PSObject.Properties | Sort-Object Name
                $final = [PSCustomObject]@{ }
                foreach ($prop in $properties) {
                    $final.PSObject.Properties.Add([PSNoteProperty]::new($prop.Name,$prop.Value))
                }
                $final
            }

            if ($errorResponse) {
                Write-Warning -Message "Issue retrieving secret [$secret]: $($errorResponse.message)"
            }
            if ($restResponse.code) {
                Write-Warning -Message "Issue retrieving secret [$secret]: $($restResponse.message)"
            }
        }
    }
}