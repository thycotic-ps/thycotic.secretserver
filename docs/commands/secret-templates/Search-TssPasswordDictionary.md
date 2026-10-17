---
title: Search-TssPasswordDictionary
parent: Secret Templates
grand_parent: Commands
---
# Search-TssPasswordDictionary

## SYNOPSIS
Search custom password dictionaries

## SYNTAX

```
Search-TssPasswordDictionary [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the ID and name of every custom password dictionary.
Items are not included; Get-TssPasswordDictionary returns the items of one dictionary.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssPasswordDictionary -TssSession $session
```

Returns every custom password dictionary

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssPasswordDictionary -TssSession $session | Where-Object Name -EQ 'Blocked words' | Get-TssPasswordDictionary -TssSession $session
```

Returns the items of the password dictionary named "Blocked words"

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

### Thycotic.PowerShell.SecretTemplates.PasswordDictionary[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Search-TssPasswordDictionary](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Search-TssPasswordDictionary)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Search-TssPasswordDictionary.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Search-TssPasswordDictionary.ps1)
