---
title: Get-TssBulkOperationProgress
parent: Bulk Operations
grand_parent: Commands
---
# Get-TssBulkOperationProgress

## SYNOPSIS
Get the progress of a bulk operation

## SYNTAX

```
Get-TssBulkOperationProgress [-TssSession] <Session> -Id <String[]>
 [<CommonParameters>]
```

## DESCRIPTION
Get the progress of a bulk operation by its task identifier (a GUID): percentage complete, status message, completion flag, and per-item errors.
Move-TssSecret, Invoke-TssBulkSecretAction, Invoke-TssBulkUserAction, Set-TssUserTwoFactor, Enable-TssBulkPasswordChanger and Disable-TssBulkPasswordChanger return the task identifier as BulkOperationId, so their output pipes here.
An unknown task identifier returns an incomplete progress object (0 percent), not an error.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssBulkOperationProgress -TssSession $session -Id 7792fb1d-9e2b-4378-b3d2-07894e38999b
```

Get the progress of the bulk operation with that task identifier

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Move-TssSecret -TssSession $session -Id 42, 43 -FolderId 7 | Get-TssBulkOperationProgress -TssSession $session
```

Move secrets 42 and 43 to folder 7, then check the progress of the move

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
Task identifier (GUID) of the bulk operation: BulkOperationId from the bulk cmdlets, or TaskIdentifier from Get-TssBulkOperation

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: TaskIdentifier, TaskId, BulkOperationId

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

### Thycotic.PowerShell.BulkOperations.Progress
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-operations/Get-TssBulkOperationProgress](https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-operations/Get-TssBulkOperationProgress)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-operations/Get-TssBulkOperationProgress.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-operations/Get-TssBulkOperationProgress.ps1)
