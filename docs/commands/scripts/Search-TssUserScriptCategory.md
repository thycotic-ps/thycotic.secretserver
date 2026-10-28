---
title: Search-TssUserScriptCategory
parent: Scripts
grand_parent: Commands
---
# Search-TssUserScriptCategory

## SYNOPSIS
Search user script categories

## SYNTAX

```
Search-TssUserScriptCategory [-TssSession] <Session> [-SearchText <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Lists the user script categories (ID and name).
Use the ID with New-TssUserScript and Set-TssUserScript -ScriptCategoryId.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssUserScriptCategory -TssSession $session
```

List every user script category

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssUserScriptCategory -TssSession $session -SearchText Dependency
```

Find the categories whose name contains Dependency

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

### -SearchText
Only return categories whose name contains this text

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

### Thycotic.PowerShell.Scripts.UserScriptCategory[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/Search-TssUserScriptCategory](https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/Search-TssUserScriptCategory)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/Search-TssUserScriptCategory.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/Search-TssUserScriptCategory.ps1)
