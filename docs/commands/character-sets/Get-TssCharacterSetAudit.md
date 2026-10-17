---
title: Get-TssCharacterSetAudit
parent: Character Sets
grand_parent: Commands
---
# Get-TssCharacterSetAudit

## SYNOPSIS
Get audit entries for a character set

## SYNTAX

```
Get-TssCharacterSetAudit [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the audit records for the given character set.
Creating a character set records a Create entry; the built-in character sets have no records until they are changed.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssCharacterSetAudit -TssSession $session -Id 9
```

Returns the audit records for character set ID 9

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

### Thycotic.PowerShell.CharacterSets.Audit[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/character-sets/Get-TssCharacterSetAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/character-sets/Get-TssCharacterSetAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/character-sets/Get-TssCharacterSetAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/character-sets/Get-TssCharacterSetAudit.ps1)
