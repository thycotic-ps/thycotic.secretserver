class TssFolderTemplate {
    [int]$Id
    [string]$Name
    [int]$SecretCount
    [boolean]$Active
}

class TssFolder {
    [int]$Id
    [string]$FolderName
    [string]$FolderPath
    [int]$ParentFolderId
    [int]$FolderTypeId
    [int]$SecretPolicyId
    [boolean]$InheritSecretPolicy
}