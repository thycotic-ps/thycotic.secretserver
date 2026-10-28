---
title: Get-TssCharacterSet
parent: Character Sets
grand_parent: Commands
---
# Get-TssCharacterSet

## SYNOPSIS
Get a character set

## SYNTAX

```
Get-TssCharacterSet [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the character set with the given ID: name, abbreviation, description, the characters in the set, and whether it is active and standard.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssCharacterSet -TssSession $session -Id 1
```

Returns character set ID 1

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
Type: Int32[]
Parameter Sets: (All)
Aliases: CharacterSetId

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

### Thycotic.PowerShell.CharacterSets.CharacterSet
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/character-sets/Get-TssCharacterSet](https://thycotic-ps.github.io/thycotic.secretserver/commands/character-sets/Get-TssCharacterSet)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/character-sets/Get-TssCharacterSet.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/character-sets/Get-TssCharacterSet.ps1)
