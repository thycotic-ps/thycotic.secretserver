Import-Module Thycotic.SecretServer

$sessionParams = @{
    SecretServer = 'http://prod/SecretServer'
    Credential = Get-Credential
}
$session = New-TssSession @sessionParams

$rootFolder = Search-TssFolder -TssSession $session -SearchText 'A root folder'

$newFolderParams = @{
    TssSession = $session
    FolderName = 'A child folder'
    ParentFolderId = $rootFolder.Id
    InheritPermissions = $true
}
New-TssFolder @newFolderParams -Verbose