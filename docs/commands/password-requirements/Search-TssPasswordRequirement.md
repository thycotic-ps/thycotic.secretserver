---
title: Search-TssPasswordRequirement
parent: Password Requirements
grand_parent: Commands
---
# Search-TssPasswordRequirement

## SYNOPSIS
Search password requirements

## SYNTAX

```
Search-TssPasswordRequirement [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns every password requirement with its ID, name, description and whether it is the default.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssPasswordRequirement -TssSession $session
```

Returns all password requirements

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

### Thycotic.PowerShell.PasswordRequirements.PasswordRequirementItem[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/password-requirements/Search-TssPasswordRequirement](https://thycotic-ps.github.io/thycotic.secretserver/commands/password-requirements/Search-TssPasswordRequirement)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/password-requirements/Search-TssPasswordRequirement.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/password-requirements/Search-TssPasswordRequirement.ps1)
