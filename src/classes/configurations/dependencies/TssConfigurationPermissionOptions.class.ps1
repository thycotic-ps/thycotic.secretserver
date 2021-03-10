class TssConfigurationPermissionOptions {
    [boolean]
    $AllowDuplicateSecretNames

    [boolean]
    $AllowViewUserToRetrieveAutoChangeNextPassword

    [ValidateSet('InheritsPermissions','CopyFromFolder','OnlyAllowCreator')]
    [string]
    $DefaultSecretPermissions

    [boolean]
    $EnableApprovalFromEmail

    [ValidateSet('None','RequireApprovalForOwnersAndEditors','RequireApprovalForEditors')]
    [string]
    $ForceSecretApproval
}