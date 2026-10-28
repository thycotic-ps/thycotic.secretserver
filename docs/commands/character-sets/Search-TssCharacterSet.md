---
title: Search-TssCharacterSet
parent: Character Sets
grand_parent: Commands
---
# Search-TssCharacterSet

## SYNOPSIS
Search character sets

## SYNTAX

```
Search-TssCharacterSet [-TssSession] <Session> [-Status <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the character sets that password requirements can use, active ones unless Status says otherwise.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssCharacterSet -TssSession $session
```

Returns all active character sets

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssCharacterSet -TssSession $session -Status All
```

Returns active and inactive character sets

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

### -Status
Filter by status: Active (the server default), Inactive or All

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.CharacterSets.CharacterSet[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/character-sets/Search-TssCharacterSet](https://thycotic-ps.github.io/thycotic.secretserver/commands/character-sets/Search-TssCharacterSet)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/character-sets/Search-TssCharacterSet.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/character-sets/Search-TssCharacterSet.ps1)
