---
title: Search-TssSharedAudit
parent: Shared Audits
grand_parent: Commands
---
# Search-TssSharedAudit

## SYNOPSIS
Search the audit entries of an audited item

## SYNTAX

```
Search-TssSharedAudit [-TssSession] <Session> -AuditType <String> -ItemId <Int32>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the audit entries Secret Server keeps for an audited item, such as a site, secret template or group: the action, who did it, when, from which IP address and machine, and how many field changes it made (ChangesetCount).
The server requires both AuditType and ItemId.
Search-TssChangeHistory returns the field changes of an entry.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSharedAudit -TssSession $session -AuditType Site -ItemId 1
```

Get the audit entries of the site with Id 1

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSharedAudit -TssSession $session -AuditType Group -ItemId 3 | Sort-Object DateRecorded -Descending | Select-Object -First 5
```

Get the five most recent audit entries of the group with Id 3

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

### Thycotic.PowerShell.SharedAudits.SharedAudit[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/shared-audits/Search-TssSharedAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/shared-audits/Search-TssSharedAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/shared-audits/Search-TssSharedAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/shared-audits/Search-TssSharedAudit.ps1)
