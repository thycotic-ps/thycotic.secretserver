function Set-TssSecret {
    <#
    .SYNOPSIS
    Set a value for a given secret in Secret Server

    .DESCRIPTION
    Sets a secret property or field in Secret Server.

    .PARAMETER TssSession
    TssSession object created by New-TssSession

    .PARAMETER Id
    Secret ID to the property/field.

    .PARAMETER Comment
    Comment to provide for restricted secret (Require Comment is enabled)

    .PARAMETER Property
    Property name to set.

    .PARAMETER Field
    Field name to set

    .PARAMETER Value
    Value to set for field or property

    .PARAMETER Raw
    Output the raw response from the REST API endpoint

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Set-TssSecret -TssSession $session -Id 93 -Property Name -Value "Server2 admin account"

    Sets secret 93's property, "Name", to "Server2 admin account"

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Set-TssSecret -TssSession $session -Id 93 -Field Machine -Value "server2"

    Sets secret 93's field, "Machine", to "server2"

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Set-TssSecret -TssSession $session -Id 1455 -Property enableInheritPermissions -Value $false -Comment "disabling folder inheritance"

    Sets secret 1455's property, "enableInheritPermissions", to false and providing required comment

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Set-TssSecret -TssSession $session -Id 1455 -Field Notes -Value "to be decommissioned" -Comment "updating notes field"

    Sets secret 1455's field, "Notes", to the provided value providing required comment

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object passed for auth info
        [Parameter(Mandatory,ValueFromPipeline)]
        [TssSession]$TssSession,

        # Secret Id to modify
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("SecretId")]
        [int[]]
        $Id,

        # Provide comment for restricted secret
        [string]
        $Comment,

        [Parameter(ParameterSetName = "prop")]
        [Alias('PropertyName')]
        [string]
        $Property,

        [Parameter(ParameterSetName = "field")]
        [Alias('FieldName')]
        [string]
        $Field,

        [Parameter(ParameterSetName = "prop",Mandatory)]
        [Parameter(ParameterSetName = "field",Mandatory)]
        [string]
        $Value,

        # output the raw response from the API endpoint
        [switch]
        $Raw
    )
    begin {
        $tssParams = . $GetParams $PSBoundParameters 'Set-TssSecret'
        $invokeParams = @{ }
        $getSecretParams = @{ }
    }

    process {
        if ($tssParams.Contains('TssSession') -and $TssSession.IsValidSession()) {
            foreach ($secret in $Id) {
                if ($Property) {
                    $getSecretParams.TssSession = $TssSession
                    $getSecretParams.Id = $secret
                    $getSecretParams.Raw = $true
                    $getSecretParams.Comment = $Comment
                    $getSecretParams.WarningVariable = "warn"
                    $getSecretParams.WarningAction = "Stop"

                    $cSecret = Get-TssSecret @getSecretParams
                    if ($cSecret) {
                        $props = $cSecret.PSObject.Properties

                        if ($props["$Property"]) {
                            $cSecret.$Property = $Value
                        } else {
                            Write-Warning "Property [$Property] not found on secret [$secret]"
                            continue
                        }

                        $uri = $TssSession.SecretServer + ($TssSession.ApiVersion, "secrets", $secret.ToString() -join '/')

                        $invokeParams.Uri = $Uri
                        $invokeParams.PersonalAccessToken = $TssSession.AccessToken
                        $invokeParams.Body = ($cSecret | ConvertTo-Json)
                        $invokeParams.Method = 'PUT'

                        if (-not $PSCmdlet.ShouldProcess("$($invokeParams.Method) $uri with $($invokeParams.Body)")) { return }
                        try {
                            $restResponse = Invoke-TssRestApi @invokeParams -ErrorAction Stop -ErrorVariable err
                        } catch {
                            if ($apiError.errorCode) {
                                throw "$($apiError.errorCode): $($apiError.message)"
                            } elseif ($apiError.message) {
                                throw $apiError.message
                            } else {
                                throw $err
                            }
                        }

                        if ($Raw) {
                            $restResponse
                            continue
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
                }
                if ($Field) {
                    $uri = $TssSession.SecretServer + ($TssSession.ApiVersion, "secrets", $secret, "fields", $Field -join "/")

                    $body = "{'value': '$Value'}"
                    $invokeParams.Uri = $uri
                    $invokeParams.Body = $body
                    $invokeParams.PersonalAccessToken = $TssSession.AccessToken
                    $invokeParams.Method = 'PUT'

                    if (-not $PSCmdlet.ShouldProcess("$($invokeParams.Method) $uri with $($invokeParams.Body)")) { return }
                    try {
                        $restResponse = Invoke-TssRestApi @invokeParams -ErrorAction Stop -ErrorVariable err
                    } catch {
                        if ($apiError.errorCode) {
                            throw "$($apiError.errorCode): $($apiError.message)"
                        } elseif ($apiError.message) {
                            throw $apiError.message
                        } else {
                            throw $err
                        }
                    }

                    if ($Raw) {
                        $restResponse
                        continue
                    }
                    if ($restResponse) {
                        $getSecretParams.TssSession = $TssSession
                        $getSecretParams.Id = $secret
                        $getSecretParams.Comment = $Comment

                        Get-TssSecret @getSecretParams
                    }
                }
            }

        } else {
            Write-Warning "No valid session found"
        }
    }
}