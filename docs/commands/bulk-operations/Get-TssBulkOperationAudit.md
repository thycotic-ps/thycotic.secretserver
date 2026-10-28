---
title: Get-TssBulkOperationAudit
parent: Bulk Operations
grand_parent: Commands
---
# Get-TssBulkOperationAudit

## SYNOPSIS
Get the audit records of a bulk operation

## SYNTAX

```
Get-TssBulkOperationAudit [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Get the per-item audit records of a bulk operation: the action, the affected secret or user, the date, and notes.
Users without the Administer Bulk Operations permission see only the operations they started.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssBulkOperationAudit -TssSession $session -Id 12
```

Get the audit records of bulk operation 12

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssBulkOperation -TssSession $session -Category Secret | Get-TssBulkOperationAudit -TssSession $session
```

Get the audit records of every secret bulk operation

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
Bulk operation ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: BulkOperationId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.BulkOperations.Audit[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-operations/Get-TssBulkOperationAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-operations/Get-TssBulkOperationAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-operations/Get-TssBulkOperationAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-operations/Get-TssBulkOperationAudit.ps1)
