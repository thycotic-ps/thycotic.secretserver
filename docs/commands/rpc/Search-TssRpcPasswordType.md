# Search-TssRpcPasswordType

## SYNOPSIS
List available Password Types

## SYNTAX

```
Search-TssRpcPasswordType [-TssSession] <Session> [-SearchText <String>] [-IncludeInactive <Boolean>]
 [-SortBy <String>] [<CommonParameters>]
```

## DESCRIPTION
List available Password Types

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssRpcPasswordType -TssSession $session -SearchTerm Directory -IncludeInactive
```

List Password Types that are inactive and have "Directory" in the name

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
Search based on text in Name

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
Include inactive objects

```yaml
Type: Boolean
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

### Thycotic.PowerShell.Rpc.PasswordTypeSummary
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/rpc/Search-TssRpcPasswordType](https://thycotic-ps.github.io/thycotic.secretserver/commands/rpc/Search-TssRpcPasswordType)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/rpc/Search-TssRpcPasswordType.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/rpc/Search-TssRpcPasswordType.ps1)

