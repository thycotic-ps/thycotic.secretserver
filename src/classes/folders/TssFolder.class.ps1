class TssFolder {
    [int]
    $Id

    [string]
    $FolderName

    [string]
    $FolderPath

    [int]
    $ParentFolderId

    [int]
    $FolderTypeId

    [int]
    $SecretPolicyId

    [boolean]
    $InheritSecretPolicy

    [boolean]
    $InheritPermissions

    [TssFolder[]]
    $ChildFolders

    [TssFolderTemplate[]]
    $SecretTemplates
}