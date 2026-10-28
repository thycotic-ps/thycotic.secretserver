---
title: Clear-TssQuartzJobError
parent: Diagnostics
grand_parent: Commands
---
# Clear-TssQuartzJobError

## SYNOPSIS
Clear the errors of the scheduled background jobs

## SYNTAX

```
Clear-TssQuartzJobError [-TssSession] <Session> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Resets the Quartz scheduler triggers that are in error so the background jobs run again, the same as the Clear Quartz Job Errors button under Admin, Diagnostics.
Returns True when the errors were cleared.
Requires the Administer Configuration permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Clear-TssQuartzJobError -TssSession $session
```

Clear the errors of the scheduled background jobs

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

Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Clear-TssQuartzJobError](https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Clear-TssQuartzJobError)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Clear-TssQuartzJobError.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Clear-TssQuartzJobError.ps1)
