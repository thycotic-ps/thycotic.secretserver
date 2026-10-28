---
title: Get-TssPasswordDictionary
parent: Secret Templates
grand_parent: Commands
---
# Get-TssPasswordDictionary

## SYNOPSIS
Get the items of a custom password dictionary

## SYNTAX

```
Get-TssPasswordDictionary [-TssSession] <Session> -Id <Int32>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the items of a custom password dictionary, one string per item, sorted alphabetically ignoring case. Secret Server does not keep the order of the uploaded file.
Use Search-TssPasswordDictionary to find dictionary IDs and names.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPasswordDictionary -TssSession $session -Id 3
```

Returns the items of password dictionary 3

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPasswordDictionary -TssSession $session -Id 3 | Set-Content -Path .\BlockedWords.txt
```

Saves the items of password dictionary 3 to a text file, one item per line

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
Password dictionary ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: DictionaryId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Get-TssPasswordDictionary](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Get-TssPasswordDictionary)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Get-TssPasswordDictionary.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Get-TssPasswordDictionary.ps1)
