---
title: Reset-TssPlatformUserMapping
parent: Platform
grand_parent: Commands
---
# Reset-TssPlatformUserMapping

## SYNOPSIS
Remove every Platform user mapping

## SYNTAX

```
Reset-TssPlatformUserMapping [-TssSession] <Session> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Delete every mapping between Delinea Platform users and Secret Server users.
This is instance-wide and cannot be undone; it is usually only needed before Platform integration is set up again.
Returns True.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Reset-TssPlatformUserMapping -TssSession $session -Confirm:$false
```

Remove every Platform user mapping without a confirmation prompt

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

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

Requires the Administer Platform Integration permission.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Reset-TssPlatformUserMapping](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Reset-TssPlatformUserMapping)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Reset-TssPlatformUserMapping.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Reset-TssPlatformUserMapping.ps1)
