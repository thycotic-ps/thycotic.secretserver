---
title: Search-TssTeam
parent: Teams
grand_parent: Commands
---
# Search-TssTeam

## SYNOPSIS
Search teams

## SYNTAX

```
Search-TssTeam [-TssSession] <Session> [-SearchTerm <String>] [-IncludeInactive]
 [<CommonParameters>]
```

## DESCRIPTION
Search teams by name.
Only active teams are returned unless -IncludeInactive is given.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssTeam -TssSession $session
```

Returns every active team

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssTeam -TssSession $session -SearchTerm 'Operations' -IncludeInactive
```

Returns active and inactive teams whose name matches Operations

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

### -SearchTerm
Return only teams whose name matches this text

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

### -IncludeInactive
Include inactive teams

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

### Thycotic.PowerShell.Teams.Team[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Search-TssTeam](https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Search-TssTeam)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Search-TssTeam.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Search-TssTeam.ps1)
