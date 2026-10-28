---
title: Invoke-TssBulkSecretAction
parent: Bulk Secret Operations
grand_parent: Commands
---
# Invoke-TssBulkSecretAction

## SYNOPSIS
Run a bulk action on secrets

## SYNTAX

```
Invoke-TssBulkSecretAction [-TssSession] <Session> -Id <Int32[]> -Action <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Run one bulk action on one or more secrets: activate, deactivate, turn auto change, checkout, heartbeat, hide launcher password or require view comment on or off, run heartbeat, or turn permission inheritance on.
Each call sends one request for all the secrets passed to -Id.
The operation runs in the background: pipe the output (BulkOperationId is the task identifier) to Get-TssBulkOperationProgress to follow it.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Invoke-TssBulkSecretAction -TssSession $session -Id 42, 43 -Action Deactivate
```

Deactivate secrets 42 and 43

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Invoke-TssBulkSecretAction -TssSession $session -Id 42, 43 -Action RunHeartbeat | Get-TssBulkOperationProgress -TssSession $session
```

Run a heartbeat on secrets 42 and 43, then check the progress

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
IDs of the secrets to act on

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

### -Action
Bulk action to run: Activate, Deactivate, EnableAutoChange, DisableAutoChange, EnableCheckout, DisableCheckout, EnableHeartbeat, DisableHeartbeat, RunHeartbeat, EnableHideLauncherPassword, DisableHideLauncherPassword, EnableRequireViewComment, DisableRequireViewComment, EnableInheritPermissions

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-secret-operations/Invoke-TssBulkSecretAction](https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-secret-operations/Invoke-TssBulkSecretAction)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-secret-operations/Invoke-TssBulkSecretAction.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-secret-operations/Invoke-TssBulkSecretAction.ps1)
