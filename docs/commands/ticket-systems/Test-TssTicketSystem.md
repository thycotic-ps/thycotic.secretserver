---
title: Test-TssTicketSystem
parent: Ticket Systems
grand_parent: Commands
---
# Test-TssTicketSystem

## SYNOPSIS
Test a ticket number against a ticket system

## SYNTAX

```
Test-TssTicketSystem [-TssSession] <Session> -Id <Int32> -TicketNumber <String>
 [<CommonParameters>]
```

## DESCRIPTION
Checks a sample ticket number the way Secret Server checks one on an access request: against the validation regular expression, or through the ServiceNow, BMC Remedy or PowerShell integration.
Inactive ticket systems are tested too; nothing is saved.
Returns Success False with the reason in ErrorMessage when the ticket number is rejected.
Requires the Administer Configuration permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Test-TssTicketSystem -TssSession $session -Id 3 -TicketNumber 'CHG0012345'
```

Check whether ticket system 3 accepts ticket number CHG0012345

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
Type: Int32
Parameter Sets: (All)
Aliases: TicketSystemId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TicketNumber
Ticket number to test

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.TicketSystems.TestResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ticket-systems/Test-TssTicketSystem](https://thycotic-ps.github.io/thycotic.secretserver/commands/ticket-systems/Test-TssTicketSystem)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ticket-systems/Test-TssTicketSystem.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ticket-systems/Test-TssTicketSystem.ps1)
