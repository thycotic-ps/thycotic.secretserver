---
title: Set-TssCharacterSet
parent: Character Sets
grand_parent: Commands
---
# Set-TssCharacterSet

## SYNOPSIS
Update a character set

## SYNTAX

```
Set-TssCharacterSet [-TssSession] <Session> -Id <Int32> [-Abbreviation <String>] [-Active]
 [-Description <String>] [-Name <String>] [-Value <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Changes only the fields you pass; everything else is left unchanged.
Character sets cannot be deleted; use -Active:$false to deactivate one.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssCharacterSet -TssSession $session -Id 9 -Description 'Hexadecimal digits'
```

Changes the description of character set ID 9

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssCharacterSet -TssSession $session -Id 9 -Active:$false
```

Deactivates character set ID 9

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
Character set ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: CharacterSetId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Abbreviation
New abbreviation

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

### -Active
Activate the character set, or deactivate it with -Active:$false

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
New description

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

### -Value
New characters in the set

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/character-sets/Set-TssCharacterSet](https://thycotic-ps.github.io/thycotic.secretserver/commands/character-sets/Set-TssCharacterSet)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/character-sets/Set-TssCharacterSet.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/character-sets/Set-TssCharacterSet.ps1)
