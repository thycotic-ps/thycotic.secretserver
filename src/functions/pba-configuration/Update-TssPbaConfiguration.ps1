function Update-TssPbaConfiguration {
    <#
    .SYNOPSIS
    Update the Privilege Behavior Analytics (PBA) configuration

    .DESCRIPTION
    Updates PBA integration settings. Only the parameters you pass are changed; everything else is left as it is.
    RetentionDays, EventDataUploadInterval, EventDataUploadSizeThreshold, EncryptionEnabled and StorageDirectoryPath are applied only when file upload is enabled, either already or by -FileUploadEnabled in the same call. Otherwise the server ignores them without an error.
    On Secret Server Cloud the server ignores FileUploadEnabled, the five file upload settings above, ChallengeLockoutIntegratedEnabled and SiteId without an error, and ignores MetadataInterval while it is 60, the cloud default.
    Returns the updated configuration.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ChallengeEnabled
    Enable or disable PBA challenges

    .PARAMETER ChallengeLockoutIntegratedEnabled
    Enable or disable challenge lockout for integrated Windows logins. Ignored on Secret Server Cloud

    .PARAMETER ChallengeLockoutSamlEnabled
    Enable or disable challenge lockout for SAML logins

    .PARAMETER Enabled
    Enable or disable the PBA integration

    .PARAMETER EncryptionEnabled
    Enable or disable encryption of uploaded event data. Applied only when file upload is enabled

    .PARAMETER EventDataUploadInterval
    Event data upload interval, 2 to 60. Applied only when file upload is enabled

    .PARAMETER EventDataUploadSizeThreshold
    Event data upload size threshold, 500 to 1000000. Applied only when file upload is enabled

    .PARAMETER ExternalPbaUrl
    URL of the PBA instance

    .PARAMETER FileUploadEnabled
    Enable or disable file upload of event data. Ignored on Secret Server Cloud

    .PARAMETER MetadataInterval
    Metadata sync interval. On Secret Server Cloud ignored while the current interval is 60, the cloud default

    .PARAMETER PbaIntegrationKey
    PBA integration key. Never written to Verbose or WhatIf output

    .PARAMETER RespectOwnerEditorRequireApprovalEnabled
    Enable or disable respecting owner and editor require-approval settings

    .PARAMETER RetentionDays
    Days to keep PBA event data, 2 or more. Applied only when file upload is enabled

    .PARAMETER SiteId
    Id of the site used for PBA. Ignored on Secret Server Cloud

    .PARAMETER StorageDirectoryPath
    Directory where PBA event data is stored. Applied only when file upload is enabled

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssPbaConfiguration -TssSession $session -MetadataInterval 120

    Sets the metadata sync interval to 120

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssPbaConfiguration -TssSession $session -FileUploadEnabled -StorageDirectoryPath 'D:\PbaData' -RetentionDays 14

    Turns on file upload of event data, stores it in D:\PbaData and keeps it 14 days

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssPbaConfiguration -TssSession $session -ChallengeEnabled:$false

    Turns PBA challenges off

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/pba-configuration/Update-TssPbaConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/pba-configuration/Update-TssPbaConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Requires the Administer Security Analytics permission and a Privilege Behavior Analytics license; otherwise the server returns 403.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.PbaConfiguration.Configuration')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $ChallengeEnabled,

        [switch]
        $ChallengeLockoutIntegratedEnabled,

        [switch]
        $ChallengeLockoutSamlEnabled,

        [switch]
        $Enabled,

        [switch]
        $EncryptionEnabled,

        [int]
        $EventDataUploadInterval,

        [int]
        $EventDataUploadSizeThreshold,

        [string]
        $ExternalPbaUrl,

        [switch]
        $FileUploadEnabled,

        [int]
        $MetadataInterval,

        [securestring]
        $PbaIntegrationKey,

        [switch]
        $RespectOwnerEditorRequireApprovalEnabled,

        [int]
        $RetentionDays,

        [int]
        $SiteId,

        [string]
        $StorageDirectoryPath
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'pba-configuration' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'ChallengeEnabled' {
                    $body.data.Add('challengeEnabled', @{ dirty = $true; value = [boolean]$ChallengeEnabled })
                }
                'ChallengeLockoutIntegratedEnabled' {
                    $body.data.Add('challengeLockoutIntegratedEnabled', @{ dirty = $true; value = [boolean]$ChallengeLockoutIntegratedEnabled })
                }
                'ChallengeLockoutSamlEnabled' {
                    $body.data.Add('challengeLockoutSamlEnabled', @{ dirty = $true; value = [boolean]$ChallengeLockoutSamlEnabled })
                }
                'Enabled' {
                    $body.data.Add('enabled', @{ dirty = $true; value = [boolean]$Enabled })
                }
                'EncryptionEnabled' {
                    $body.data.Add('encryptionEnabled', @{ dirty = $true; value = [boolean]$EncryptionEnabled })
                }
                'EventDataUploadInterval' {
                    $body.data.Add('eventDataUploadInterval', @{ dirty = $true; value = $EventDataUploadInterval })
                }
                'EventDataUploadSizeThreshold' {
                    $body.data.Add('eventDataUploadSizeThreshold', @{ dirty = $true; value = $EventDataUploadSizeThreshold })
                }
                'ExternalPbaUrl' {
                    $body.data.Add('externalPbaUrl', @{ dirty = $true; value = $ExternalPbaUrl })
                }
                'FileUploadEnabled' {
                    $body.data.Add('fileUploadEnabled', @{ dirty = $true; value = [boolean]$FileUploadEnabled })
                }
                'MetadataInterval' {
                    $body.data.Add('metadataInterval', @{ dirty = $true; value = $MetadataInterval })
                }
                'PbaIntegrationKey' {
                    $body.data.Add('pbaIntegrationKey', @{ dirty = $true; value = [System.Net.NetworkCredential]::new('', $PbaIntegrationKey).Password })
                }
                'RespectOwnerEditorRequireApprovalEnabled' {
                    $body.data.Add('respectOwnerEditorRequireApprovalEnabled', @{ dirty = $true; value = [boolean]$RespectOwnerEditorRequireApprovalEnabled })
                }
                'RetentionDays' {
                    $body.data.Add('retentionDays', @{ dirty = $true; value = $RetentionDays })
                }
                'SiteId' {
                    $body.data.Add('siteId', @{ dirty = $true; value = $SiteId })
                }
                'StorageDirectoryPath' {
                    $body.data.Add('storageDirectoryPath', @{ dirty = $true; value = $StorageDirectoryPath })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Pba configuration", "$($invokeParams.Method) $uri (request body not shown: it carries sensitive values)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssPbaConfiguration request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.PbaConfiguration.Configuration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.PbaConfiguration.Configuration]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
