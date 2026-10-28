---
title: Get-TssTeam
parent: Teams
grand_parent: Commands
---
# Get-TssTeam

## SYNOPSIS
Get a team

## SYNTAX

```
Get-TssTeam [-TssSession] <Session> -Id <Int32[]> [<CommonParameters>]
```

## DESCRIPTION
Get a team by ID, including its name, description, active state, directory domain, and whether it is restricted to its sites and lists.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssTeam -TssSession $session -Id 4
```

Returns team 4

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
Type: Int32[]
Parameter Sets: (All)
Aliases: TeamId

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

### Thycotic.PowerShell.Teams.Team
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Get-TssTeam](https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Get-TssTeam)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Get-TssTeam.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Get-TssTeam.ps1)
