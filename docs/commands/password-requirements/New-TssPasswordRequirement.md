---
title: New-TssPasswordRequirement
parent: Password Requirements
grand_parent: Commands
---
# New-TssPasswordRequirement

## SYNOPSIS
Create a password requirement

## SYNTAX

```
New-TssPasswordRequirement [-TssSession] <Session> -AllowedCharacterSetId <Int32>
 [-AllowMinimumCharacterSets] [-Description <String>] [-DifokMinDifferentCharacters <Int32>] [-EnforceDifok]
 [-IsDefault] -MaxPasswordLength <Int32> [-MinimumRequiredCharacterSets <Int32>] -MinPasswordLength <Int32>
 -Name <String> [-PasswordDictionaries <Int32[]>] [-PreventDictionaryWords] [-PreventSequentialPattern]
 [-PreventSpatialPattern] [-PreventUsername] [-Rule <Object[]>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a password requirement: length bounds, the allowed character set, prevention flags and optional rules.
The server rejects a duplicate name, a maximum length below the minimum, an unknown character set (reported as Access denied) and rules that cannot be satisfied together.
Password requirements cannot be deleted.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$rules = @{ PasswordRequirementType = 'MinimumOf'; MinCharactersRequired = 2; CharacterSetId = 4 }
New-TssPasswordRequirement -TssSession $session -Name 'Service accounts' -MinPasswordLength 20 -MaxPasswordLength 32 -AllowedCharacterSetId 1 -PreventUsername -Rule $rules
```

Creates a password requirement for 20 to 32 character passwords from the Default character set with at least two digits

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

### -AllowedCharacterSetId
ID of the character set passwords are built from (see Search-TssCharacterSet); 1 is the built-in Default set

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowMinimumCharacterSets
Require only MinimumRequiredCharacterSets of the MinimumOf rules instead of all of them

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

### -Description
Description

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

### -DifokMinDifferentCharacters
Minimum number of characters that must differ from the previous password when EnforceDifok is set

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

### -EnforceDifok
Require a new password to differ from the previous one by DifokMinDifferentCharacters characters

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

### -IsDefault
Make this the default password requirement

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

### -MaxPasswordLength
Maximum password length, at least MinPasswordLength

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -MinimumRequiredCharacterSets
Number of MinimumOf rules a password must satisfy when AllowMinimumCharacterSets is set

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

### -MinPasswordLength
Minimum password length, greater than 0

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Display name, unique across password requirements

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordDictionaries
IDs of the password dictionaries checked when PreventDictionaryWords is set

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PreventDictionaryWords
Reject passwords containing dictionary words

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

### -PreventSequentialPattern
Reject passwords containing sequential patterns such as abc or 123

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

### -PreventSpatialPattern
Reject passwords containing keyboard patterns such as qwerty

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

### -PreventUsername
Reject passwords containing the username

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

### -Rule
Rules a password must satisfy.
Each item has PasswordRequirementType (MinimumOf, StartsWith, EndsWith, MaxConsecutive, Repeating or RepeatingConsecutive), MinCharactersRequired and CharacterSetId (not used by Repeating and RepeatingConsecutive).
Pass hashtables or the PasswordRequirementRules objects returned by Get-TssPasswordRequirement

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/password-requirements/New-TssPasswordRequirement](https://thycotic-ps.github.io/thycotic.secretserver/commands/password-requirements/New-TssPasswordRequirement)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/password-requirements/New-TssPasswordRequirement.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/password-requirements/New-TssPasswordRequirement.ps1)
