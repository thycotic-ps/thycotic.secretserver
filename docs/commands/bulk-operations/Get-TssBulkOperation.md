---
title: Get-TssBulkOperation
parent: Bulk Operations
grand_parent: Commands
---
# Get-TssBulkOperation

## SYNOPSIS
Get a bulk operation

## SYNTAX

```
Get-TssBulkOperation [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Get a bulk operation by its numeric ID: name, category, status, item counts, the users who started and stopped it, start and end dates, and its task identifier.
Get-TssBulkOperationProgress and Stop-TssBulkOperation take the task identifier (TaskIdentifier), not this ID.
Users without the Administer Bulk Operations permission see only the operations they started.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssBulkOperation -TssSession $session -Id 12
```

Get bulk operation 12

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssBulkOperation -TssSession $session -Status Running | Get-TssBulkOperation -TssSession $session
```

Get the details of every running bulk operation

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

### Thycotic.PowerShell.BulkOperations.BulkOperation
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-operations/Get-TssBulkOperation](https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-operations/Get-TssBulkOperation)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-operations/Get-TssBulkOperation.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-operations/Get-TssBulkOperation.ps1)
