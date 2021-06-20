---
sort: 3
---

# Working with Secret Dependencies

These are example scripts that can work with Secret Dependencies individually or combined into building full workflow automation using the Thycotic.SecretServer module.

# Examples - Searching for Dependencies

You can search for the dependencies found on a given Secret to return all of them or pipe a list of Secrets to return the dependencies on all of them. These are example scripts that can be used individually or combined into building a full workflow automation using the Thycotic.SecretServer module.

# Examples - Dependencies

These examples relate to the functions around Secret Dependencies.

## Searching for a Dependencies

You can do a search for the dependencies found on a given Secret to return all of them, or pipe a list of Secrets to return the dependencies on all of them.

```powershell
$params = @{
    SecretServer = 'http://argos/SecretServer'
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
{: .notice--warning}

To get the enable and disabled dependencies, use the `-IncludeInactive` parameter shown in the examples below.
{: .notice--info}

## Remove all based on Secret Template

## Bulk Delete Dependencies

To delete the Dependencies on any given Secret first requires that you search for those Secrets. Pipeline support in the module then allows you to stitch the functions together in order to delete **all** dependencies on each Secret.

Removing a Secret Dependency is not reversable, it will permanently delete the object.
{: .notice--warning}

To remove enable and disabled use `-IncludeInactive` parameter as shown in below examples.
{: .notice--info}

### Remove all based on Secret Template

```powershell
$params = @{
    SecretServer = 'http://argos/SecretServer'
    Credential = Get-Secret apidemo
}
$session = New-TssSession @params

Search-TssSecret -TssSession $session -SecretTemplateId 6001 | Search-TssSecretDependency -TssSession $session -IncludeInactive -WarningAction SilentlyContinue | Remove-TssSecretDependency -TssSession $session -Confirm:$false
```

## Remove all based on Folder

```powershell
$params = @{
    SecretServer = 'http://argos/SecretServer'
    Credential = Get-Secret apidemo
}
$session = New-TssSession @params

Search-TssSecret -TssSession $session -FolderId 42 | Search-TssSecretDependency -TssSession $session -IncludeInactive -WarningAction SilentlyContinue | Remove-TssSecretDependency -TssSession $session -Confirm:$false
```
