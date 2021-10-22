# Add-TssListOption

## SYNOPSIS
Add option(s) to a list with the specified category

## SYNTAX

```
Add-TssListOption [-TssSession] <Session> -Id <String> -Category <String> -Option <String[]> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Add option(s) to a list with the specified category, the category will be created if missing

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Add-TssListOption -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' -Category Dev -Option 'server1','server2','server3'
```

Add the 3 server item values to the category Dev on the specified List ID

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$list = Search-TssList -TssSession $session -SearchText 'Test List - Servers'
$data = Import-Csv c:\temp\newlist.csv
foreach ($category in $data.Category) { Add-TssListOption -TssSession $session -Id $list.CategorizedListId -Category $category -Option $data.Where({$_.Category -eq $Category}).Option }
```

List "Test List - Servers" ID retrieved, import a CSV (newlist.csv) that contains multiple categories and option values.
Each is imported into the provided List.

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

### -Category
Category name

```yaml
Type: String
Parameter Sets: (All)
Aliases: CategoryName

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Option
Item value

```yaml
Type: String[]
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

### Thycotic.PowerShell.List.Item
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/Add-TssListOption](https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/Add-TssListOption)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/Add-TssListOption.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/Add-TssListOption.ps1)

