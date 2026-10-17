---
title: New-TssTeam
parent: Teams
grand_parent: Commands
---
# New-TssTeam

## SYNOPSIS
Create a new team

## SYNTAX

```
New-TssTeam [-TssSession] <Session> -TeamName <String> [-TeamDescription <String>] [-DomainId <Int32>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create a new team and return its ID.
The team name must be unique.
Teams cannot be deleted through the REST API; use Update-TssTeam -Active:$false to deactivate a team.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$teamId = New-TssTeam -TssSession $session -TeamName 'Operations' -TeamDescription 'Operations team'
Get-TssTeam -TssSession $session -Id $teamId
```

Creates the Operations team and gets it by the returned ID

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

### -TeamName
Team name, unique and up to 250 characters

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

### -TeamDescription
Team description, up to 2000 characters

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

### System.Int32
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/New-TssTeam](https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/New-TssTeam)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/New-TssTeam.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/New-TssTeam.ps1)
