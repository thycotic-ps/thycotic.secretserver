---
title: Move-TssSecret
parent: Bulk Secret Operations
grand_parent: Commands
---
# Move-TssSecret

## SYNOPSIS
Move secrets to a folder

## SYNTAX

```
Move-TssSecret [-TssSession] <Session> -FolderId <Int32> [-RetainPermissionInheritance] -Id <Int32[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Move one or more secrets to a folder in one bulk operation.
Moved secrets inherit permissions from the target folder unless -RetainPermissionInheritance is set.
The operation runs in the background: pipe the output (BulkOperationId is the task identifier) to Get-TssBulkOperationProgress to follow it.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Move-TssSecret -TssSession $session -Id 42 -FolderId 7
```

Move secret 42 to folder 7

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Move-TssSecret -TssSession $session -Id 42, 43 -FolderId 7 -RetainPermissionInheritance | Get-TssBulkOperationProgress -TssSession $session
```

Move secrets 42 and 43 to folder 7 keeping their permission inheritance setting, then check the progress

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

### -FolderId
ID of the folder to move the secrets to

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

### -RetainPermissionInheritance
Keep each secret's current permission inheritance setting instead of inheriting from the target folder

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
IDs of the secrets to move

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SecretId

Required: True
Position: Named
Default value: None
Accept pipeline input: False
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

### Thycotic.PowerShell.BulkOperations.Response
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-secret-operations/Move-TssSecret](https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-secret-operations/Move-TssSecret)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-secret-operations/Move-TssSecret.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-secret-operations/Move-TssSecret.ps1)
