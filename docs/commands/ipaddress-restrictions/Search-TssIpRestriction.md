# Search-TssIpRestriction

## SYNOPSIS
Search for IP Address restrictions

## SYNTAX

```
Search-TssIpRestriction [-TssSession] <Session> [-SortBy <String>] [<CommonParameters>]
```

## DESCRIPTION
Search for IP Address restrictions

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssIpRestriction -TssSession $session
```

Return list of IP Address restrictions for Secret Server

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

### -SortBy
Sort by specific property, default Id

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Id
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.IpRestrictions.IpRestriction
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/Search-TssIpRestriction](https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/Search-TssIpRestriction)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/Search-TssIpRestriction.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/Search-TssIpRestriction.ps1)

