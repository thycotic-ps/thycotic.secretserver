---
title: Remove-TssGroup
parent: Groups
grand_parent: Commands
---
# Remove-TssGroup

## SYNOPSIS
Disable a group

## SYNTAX

```
Remove-TssGroup [-TssSession] <Session> -Id <Int32[]> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Removes a group the way Secret Server does it: the group is disabled, not deleted, so its audit history and permission references stay intact.
Re-enable the group with Set-TssGroup -Enabled.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssGroup -TssSession $session -Id 42
```

Disables group 42

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
Group ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: GroupId

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

### Thycotic.PowerShell.Common.Delete
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Remove-TssGroup](https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Remove-TssGroup)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Remove-TssGroup.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Remove-TssGroup.ps1)
