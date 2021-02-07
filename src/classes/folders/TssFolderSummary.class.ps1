class TssFolderSummary {
    # folder name
    [string]$FolderName
    # folder path
    [string]$FolderPath
    # Folder Type Id (will always be 1 for secret folders)
    [int]$FolderTypeId
    # Folder Id
    [int]$Id
    # whether folder inherits permissions from parent
    [boolean]$InheritPermissions
    # whether folder inherits the secret policy
    [boolean]$InheritSecretPolicy
    # Parent Folder ID
    [int]$ParentFolderId
    # Secret Policy Id
    [int]$SecretPolicyId
}