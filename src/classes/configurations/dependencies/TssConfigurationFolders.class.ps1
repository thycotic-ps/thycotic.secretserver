class TssConfigurationFolders {
    [boolean]
    $EnablePersonalFolders

    [string]
    $PersonalFolderName

    [ValidateSet('DisplayName','UsernameAndDomain')]
    [string]
    $PersonalFolderNameOption

    [string]
    $PersonalFolderWarning

    [boolean]
    $RequireViewFolderPermission

    [boolean]
    $ShowPersonalFolderWarning
}