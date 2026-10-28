---
title: Remove-TssSecretTemplateLauncher
parent: Secret Templates
grand_parent: Commands
---
# Remove-TssSecretTemplateLauncher

## SYNOPSIS
Remove a launcher from a secret template

## SYNTAX

```
Remove-TssSecretTemplateLauncher [-TssSession] <Session> -LauncherTypeId <Int32> -SecretTemplateId <Int32>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes a launcher type from a secret template, so secrets based on the template no longer offer that launcher.
The launcher type itself is not changed.
Returns Success.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssSecretTemplateLauncher -TssSession $session -SecretTemplateId 6007 -LauncherTypeId 2
```

Remove launcher type 2 from template 6007

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

### -LauncherTypeId
Launcher type ID to remove from the template

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SecretTemplateId
Secret template ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
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

### Thycotic.PowerShell.SecretTemplates.Result
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Remove-TssSecretTemplateLauncher](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Remove-TssSecretTemplateLauncher)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Remove-TssSecretTemplateLauncher.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Remove-TssSecretTemplateLauncher.ps1)
