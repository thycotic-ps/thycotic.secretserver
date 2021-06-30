Import-Module Thycotic.SecretServer

$sessionParams = @{
    SecretServer = 'http://prod/SecretServer'
    Credential = Get-Credential
}
$session = New-TssSession @sessionParams

$rootFolder = Search-TssFolder -TssSession $session -SearchText 'A root folder'
$group = Search-TssGroup -TssSession $session -SearchText 'Group 1'

$folderPermParams = @{
    TssSession = $session
    FolderId = $rootFolder.Id
    GroupId = $group.GroupId
    FolderAccessRoleName = 'Edit'
    SecretAccessRoleName = 'Owner'
}
New-TssFolderPermission @folderPermParams