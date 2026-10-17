---
title: New-TssCharacterSet
parent: Character Sets
grand_parent: Commands
---
# New-TssCharacterSet

## SYNOPSIS
Create a character set

## SYNTAX

```
New-TssCharacterSet [-TssSession] <Session> -Abbreviation <String> [-Active] [-Description <String>]
 -Name <String> -Value <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a character set that password requirements use as their allowed character set or in their rules.
Character sets cannot be deleted; deactivate one with Set-TssCharacterSet -Active:$false.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssCharacterSet -TssSession $session -Name 'Hex' -Abbreviation 'hex' -Value '0123456789abcdef' -Active
```

Creates an active character set holding the hexadecimal digits

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

### -Abbreviation
Short abbreviation shown in password requirements

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

### -Active
Create the character set active; omit to create it inactive

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

### -Name
Display name

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

### -Value
The characters in the set, for example 0123456789abcdef

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

### Thycotic.PowerShell.CharacterSets.CharacterSet
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/character-sets/New-TssCharacterSet](https://thycotic-ps.github.io/thycotic.secretserver/commands/character-sets/New-TssCharacterSet)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/character-sets/New-TssCharacterSet.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/character-sets/New-TssCharacterSet.ps1)
