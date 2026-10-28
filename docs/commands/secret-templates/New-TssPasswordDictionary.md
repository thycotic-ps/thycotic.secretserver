---
title: New-TssPasswordDictionary
parent: Secret Templates
grand_parent: Commands
---
# New-TssPasswordDictionary

## SYNOPSIS
Create a custom password dictionary

## SYNTAX

```
New-TssPasswordDictionary [-TssSession] <Session> -Name <String> -Path <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Uploads a text file as a new custom password dictionary.
Password requirements can reference a dictionary to block the passwords it lists.
The file holds one item per line.
An item can be at most 255 characters and a dictionary at most 1,000,000 items.
The name must be unique.
The endpoint returns only a success flag, so the cmdlet makes a second call (Search-TssPasswordDictionary) to return the new dictionary.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssPasswordDictionary -TssSession $session -Name 'Blocked words' -Path .\BlockedWords.txt
```

Creates the password dictionary "Blocked words" from the items in BlockedWords.txt and returns it

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

### -Name
Dictionary name, unique on the server

```yaml
Type: String
Parameter Sets: (All)
Aliases: DictionaryName

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Path to a text file with one dictionary item per line

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

### Thycotic.PowerShell.SecretTemplates.PasswordDictionary
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/New-TssPasswordDictionary](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/New-TssPasswordDictionary)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/New-TssPasswordDictionary.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/New-TssPasswordDictionary.ps1)
