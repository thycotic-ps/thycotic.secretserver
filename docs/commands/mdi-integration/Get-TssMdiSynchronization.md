---
title: Get-TssMdiSynchronization
parent: Mdi Integration
grand_parent: Commands
---
# Get-TssMdiSynchronization

## SYNOPSIS
Get the MDI synchronization status

## SYNTAX

```
Get-TssMdiSynchronization [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get the status of the current or last Microsoft Defender for Identity (MDI) synchronization: start and end time, estimated progress, error count and the next scheduled run.
Returns nothing when no synchronization has run.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssMdiSynchronization -TssSession $session
```

Show the MDI synchronization status

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.MdiIntegration.Synchronization
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server Cloud only: an on-premises Secret Server answers this endpoint with Access denied.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/mdi-integration/Get-TssMdiSynchronization](https://thycotic-ps.github.io/thycotic.secretserver/commands/mdi-integration/Get-TssMdiSynchronization)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/mdi-integration/Get-TssMdiSynchronization.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/mdi-integration/Get-TssMdiSynchronization.ps1)
