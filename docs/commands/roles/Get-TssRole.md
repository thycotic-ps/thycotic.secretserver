---
title: Get-TssRole
parent: Roles
grand_parent: Commands
---
# Get-TssRole

## SYNOPSIS
Get a role by ID

## SYNTAX

```
Get-TssRole [-TssSession] <Session> -Id <Int32[]> [<CommonParameters>]
```

## DESCRIPTION
Returns the role with the given ID.
An ID that does not exist returns an empty role with Id 0.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssRole -TssSession $session -Id 1
```

Returns role ID 1

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Roles.Role
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/Get-TssRole](https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/Get-TssRole)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/Get-TssRole.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/Get-TssRole.ps1)
