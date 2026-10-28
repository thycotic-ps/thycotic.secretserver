---
title: Set-TssConfigurationPermissionOption
parent: Configurations
grand_parent: Commands
---
# Set-TssConfigurationPermissionOption

## SYNOPSIS
Set the permission options configuration

## SYNTAX

```
Set-TssConfigurationPermissionOption [-TssSession] <Session> [-AllowDuplicateSecretNamesOptionType <String>]
 [-AllowViewUserToRetrieveAutoChangeNextPassword] [-DefaultSecretPermissions <String>]
 [-EnableApprovalFromEmail] [-ForceSecretApproval <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the permission options configuration (default secret permissions, duplicate secret names, secret approval) and returns the updated configuration.
Only the parameters you pass are sent; everything else keeps its current value.
Switch parameters send their value, so -Name:$false turns a setting off.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssConfigurationPermissionOption -TssSession $session -DefaultSecretPermissions 'InheritsPermissions' -AllowDuplicateSecretNamesOptionType 'PreventInSameFolder'
```

New secrets inherit folder permissions, and secret names must be unique within a folder

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

### -AllowDuplicateSecretNamesOptionType
Whether or not Secrets can have the same name in public folders or different personal folders

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

### -AllowViewUserToRetrieveAutoChangeNextPassword
Users with View permission on a secret can see its next password

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

### -DefaultSecretPermissions
Permissions a new secret gets

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

### -EnableApprovalFromEmail
Allow users to approve by clicking on a link in email

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

### -ForceSecretApproval
Approval required on secrets that use approval

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

### Thycotic.PowerShell.Configuration.ConfigurationPermissionOptions
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssConfigurationPermissionOption](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssConfigurationPermissionOption)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssConfigurationPermissionOption.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssConfigurationPermissionOption.ps1)
