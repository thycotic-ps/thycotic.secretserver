# Search-TssIpRestrictionUser

## SYNOPSIS
Search IP Address restrictions assigned to users.

## SYNTAX

```
Search-TssIpRestrictionUser [-TssSession] <Session> [-IpAddressRestrictionId <Int32>] [-UserId <Int32>]
 [-SortBy <String>] [<CommonParameters>]
```

## DESCRIPTION
Search IP Address restrictions assigned to groups.
Search based on User ID or IP Address Restriction Id.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssIpRestrictionUser -TssSession $session -Id 5
```

Return users assigned to IP Address restriction 5

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssIpRestrictionUser -TssSession $session -UserId 46
```

Return IP Address restrictions assigned to User ID 46

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

### -IpAddressRestrictionId
IP Address Restriction

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserId
User ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SortBy
Sort by specific property, default IpAddressRestrictionId

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: IpAddressRestrictionId
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.IpRestrictions.User
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/Search-TssIpRestrictionUser](https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/Search-TssIpRestrictionUser)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/Search-TssIpRestrictionUser.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/Search-TssIpRestrictionUser.ps1)

