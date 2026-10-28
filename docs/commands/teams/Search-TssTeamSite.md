---
title: Search-TssTeamSite
parent: Teams
grand_parent: Commands
---
# Search-TssTeamSite

## SYNOPSIS
Get the sites assigned to a team

## SYNTAX

```
Search-TssTeamSite [-TssSession] <Session> -Id <Int32[]> [-IncludeInactive]
 [<CommonParameters>]
```

## DESCRIPTION
Get the Distributed Engine sites assigned to a team.
The server returns inactive sites too, whether or not -IncludeInactive is given.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssTeamSite -TssSession $session -Id 4
```

Returns every site assigned to team 4, active or inactive

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

### -IncludeInactive
Send includeInactive=true to the server.
The server does not filter on it, so active and inactive sites are returned either way

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Teams.Site[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Search-TssTeamSite](https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Search-TssTeamSite)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Search-TssTeamSite.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Search-TssTeamSite.ps1)
