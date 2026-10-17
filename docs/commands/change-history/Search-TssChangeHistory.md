---
title: Search-TssChangeHistory
parent: Change History
grand_parent: Commands
---
# Search-TssChangeHistory

## SYNOPSIS
Search the change history of an audited item

## SYNTAX

```
Search-TssChangeHistory [-TssSession] <Session> [-AuditId <Int32>] -AuditType <String> [-FieldName <String>]
 -ItemId <Int32> [<CommonParameters>]
```

## DESCRIPTION
Returns the field level change history Secret Server keeps for an audited item, such as a site, secret template or group: the field that changed, its new value, and who changed it and when.
The server requires both AuditType and ItemId.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssChangeHistory -TssSession $session -AuditType Site -ItemId 1
```

Get the change history of the site with Id 1

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssChangeHistory -TssSession $session -AuditType SecretTemplate -ItemId 6001 -FieldName Name
```

Get the name changes of secret template 6001

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

### -AuditId
Return only the changes recorded with this audit entry (AuditId of a Search-TssSharedAudit result)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -AuditType
Type of the audited item

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

### -FieldName
Return only the changes to this field

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ItemId
Id of the audited item

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.ChangeHistory.Entry[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/change-history/Search-TssChangeHistory](https://thycotic-ps.github.io/thycotic.secretserver/commands/change-history/Search-TssChangeHistory)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/change-history/Search-TssChangeHistory.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/change-history/Search-TssChangeHistory.ps1)
