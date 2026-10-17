---
title: Update-TssTeam
parent: Teams
grand_parent: Commands
---
# Update-TssTeam

## SYNOPSIS
Update a team

## SYNTAX

```
Update-TssTeam [-TssSession] <Session> -Id <Int32> [-Active] [-DomainId <Int32>] [-TeamDescription <String>]
 [-TeamName <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Update the name, description, active state, or directory domain of a team.
Only the parameters given are changed.
The team name must stay unique.
Use -Active:$false to deactivate a team.
Returns the updated team.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssTeam -TssSession $session -Id 4 -TeamDescription 'Operations and on-call'
```

Changes the description of team 4

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssTeam -TssSession $session -Id 4 -Active:$false
```

Deactivates team 4

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

### -Active
Set the team active, or inactive with -Active:$false

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

### -DomainId
Directory domain ID to associate with the team

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

### -TeamDescription
New team description

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

### -TeamName
New team name

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

### Thycotic.PowerShell.Teams.Team
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Update-TssTeam](https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Update-TssTeam)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Update-TssTeam.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Update-TssTeam.ps1)
