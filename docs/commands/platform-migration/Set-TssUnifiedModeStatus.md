---
title: Set-TssUnifiedModeStatus
parent: Platform Migration
grand_parent: Commands
---
# Set-TssUnifiedModeStatus

## SYNOPSIS
Set the Platform unified mode status

## SYNTAX

```
Set-TssUnifiedModeStatus [-TssSession] <Session> -Status <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Set the unified mode status recorded for the Platform migration, for example to clear a stale InProgress status.
Returns Success.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssUnifiedModeStatus -TssSession $session -Status NotStarted
```

Reset the unified mode status to NotStarted

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

### -Status
New status: NotStarted, Started, InProgress, Completed, CompletedWithErrors or UnresolvedError

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
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

### Thycotic.PowerShell.PlatformMigration.OperationResult
## NOTES
Requires TssSession object returned by New-TssSession

Requires Platform integration: a Secret Server without it answers 500 API_PlatformNotEnabled.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Set-TssUnifiedModeStatus](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Set-TssUnifiedModeStatus)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Set-TssUnifiedModeStatus.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Set-TssUnifiedModeStatus.ps1)
