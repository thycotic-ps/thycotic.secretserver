---
title: Search-TssRoleGroup
parent: Roles
grand_parent: Commands
---
# Search-TssRoleGroup

## SYNOPSIS
Search the groups assigned to a role

## SYNTAX

```
Search-TssRoleGroup [-TssSession] <Session> -Id <Int32[]> [-IncludeInactiveUsersForGroup]
 [-UserDomainId <Int32>] [-UserStatus <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns the groups assigned to a role.
Disabled groups and the personal groups of inactive users are not returned.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssRoleGroup -TssSession $session -Id 7
```

Returns the groups assigned to role ID 7

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
Role ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: RoleId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IncludeInactiveUsersForGroup
Passed to the API, but Secret Server does not apply it: the result is the same with or without it

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

### -UserDomainId
Only return groups in this domain ID

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

### -UserStatus
User status filter.
Secret Server validates the value but does not apply it: the result is the same for every valid value

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

### Thycotic.PowerShell.Roles.Group[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/Search-TssRoleGroup](https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/Search-TssRoleGroup)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/Search-TssRoleGroup.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/Search-TssRoleGroup.ps1)
