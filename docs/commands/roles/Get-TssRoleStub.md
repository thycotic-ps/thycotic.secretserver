---
title: Get-TssRoleStub
parent: Roles
grand_parent: Commands
---
# Get-TssRoleStub

## SYNOPSIS
Get the default values for a new role

## SYNTAX

```
Get-TssRoleStub [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns a role object holding the default values for a new role.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssRoleStub -TssSession $session
```

Returns the default values for a new role

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Roles.Role
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/Get-TssRoleStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/Get-TssRoleStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/Get-TssRoleStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/Get-TssRoleStub.ps1)
