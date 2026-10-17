---
title: Update-TssPasswordRequirementRule
parent: Password Requirements
grand_parent: Commands
---
# Update-TssPasswordRequirementRule

## SYNOPSIS
Replace the rules of a password requirement

## SYNTAX

```
Update-TssPasswordRequirementRule [-TssSession] <Session> -Id <Int32> -Rule <Object[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sends the full rule set for the password requirement.
Rules with a PasswordRequirementRuleId are updated, rules without one are added, and existing rules left out are deleted, so pass every rule you want to keep; an empty list removes all rules.
Start from the PasswordRequirementRules returned by Get-TssPasswordRequirement to keep the existing rules.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$req = Get-TssPasswordRequirement -TssSession $session -Id 4 -ErrorAction Stop
$rules = @($req.PasswordRequirementRules) + @{ PasswordRequirementType = 'StartsWith'; MinCharactersRequired = 1; CharacterSetId = 5 }
Update-TssPasswordRequirementRule -TssSession $session -Id 4 -Rule $rules
```

Keeps the rules of password requirement ID 4 and adds one requiring passwords to start with an upper case letter

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
Type: Int32
Parameter Sets: (All)
Aliases: PasswordRequirementId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Rule
Rules a password must satisfy.
Each item has PasswordRequirementType (MinimumOf, StartsWith, EndsWith, MaxConsecutive, Repeating or RepeatingConsecutive), MinCharactersRequired and CharacterSetId (not used by Repeating and RepeatingConsecutive).
Pass hashtables or the PasswordRequirementRules objects returned by Get-TssPasswordRequirement; items with a PasswordRequirementRuleId update that rule

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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

### Thycotic.PowerShell.PasswordRequirements.PasswordRequirement
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/password-requirements/Update-TssPasswordRequirementRule](https://thycotic-ps.github.io/thycotic.secretserver/commands/password-requirements/Update-TssPasswordRequirementRule)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/password-requirements/Update-TssPasswordRequirementRule.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/password-requirements/Update-TssPasswordRequirementRule.ps1)
