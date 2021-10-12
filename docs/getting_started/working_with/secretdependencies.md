---
title: "Secret Dependencies"
sort: 3
---

These are example scripts that can work with Secret Dependencies individually or combined into building full workflow automation using the Thycotic.SecretServer module.

# Examples - Searching for Dependencies

You can search for the dependencies found on a given Secret to return all of them or pipe a list of Secrets to return the dependencies on all of them. These are example scripts that can be used individually or combined into building a full workflow automation using the Thycotic.SecretServer module.

# Examples - Dependencies

These examples relate to the functions around Secret Dependencies.

## Searching for a Dependencies

You can do a search for the dependencies found on a given Secret to return all of them, or pipe a list of Secrets to return the dependencies on all of them.

```powershell
$params = @{
    SecretServer = 'http://company.local/SecretServer'
    Credential = Get-Secret apidemo
}
$session = New-TssSession @params

# Retrieve dependencies on a single Secret
Search-TssSecretDependency -TssSession $session -Id 45

# Retrieve enabled and disabled Dependencies
Search-TssSecretDependency -TssSession $session -Id 42 -IncludeInactive

# Retrieve on a group of Secrets
Search-TssSecret -TssSession $session -FolderId 42 | Search-TssSecretDependency -TssSession $session
```

# Examples - Bulk Delete Dependencies

To delete the Dependencies on any given Secret first requires that you search for those Secrets. Pipeline support in the module allows you to stitch the functions together to delete **all** dependencies on each Secret.

Removing a Secret Dependency is not reversible. It will permanently delete the object.

> **Note** To get the enable and disabled dependencies, use the `-IncludeInactive` parameter shown in the examples below.

## Remove all based on Secret Template

## Bulk Delete Dependencies

To delete the Dependencies on any given Secret first requires that you search for those Secrets. Pipeline support in the module then allows you to stitch the functions together in order to delete **all** dependencies on each Secret.

> **Warning** Removing a Secret Dependency is not reversable, it will permanently delete the object.

> **Note** To remove enable and disabled use `-IncludeInactive` parameter as shown in below examples.

### Remove all based on Secret Template

```powershell
$params = @{
    SecretServer = 'http://company.local/SecretServer'
    Credential = Get-Secret apidemo
}
$session = New-TssSession @params

Search-TssSecret -TssSession $session -SecretTemplateId 6001 | Search-TssSecretDependency -TssSession $session -IncludeInactive -WarningAction SilentlyContinue | Remove-TssSecretDependency -TssSession $session -Confirm:$false
```

### Remove all based on Folder

```powershell
$params = @{
    SecretServer = 'http://company.local/SecretServer'
    Credential = Get-Secret apidemo
}
$session = New-TssSession @params

Search-TssSecret -TssSession $session -FolderId 42 | Search-TssSecretDependency -TssSession $session -IncludeInactive -WarningAction SilentlyContinue | Remove-TssSecretDependency -TssSession $session -Confirm:$false
```

# Examples - Find Duplicates

```powershell
$params = @{
    SecretServer = 'http://company.local/SecretServer'
    Credential = Get-Secret apidemo
}
$session = New-TssSession @params

$secretDependencies = Search-TssSecret -TssSession $session | Search-TssSecretDependency -TssSession $session -IncludeInactive -WarningAction SilentlyContinue
$secretDependencies | Group-Object -Property MachineName, ServiceName | Where-Object Count -gt 1 | Select-Object -Expand Group
```

## Sample Output

```console
SecretId Id GroupId Enabled Order MachineName ServiceName TypeName
-------- -- ------- ------- ----- ----------- ----------- --------
162      38 25      True    1     machine1    Service 1   Windows Service
163      39 26      True    1     machine1    Service 1   Windows Service
```