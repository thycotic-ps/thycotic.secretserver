---
title: Stop-TssBulkOperation
parent: Bulk Operations
grand_parent: Commands
---
# Stop-TssBulkOperation

## SYNOPSIS
Stop a running bulk operation

## SYNTAX

```
Stop-TssBulkOperation [-TssSession] <Session> -Id <String> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Stop a running bulk operation by its task identifier and return the operation.
A stopped operation cannot be resumed; items already processed stay changed.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Stop-TssBulkOperation -TssSession $session -Id 7792fb1d-9e2b-4378-b3d2-07894e38999b
```

Stop the bulk operation with that task identifier

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssBulkOperation -TssSession $session -Status Running | Stop-TssBulkOperation -TssSession $session
```

Stop every running bulk operation

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
Task identifier (GUID) of the bulk operation: TaskIdentifier from Get-TssBulkOperation, or BulkOperationId from the bulk cmdlets

```yaml
Type: String
Parameter Sets: (All)
Aliases: TaskIdentifier, TaskId, BulkOperationId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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

### Thycotic.PowerShell.BulkOperations.BulkOperation
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-operations/Stop-TssBulkOperation](https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-operations/Stop-TssBulkOperation)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-operations/Stop-TssBulkOperation.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-operations/Stop-TssBulkOperation.ps1)
