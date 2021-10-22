# Get-TssListCategory

## SYNOPSIS
Return a list of categories availabe for the provided List ID

## SYNTAX

```
Get-TssListCategory [-TssSession] <Session> -Id <String[]> [<CommonParameters>]
```

## DESCRIPTION
Return a list of categories availabe for the provided List ID

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssListCategory -TssSession $session -Id df0b8746-581f-4ac2-a9b2-5a2b7a679f3e
```

Return categories for the provided ID

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssList -TssSession $session -SearchText "Servers" | Get-TssListCategory -TssSession $session
```

Return categories for Lists with the name "Servers"

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Lists.Category
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/Get-TssListCategory](https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/Get-TssListCategory)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/Get-TssListCategory.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/Get-TssListCategory.ps1)

