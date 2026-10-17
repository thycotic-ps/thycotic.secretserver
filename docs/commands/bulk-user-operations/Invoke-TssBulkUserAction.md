---
title: Invoke-TssBulkUserAction
parent: Bulk User Operations
grand_parent: Commands
---
# Invoke-TssBulkUserAction

## SYNOPSIS
Run a bulk action on users

## SYNTAX

```
Invoke-TssBulkUserAction [-TssSession] <Session> -Id <Int32[]> -Action <String> [-GroupId <Int32>]
 [-TeamId <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Run one bulk action on one or more users: lock, unlock, enable, disable, force logout, or add to or remove from a group or team.
Each call sends one request for all the users passed to -Id.
Set-TssUserTwoFactor runs the two-factor bulk actions.
The operation runs in the background: pipe the output (BulkOperationId is the task identifier) to Get-TssBulkOperationProgress to follow it.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Invoke-TssBulkUserAction -TssSession $session -Id 12, 13 -Action Lock
```

Lock users 12 and 13

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Invoke-TssBulkUserAction -TssSession $session -Id 12, 13 -Action AddToGroup -GroupId 5
```

Add users 12 and 13 to group 5

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
IDs of the users to act on

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: UserId

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Action
Bulk action to run: Lock, Unlock, Enable, Disable, ForceLogout, AddToGroup, RemoveFromGroup, AddToTeam, RemoveFromTeam

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

### -GroupId
Group ID, required by AddToGroup and RemoveFromGroup

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

### -TeamId
Team ID, required by AddToTeam and RemoveFromTeam

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-user-operations/Invoke-TssBulkUserAction](https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-user-operations/Invoke-TssBulkUserAction)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-user-operations/Invoke-TssBulkUserAction.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-user-operations/Invoke-TssBulkUserAction.ps1)
