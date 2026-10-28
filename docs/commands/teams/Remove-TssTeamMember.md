---
title: Remove-TssTeamMember
parent: Teams
grand_parent: Commands
---
# Remove-TssTeamMember

## SYNOPSIS
Remove groups from a team

## SYNTAX

```
Remove-TssTeamMember [-TssSession] <Session> -Id <Int32> -GroupId <Int32[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Remove groups from a team's membership.
Team members are groups; a user is removed through the user's personal group.
Members are identified by group ID.
Removing a group that is not on the team changes nothing.
Returns the team's remaining members.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssTeamMember -TssSession $session -Id 4 -GroupId 12,15
```

Removes groups 12 and 15 from team 4 and returns the remaining members

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
Team ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: TeamId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -GroupId
Group IDs to remove from the team

```yaml
Type: Int32[]
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

### Thycotic.PowerShell.Teams.Member[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Remove-TssTeamMember](https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Remove-TssTeamMember)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Remove-TssTeamMember.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Remove-TssTeamMember.ps1)
