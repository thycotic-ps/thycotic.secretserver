---
title: New-TssListOption
parent: Lists
grand_parent: Commands
---
# New-TssListOption

## SYNOPSIS
Add new options to a list

## SYNTAX

### Default (Default)
```
New-TssListOption [-TssSession] <Session> -Id <String> -Value <String[]> [-Category <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Single
```
New-TssListOption [-TssSession] <Session> -Id <String> -Value <String[]> [-Category <String>] [-Single]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### File
```
New-TssListOption [-TssSession] <Session> -Id <String> -Path <String> [-Delimiter <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Add new options to a categorized list, optionally tagged with a category.
By default all values are sent in one request.
Use -Single to send one request per value, or -Path to upload the options from a file.
How it differs from Add-TssListOption: Add-TssListOption requires a category, puts it in the request URL, and creates the category when it is missing.
New-TssListOption makes the category optional and adds the single-value and file upload ways of adding options.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssListOption -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' -Value 'server1','server2','server3'
```

Adds three uncategorized options to the list in one request

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssListOption -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' -Value 'server4' -Category 'Dev' -Single
```

Adds one option tagged with the Dev category using the single option endpoint

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssListOption -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' -Path ./servers.csv
```

Uploads the options in servers.csv (comma delimited) to the list

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
Categorized List ID

```yaml
Type: String
Parameter Sets: (All)
Aliases: CategorizedListId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Value
Option value(s) to add

```yaml
Type: String[]
Parameter Sets: Default, Single
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Category
Category to tag every added option with.
Leave it out for uncategorized options

```yaml
Type: String
Parameter Sets: Default, Single
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Single
Add each value with its own request (POST lists/{id}/options/single)

```yaml
Type: SwitchParameter
Parameter Sets: Single
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Path to a delimited text file of options to upload (POST lists/{id}/options/file)

```yaml
Type: String
Parameter Sets: File
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Delimiter
Delimiter used in the uploaded file, default is a comma

```yaml
Type: String
Parameter Sets: File
Aliases:

Required: False
Position: Named
Default value: ,
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

### Thycotic.PowerShell.Lists.Item[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/New-TssListOption](https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/New-TssListOption)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/New-TssListOption.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/New-TssListOption.ps1)
