---
title: Search-TssTeamMember
parent: Teams
grand_parent: Commands
---
# Search-TssTeamMember

## SYNOPSIS
Search the members of a team

## SYNTAX

```
Search-TssTeamMember [-TssSession] <Session> -Id <Int32[]> [-SearchText <String>] [-DomainId <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
Search the members of a team by display name.
Usernames are not matched.
Each result resolves the member's user details (user ID, username, domain) where the member is a user.
Use Get-TssTeamMember to get the team's group memberships.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssTeamMember -TssSession $session -Id 4
```

Returns every member of team 4

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssTeamMember -TssSession $session -Id 4 -SearchText 'admin'
```

Returns the members of team 4 whose display name matches admin

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
Return only members whose display name matches this text.
Usernames are not matched

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
Return only members from this directory domain ID

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Teams.MemberSummary[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Search-TssTeamMember](https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Search-TssTeamMember)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Search-TssTeamMember.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Search-TssTeamMember.ps1)
