---
title: Search-TssTicketSystem
parent: Ticket Systems
grand_parent: Commands
---
# Search-TssTicketSystem

## SYNOPSIS
Search ticket systems

## SYNTAX

### Default (Default)
```
Search-TssTicketSystem [-TssSession] <Session> [-IncludeInactive]
 [<CommonParameters>]
```

### V2
```
Search-TssTicketSystem [-TssSession] <Session> [-IncludeInactive] [-V2]
 [<CommonParameters>]
```

### Legacy
```
Search-TssTicketSystem [-TssSession] <Session> [-IncludeInactive] [-Legacy]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the ticket systems used with secret access requests and secret view comments: name, type, ticket number requirement, default and override settings.
Active ticket systems only, unless -IncludeInactive is used.
Use Get-TssTicketSystem for the integration settings of one ticket system.
-V2 uses the version 2 route (same output) and -Legacy the version 1 route, which returns only the ID, name, description, URL pattern, display message, requirement, type ID, active and default properties.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssTicketSystem -TssSession $session
```

List the active ticket systems

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssTicketSystem -TssSession $session -IncludeInactive | Where-Object IsDefault
```

Find the default ticket system

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

### -IncludeInactive
Include inactive ticket systems

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

### -V2
Use the version 2 route (same output)

```yaml
Type: SwitchParameter
Parameter Sets: V2
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Legacy
Use the version 1 route, which returns fewer properties

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

### Thycotic.PowerShell.TicketSystems.Summary[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ticket-systems/Search-TssTicketSystem](https://thycotic-ps.github.io/thycotic.secretserver/commands/ticket-systems/Search-TssTicketSystem)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ticket-systems/Search-TssTicketSystem.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ticket-systems/Search-TssTicketSystem.ps1)
