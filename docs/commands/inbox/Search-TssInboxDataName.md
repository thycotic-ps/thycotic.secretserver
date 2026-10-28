---
title: Search-TssInboxDataName
parent: Inbox
grand_parent: Commands
---
# Search-TssInboxDataName

## SYNOPSIS
Search the inbox data names

## SYNTAX

```
Search-TssInboxDataName [-TssSession] <Session> [-MessageTypeId <Int32[]>]
 [<CommonParameters>]
```

## DESCRIPTION
Search the inbox data names (InboxDataId and InboxDataName) used by messages already sent.
Use an InboxDataId as the InboxDataId of New-TssInboxRuleCondition.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssInboxDataName -TssSession $session
```

Return every inbox data name

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssInboxDataName -TssSession $session -MessageTypeId 4
```

Return the data names used by inbox message type 4

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

### -MessageTypeId
Return only the data names used by these inbox message types (InboxMessageTypeId from Search-TssInboxMessageType)

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: InboxMessageTypeId

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

### Thycotic.PowerShell.Inbox.DataName[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Search-TssInboxDataName](https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Search-TssInboxDataName)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Search-TssInboxDataName.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Search-TssInboxDataName.ps1)
