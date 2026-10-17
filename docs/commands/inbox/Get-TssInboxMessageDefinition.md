---
title: Get-TssInboxMessageDefinition
parent: Inbox
grand_parent: Commands
---
# Get-TssInboxMessageDefinition

## SYNOPSIS
Get the inbox message definitions

## SYNTAX

```
Get-TssInboxMessageDefinition [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get the inbox message definitions: each message name with the data property names its messages carry.
Inbox rule conditions and templates refer to these property names.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssInboxMessageDefinition -TssSession $session | Where-Object MessageName -like '*Checkout*'
```

Return the definitions of the checkout messages and their property names

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

### Thycotic.PowerShell.Inbox.MessageDefinition[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Get-TssInboxMessageDefinition](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Get-TssInboxMessageDefinition)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Get-TssInboxMessageDefinition.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Get-TssInboxMessageDefinition.ps1)
