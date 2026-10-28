---
title: Get-TssLogCollection
parent: Diagnostics
grand_parent: Commands
---
# Get-TssLogCollection

## SYNOPSIS
Get the status of the log collection

## SYNTAX

```
Get-TssLogCollection [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Gets the log collection status shown under Admin, Diagnostics: when the last collection started (StartDate) and one LogCollection item per web node or distributed engine with its status (Collecting, Done or Failed).
Start a collection with Start-TssLogCollection.
Requires the Administer Configuration or View Configuration permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssLogCollection -TssSession $session
```

Get the log collection status

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssLogCollection -TssSession $session).LogCollection | Where-Object Status -EQ Failed
```

List the nodes and engines whose log collection failed

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

### Thycotic.PowerShell.Diagnostics.LogCollectionSummary
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Get-TssLogCollection](https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Get-TssLogCollection)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Get-TssLogCollection.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Get-TssLogCollection.ps1)
