---
title: Start-TssMdiSynchronization
parent: Mdi Integration
grand_parent: Commands
---
# Start-TssMdiSynchronization

## SYNOPSIS
Start an MDI synchronization

## SYNTAX

```
Start-TssMdiSynchronization [-TssSession] <Session> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Start a Microsoft Defender for Identity (MDI) synchronization now.
Returns True when the synchronization was queued.
The integration must be configured and consented first.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Start-TssMdiSynchronization -TssSession $session
Get-TssMdiSynchronization -TssSession $session
```

Start an MDI synchronization, then check its progress

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

Secret Server Cloud only: an on-premises Secret Server answers this endpoint with Access denied.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/mdi-integration/Start-TssMdiSynchronization](https://thycotic-ps.github.io/thycotic.secretserver/commands/mdi-integration/Start-TssMdiSynchronization)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/mdi-integration/Start-TssMdiSynchronization.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/mdi-integration/Start-TssMdiSynchronization.ps1)
