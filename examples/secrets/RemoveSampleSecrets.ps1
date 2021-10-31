Import-Module .\src\Thycotic.SecretServer.psd1
$ssUrl = 'https://tenant.secretservercloud.com'
$folderId = 85

$session = New-TssSession -SecretServer $ssUrl -Credential $cred

# find all Secrets where the Secret ID is divisible by 3 (this should get around 50 Secrets)
$secrets = Search-TssSecret -TssSession $session -FolderId $folderId -IncludeSubFolders | Where-Object { $_.SecretId % 3 -eq 0 }

# output Secrets found
$secrets

# Perform WhatIf to verify what Secrets will be removed
Remove-TssSecret -TssSession $session -Id $secrets.SecretId -WhatIf

# Remove the Secrets
$removedSecrets = Remove-TssSecret -TssSession $session -Id $secrets.SecretId
if ($removedSecrets.Count -eq $secrets.Count) { Write-Output "All Secrets removed" }