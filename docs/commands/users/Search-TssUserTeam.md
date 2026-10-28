---
title: Search-TssUserTeam
parent: Users
grand_parent: Commands
---
# Search-TssUserTeam

## SYNOPSIS
List the teams of a user

## SYNTAX

```
Search-TssUserTeam [-TssSession] <Session> -Id <Int32[]> [-IncludeGroupMemberships] [-IncludeInactive]
 [-SearchTerm <String>] [<CommonParameters>]
```

## DESCRIPTION
Lists the teams a user belongs to, directly or through a group.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssUserTeam -TssSession $session -Id 42 -IncludeGroupMemberships
```

Lists the teams of user 42 with the groups that grant each membership

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
User ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: UserId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IncludeGroupMemberships
Include the groups through which the user belongs to each team

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

### -SearchTerm
Text to match against the team name

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

### Thycotic.PowerShell.Users.Team[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Search-TssUserTeam](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Search-TssUserTeam)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Search-TssUserTeam.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Search-TssUserTeam.ps1)
