---
title: Start-TssLogCollection
parent: Diagnostics
grand_parent: Commands
---
# Start-TssLogCollection

## SYNOPSIS
Start a log collection

## SYNTAX

```
Start-TssLogCollection [-TssSession] <Session> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Starts collecting the logs of every web node and distributed engine, the same as the Collect Logs button under Admin, Diagnostics.
The request returns as soon as the collection is queued; poll Get-TssLogCollection for its progress.
Returns an object whose Success property is True when the collection was queued.
Requires the Administer Configuration permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Start-TssLogCollection -TssSession $session
Get-TssLogCollection -TssSession $session
```

Start a log collection, then check its progress

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Start-TssLogCollection](https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Start-TssLogCollection)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Start-TssLogCollection.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Start-TssLogCollection.ps1)
