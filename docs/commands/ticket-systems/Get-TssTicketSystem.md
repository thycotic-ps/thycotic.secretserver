---
title: Get-TssTicketSystem
parent: Ticket Systems
grand_parent: Commands
---
# Get-TssTicketSystem

## SYNOPSIS
Get a ticket system

## SYNTAX

### Default (Default)
```
Get-TssTicketSystem [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

### Legacy
```
Get-TssTicketSystem [-TssSession] <Session> -Id <Int32[]> [-Legacy]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the full settings of a ticket system: type, ticket number requirement and validation, override approval settings and the ServiceNow, BMC Remedy and PowerShell integration fields.
Use -Legacy for the shorter version 1 shape, where the type and the ticket number requirement are numeric IDs.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssTicketSystem -TssSession $session -Id 3
```

Get the settings of ticket system 3

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssTicketSystem -TssSession $session -IncludeInactive | Get-TssTicketSystem -TssSession $session | Select-Object Name, TicketSystemType, Active, EnableTicketOverride
```

List the type and override setting of every ticket system

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

### -Id
Ticket system ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: TicketSystemId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Legacy
Use the version 1 route, which returns the shorter Summary shape with numeric type and requirement IDs

```yaml
Type: SwitchParameter
Parameter Sets: Legacy
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.TicketSystems.TicketSystem
### Thycotic.PowerShell.TicketSystems.Summary
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ticket-systems/Get-TssTicketSystem](https://thycotic-ps.github.io/thycotic.secretserver/commands/ticket-systems/Get-TssTicketSystem)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ticket-systems/Get-TssTicketSystem.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ticket-systems/Get-TssTicketSystem.ps1)
