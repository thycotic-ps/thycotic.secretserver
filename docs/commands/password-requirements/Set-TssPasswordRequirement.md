---
title: Set-TssPasswordRequirement
parent: Password Requirements
grand_parent: Commands
---
# Set-TssPasswordRequirement

## SYNOPSIS
Update a password requirement

## SYNTAX

```
Set-TssPasswordRequirement [-TssSession] <Session> -Id <Int32> [-AllowedCharacterSetId <Int32>]
 [-Description <String>] [-DifokMinDifferentCharacters <Int32>] [-EnforceDifok] [-IsDefault]
 [-MaxPasswordLength <Int32>] [-MinimumRequiredCharacterSets <Int32>] [-MinPasswordLength <Int32>]
 [-Name <String>] [-PasswordDictionaries <Int32[]>] [-PreventDictionaryWords] [-PreventSequentialPattern]
 [-PreventSpatialPattern] [-PreventUsername] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Changes only the fields you pass; everything else is left unchanged.
Use Update-TssPasswordRequirementRule to change the rules.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssPasswordRequirement -TssSession $session -Id 4 -MinPasswordLength 24 -PreventDictionaryWords
```

Raises the minimum length of password requirement ID 4 to 24 and turns on the dictionary check

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

### -AllowedCharacterSetId
ID of the character set passwords are built from (see Search-TssCharacterSet); 1 is the built-in Default set

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

Required: False
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

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
New name

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/password-requirements/Set-TssPasswordRequirement](https://thycotic-ps.github.io/thycotic.secretserver/commands/password-requirements/Set-TssPasswordRequirement)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/password-requirements/Set-TssPasswordRequirement.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/password-requirements/Set-TssPasswordRequirement.ps1)
