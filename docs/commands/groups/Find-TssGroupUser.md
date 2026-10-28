---
title: Find-TssGroupUser
parent: Groups
grand_parent: Commands
---
# Find-TssGroupUser

## SYNOPSIS
Get the display names of the members of a group

## SYNTAX

```
Find-TssGroupUser [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the display names of the users in a group, as the web UI lists them.
Use Get-TssGroupMember for full member records.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Find-TssGroupUser -TssSession $session -Id 42
```

Gets the display names of the members of group 42

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
Group ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: GroupId

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

### System.String
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Find-TssGroupUser](https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Find-TssGroupUser)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Find-TssGroupUser.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Find-TssGroupUser.ps1)
