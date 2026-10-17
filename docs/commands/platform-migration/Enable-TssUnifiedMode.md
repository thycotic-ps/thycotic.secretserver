---
title: Enable-TssUnifiedMode
parent: Platform Migration
grand_parent: Commands
---
# Enable-TssUnifiedMode

## SYNOPSIS
Enable Platform unified mode

## SYNTAX

```
Enable-TssUnifiedMode [-TssSession] <Session> [-AllowCompleteWithErrors]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Enable unified mode, which makes Secret Server read identities from the Delinea Platform.
Secret Server documents this endpoint as internal use only: enabling it before the Platform migration is complete can cause unwanted results.
Follow progress with Get-TssUnifiedModeProgress.
Returns Success.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Enable-TssUnifiedMode -TssSession $session
Get-TssUnifiedModeProgress -TssSession $session
```

Enable unified mode and check its progress

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

### -AllowCompleteWithErrors
Complete even when some objects failed to migrate

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

### Thycotic.PowerShell.PlatformMigration.OperationResult
## NOTES
Requires TssSession object returned by New-TssSession

Requires Platform integration: a Secret Server without it answers 500 API_PlatformNotEnabled.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Enable-TssUnifiedMode](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Enable-TssUnifiedMode)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Enable-TssUnifiedMode.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Enable-TssUnifiedMode.ps1)
