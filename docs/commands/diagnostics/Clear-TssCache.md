---
title: Clear-TssCache
parent: Diagnostics
grand_parent: Commands
---
# Clear-TssCache

## SYNOPSIS
Clear the Secret Server application cache

## SYNTAX

```
Clear-TssCache [-TssSession] <Session> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Clears the Secret Server application cache without an IIS reset, the same as the Clear Cache button under Admin, Diagnostics.
Use it when templates, sites or configuration settings look stale after a change made outside the application.
Active user sessions are not affected.
Returns an object whose Success property is True when the cache was cleared.
Requires the Administer Configuration permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Clear-TssCache -TssSession $session
```

Clear the application cache

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

### Thycotic.PowerShell.Diagnostics.OperationResult
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Clear-TssCache](https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Clear-TssCache)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Clear-TssCache.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Clear-TssCache.ps1)
