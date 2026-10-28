---
title: Import-TssDiscoveryDependencyRule
parent: Discovery
grand_parent: Commands
---
# Import-TssDiscoveryDependencyRule

## SYNOPSIS
Import discovered dependencies

## SYNTAX

```
Import-TssDiscoveryDependencyRule [-TssSession] <Session> [-ChangePassword]
 [-DependencyPrivilegedAccountId <Int32>] [-FolderId <Int32>] -ItemId <Int32[]> [-NextPassword <SecureString>]
 [-Password <SecureString>] [-RandomPassword] [-RestartService] [-SecretDependencyTemplateId <Int32>]
 [-SecretNameFormat <String>] [-SecretPrivilegedAccount <Int32>] [-SecretTypeId <Int32>] [-SiteId <Int32>]
 [-SshKeySecretId <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Starts a bulk operation that creates secret dependencies for the discovered dependencies passed in ItemId, the same import Discovery dependency rules run.
Returns the bulk operation id.
When the account of a dependency has no active linked secret the import creates one, and the server then needs SecretTypeId, FolderId, SecretNameFormat and SiteId.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Import-TssDiscoveryDependencyRule -TssSession $session -ItemId 77 -SecretDependencyTemplateId 3 -DependencyPrivilegedAccountId 15 -SecretTypeId 6001 -FolderId 12 -SecretNameFormat '$DOMAIN\$USERNAME' -SiteId 1
```

Create a secret dependency for discovered dependency 77, with any secret it needs created in folder 12 on site 1

## PARAMETERS

### -TssSession
TssSession object created by New-TssSession for authentication

```yaml
Type: Session
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ChangePassword
Change the account password on import

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DependencyPrivilegedAccountId
Secret id of the privileged account the dependencies run with

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -FolderId
Folder where created secrets go, required when a secret is created

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ItemId
Discovered dependency ids to import

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NextPassword
New password to set when changing it without RandomPassword

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Password
Current account password to store in created secrets

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RandomPassword
Generate a random password when changing it

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -RestartService
Restart the service after a password change

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretDependencyTemplateId
Secret dependency template id for created dependencies

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretNameFormat
Pattern used to name created secrets: $ followed by a secret template field name is replaced by that field value, for example $DOMAIN\$USERNAME.
Required when a secret is created: the server fails each such item without it.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretPrivilegedAccount
Secret id of the privileged account used to change passwords

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretTypeId
Secret template id used when a secret is created for the dependency account, required when a secret is created

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SiteId
Site used for created secrets, required when a secret is created

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SshKeySecretId
Secret id of the SSH key used for the dependency

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Discovery.BulkOperation
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Import-TssDiscoveryDependencyRule](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Import-TssDiscoveryDependencyRule)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Import-TssDiscoveryDependencyRule.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Import-TssDiscoveryDependencyRule.ps1)
