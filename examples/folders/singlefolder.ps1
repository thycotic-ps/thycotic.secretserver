Import-Module Thycotic.SecretServer

$sessionParams = @{
    SecretServer = 'http://prod/SecretServer'
    Credential = Get-Credential
}
$session = New-TssSession @sessionParams

New-TssFolder -TssSession $session -FolderName 'A root folder' -Verbose