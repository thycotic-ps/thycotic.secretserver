---
title: Disable-TssBulkPasswordChanger
parent: Bulk Password Changer Operations
grand_parent: Commands
---
# Disable-TssBulkPasswordChanger

## SYNOPSIS
Disable password changers in bulk

## SYNTAX

```
Disable-TssBulkPasswordChanger [-TssSession] <Session> -Id <Int32[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Disable one or more Remote Password Changing password changers in one bulk operation.
The operation runs in the background: pipe the output (BulkOperationId is the task identifier) to Get-TssBulkOperationProgress to follow it.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Disable-TssBulkPasswordChanger -TssSession $session -Id 3, 4, 5
```

Disable password changers 3, 4 and 5

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
IDs of the password changers to disable

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: PasswordChangerId

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-password-changer-operations/Disable-TssBulkPasswordChanger](https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-password-changer-operations/Disable-TssBulkPasswordChanger)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-password-changer-operations/Disable-TssBulkPasswordChanger.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-password-changer-operations/Disable-TssBulkPasswordChanger.ps1)
