---
title: Search-TssBulkOperation
parent: Bulk Operations
grand_parent: Commands
---
# Search-TssBulkOperation

## SYNOPSIS
Search bulk operations

## SYNTAX

```
Search-TssBulkOperation [-TssSession] <Session> [-BulkOperationName <String>] [-Category <String>]
 [-StartUserId <Int32>] [-Status <String>] [<CommonParameters>]
```

## DESCRIPTION
Search bulk operations by name, category, status, or the user who started them.
With no filter, lists every bulk operation.
Users without the Administer Bulk Operations role permission see only the operations they started: the server replaces -StartUserId with their own user ID.
The Administrator role does not include that permission by default.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssBulkOperation -TssSession $session
```

List every bulk operation

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssBulkOperation -TssSession $session -Category User -Status Error
```

List the user bulk operations that ended in error

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

### -BulkOperationName
Filter by bulk operation name

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

### -Category
Filter by the type of item the operation acts on

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

### -StartUserId
Filter by the ID of the user who started the operation.
Applied only when the caller holds the Administer Bulk Operations role permission; otherwise the server returns the caller's own operations.

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

### -Status
Filter by operation status

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.BulkOperations.BulkOperation[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-operations/Search-TssBulkOperation](https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-operations/Search-TssBulkOperation)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-operations/Search-TssBulkOperation.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-operations/Search-TssBulkOperation.ps1)
