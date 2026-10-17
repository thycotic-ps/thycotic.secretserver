---
title: Update-TssPasswordDictionary
parent: Secret Templates
grand_parent: Commands
---
# Update-TssPasswordDictionary

## SYNOPSIS
Update a custom password dictionary

## SYNTAX

```
Update-TssPasswordDictionary [-TssSession] <Session> -Id <Int32> -Name <String> -Path <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Replaces the name and items of a custom password dictionary with a name and a text file.
Password requirements that use the dictionary keep using it.
The file holds one item per line.
An item can be at most 255 characters and a dictionary at most 1,000,000 items.
The name must be unique.
The endpoint returns only a success flag, so the cmdlet makes a second call (Search-TssPasswordDictionary) to return the updated dictionary.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssPasswordDictionary -TssSession $session -Id 3 -Name 'Blocked words' -Path .\BlockedWords.txt
```

Replaces the items of password dictionary 3 with the items in BlockedWords.txt and keeps its name

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssPasswordDictionary -TssSession $session | Where-Object Name -EQ 'Blocked words' | Update-TssPasswordDictionary -TssSession $session -Path .\BlockedWords.txt
```

Replaces the items of the password dictionary named "Blocked words"; Id and Name come from the pipeline

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

### -Name
Dictionary name, unique on the server.
Pass the current name to keep it

```yaml
Type: String
Parameter Sets: (All)
Aliases: DictionaryName

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path
Path to a text file with one dictionary item per line; replaces every current item

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Update-TssPasswordDictionary](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Update-TssPasswordDictionary)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Update-TssPasswordDictionary.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Update-TssPasswordDictionary.ps1)
