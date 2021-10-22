# Get-TssListItem

## SYNOPSIS
Return the List's items

## SYNTAX

```
Get-TssListItem [-TssSession] <Session> -Id <String[]> [-Category <String>] [<CommonParameters>]
```

## DESCRIPTION
Return the List's items

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssListItem -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e'
```

Return details on the list by ID

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssList -SearchText 'IT' | Get-TssListItem -TssSession $session
```

Return items for all Lists that have "IT" in their name

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssList -SearchText 'Servers' | Get-TssListItem -TssSession $session -Category $null
```

Return the uncategorized item for any list with "Servers" in the name

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
Type: String[]
Parameter Sets: (All)
Aliases: CategorizedListId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Category
Filter by Category name (accepts null to return un-categorized values)

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

### Thycotic.PowerShell.Lists.Item
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/Get-TssListItem](https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/Get-TssListItem)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/Get-TssListItem.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/Get-TssListItem.ps1)

