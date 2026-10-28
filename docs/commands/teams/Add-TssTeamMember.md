---
title: Add-TssTeamMember
parent: Teams
grand_parent: Commands
---
# Add-TssTeamMember

## SYNOPSIS
Add groups to a team

## SYNTAX

### add (Default)
```
Add-TssTeamMember [-TssSession] <Session> -Id <Int32> -GroupId <Int32[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### replace
```
Add-TssTeamMember [-TssSession] <Session> -Id <Int32> -GroupId <Int32[]> [-Replace] [-DomainId <Int32>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Add groups to a team's membership.
Team members are groups; a user is added through the user's personal group.
By default the groups are added to the existing members and groups already on the team are skipped.
Use -Replace to set the team's members to exactly -GroupId, removing any group not given.
Only a replace writes a team audit entry.
Returns the team's members after the change.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Add-TssTeamMember -TssSession $session -Id 4 -GroupId 12,15
```

Adds groups 12 and 15 to team 4, keeping its other members

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Add-TssTeamMember -TssSession $session -Id 4 -GroupId 12 -Replace
```

Sets team 4's members to group 12 only

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
Group IDs to add to the team

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

### -Replace
Set the team's members to exactly -GroupId, removing any group not given

```yaml
Type: SwitchParameter
Parameter Sets: replace
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DomainId
Directory domain ID sent with a replace

```yaml
Type: Int32
Parameter Sets: replace
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

### Thycotic.PowerShell.Teams.Member[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Add-TssTeamMember](https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Add-TssTeamMember)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Add-TssTeamMember.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Add-TssTeamMember.ps1)
