function Set-TssConfigurationPermissionOption {
    <#
    .SYNOPSIS
    Set the permission options configuration

    .DESCRIPTION
    Updates the permission options configuration (default secret permissions, duplicate secret names, secret approval) and returns the updated configuration.
    Only the parameters you pass are sent; everything else keeps its current value. Switch parameters send their value, so -Name:$false turns a setting off.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER AllowDuplicateSecretNamesOptionType
    Whether or not Secrets can have the same name in public folders or different personal folders

    .PARAMETER AllowViewUserToRetrieveAutoChangeNextPassword
    Users with View permission on a secret can see its next password

    .PARAMETER DefaultSecretPermissions
    Permissions a new secret gets

    .PARAMETER EnableApprovalFromEmail
    Allow users to approve by clicking on a link in email

    .PARAMETER ForceSecretApproval
    Approval required on secrets that use approval

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssConfigurationPermissionOption -TssSession $session -DefaultSecretPermissions 'InheritsPermissions' -AllowDuplicateSecretNamesOptionType 'PreventInSameFolder'

    New secrets inherit folder permissions, and secret names must be unique within a folder

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssConfigurationPermissionOption

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssConfigurationPermissionOption.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUsernameAndPasswordParams', '', Justification = 'Setting names from the REST model, not a credential pair')]
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.ConfigurationPermissionOptions')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [ValidateSet('Never', 'Always', 'PreventInPublicFolders', 'PreventInSameFolder')]
        [string]
        $AllowDuplicateSecretNamesOptionType,

        [switch]
        $AllowViewUserToRetrieveAutoChangeNextPassword,

        [ValidateSet('InheritsPermissions', 'CopyFromFolder', 'OnlyAllowCreator')]
        [string]
        $DefaultSecretPermissions,

        [switch]
        $EnableApprovalFromEmail,

        [ValidateSet('None', 'RequireApprovalForOwnersAndEditors', 'RequireApprovalForEditors')]
        [string]
        $ForceSecretApproval
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v2'), 'configuration', 'permission-options' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'AllowDuplicateSecretNamesOptionType' {
                    $body.data.Add('allowDuplicateSecretNamesOptionType', @{ dirty = $true; value = $AllowDuplicateSecretNamesOptionType })
                }
                'AllowViewUserToRetrieveAutoChangeNextPassword' {
                    $body.data.Add('allowViewUserToRetrieveAutoChangeNextPassword', @{ dirty = $true; value = [boolean]$AllowViewUserToRetrieveAutoChangeNextPassword })
                }
                'DefaultSecretPermissions' {
                    $body.data.Add('defaultSecretPermissions', @{ dirty = $true; value = $DefaultSecretPermissions })
                }
                'EnableApprovalFromEmail' {
                    $body.data.Add('enableApprovalFromEmail', @{ dirty = $true; value = [boolean]$EnableApprovalFromEmail })
                }
                'ForceSecretApproval' {
                    $body.data.Add('forceSecretApproval', @{ dirty = $true; value = $ForceSecretApproval })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Configuration permission option", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssConfigurationPermissionOption request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.ConfigurationPermissionOptions](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.ConfigurationPermissionOptions]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
