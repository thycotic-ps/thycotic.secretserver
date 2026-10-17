---
title: Search-TssTeamList
parent: Teams
grand_parent: Commands
---
# Search-TssTeamList

## SYNOPSIS
Get the categorized lists assigned to a team

## SYNTAX

```
Search-TssTeamList [-TssSession] <Session> -Id <Int32[]> [-SearchText <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Get the categorized lists assigned to a team.
Without -SearchText every list assigned to the team is returned.
With -SearchText only the team's lists whose name matches are returned, using the paged list search.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssTeamList -TssSession $session -Id 4
```

Returns every categorized list assigned to team 4

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssTeamList -TssSession $session -Id 4 -SearchText 'Servers'
```

Returns the lists assigned to team 4 whose name matches Servers

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

### -SearchText
Return only the team's lists whose name matches this text

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Lists.SummaryList[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Search-TssTeamList](https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Search-TssTeamList)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Search-TssTeamList.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Search-TssTeamList.ps1)
