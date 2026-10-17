---
title: Get-TssPasswordRequirement
parent: Password Requirements
grand_parent: Commands
---
# Get-TssPasswordRequirement

## SYNOPSIS
Get a password requirement

## SYNTAX

```
Get-TssPasswordRequirement [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the password requirement with the given ID, including its allowed character set, rules, password dictionaries, usage and a sample password built from it.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPasswordRequirement -TssSession $session -Id 1
```

Returns password requirement ID 1

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
Password requirement ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: PasswordRequirementId

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

### Thycotic.PowerShell.PasswordRequirements.PasswordRequirement
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/password-requirements/Get-TssPasswordRequirement](https://thycotic-ps.github.io/thycotic.secretserver/commands/password-requirements/Get-TssPasswordRequirement)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/password-requirements/Get-TssPasswordRequirement.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/password-requirements/Get-TssPasswordRequirement.ps1)
