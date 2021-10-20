# Search-TssList

## SYNOPSIS
Search Lists

## SYNTAX

```
Search-TssList [-TssSession] <Session> [-SearchText <String>] [-IncludeInactive] [-SortBy <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Search Lists

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssList -TssSession $session -SearchText dev
```

Return all Lists that have "dev" in their name

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
Search text

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

### -IncludeInactive
Include inactive

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SortBy
Sort by specific property, default Name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Name
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Lists.Summary
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/Search-TssList](https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/Search-TssList)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/Search-TssList.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/Search-TssList.ps1)

