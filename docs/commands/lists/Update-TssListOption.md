---
title: Update-TssListOption
parent: Lists
grand_parent: Commands
---
# Update-TssListOption

## SYNOPSIS
Update the options of a list

## SYNTAX

### Default (Default)
```
Update-TssListOption [-TssSession] <Session> -Id <String> -Item <Item[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Single
```
Update-TssListOption [-TssSession] <Session> -Id <String> [-Single] -OptionId <String> -Value <String[]>
 [-Category <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Replace
```
Update-TssListOption [-TssSession] <Session> -Id <String> [-Replace] -Value <String[]> [-Category <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Update existing options of a categorized list, or replace all of them.
By default it updates the options passed in -Item (objects from Get-TssListOption with a changed Value or Category).
Use -Single to update one option by its ID, or -Replace to remove every current option and add the given values instead.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$options = Get-TssListOption -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e'
$options[0].Value = 'server1-renamed'
Update-TssListOption -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' -Item $options[0]
```

Renames the first option of the list

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssListOption -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' -Single -OptionId '0a6f4c3e-1b2d-4e5f-8a9b-0c1d2e3f4a5b' -Value 'server2' -Category 'Prod'
```

Changes one option's value to server2 and its category to Prod

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssListOption -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' -Replace -Value 'server1','server2' -Category 'Dev'
```

Removes every option in the list and leaves only server1 and server2 in the Dev category

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

### -Item
Options to update, as returned by Get-TssListOption, with the new Value and Category set

```yaml
Type: Item[]
Parameter Sets: Default
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Single
Update one option by its ID (PUT lists/{id}/options/single)

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

### -OptionId
Categorized List Item ID of the option to update

```yaml
Type: String
Parameter Sets: Single
Aliases: CategorizedListItemId

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Replace
Replace every option in the list with the given values (PUT lists/{id}/options/replace)

```yaml
Type: SwitchParameter
Parameter Sets: Replace
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value
New option value.
With -Single pass exactly one value; with -Replace pass every value the list should hold

```yaml
Type: String[]
Parameter Sets: Single, Replace
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Category
Category for the updated or replacement options.
Leave it out to leave the options uncategorized.
With -Single that removes the option's current category: pass its current category to keep it

```yaml
Type: String
Parameter Sets: Single, Replace
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

### Thycotic.PowerShell.Lists.Item[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/Update-TssListOption](https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/Update-TssListOption)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/Update-TssListOption.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/Update-TssListOption.ps1)
