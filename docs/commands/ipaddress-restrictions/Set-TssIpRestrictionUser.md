# Set-TssIpRestrictionUser

## SYNOPSIS
Set IP Address Restriction(s) for a user(s)

## SYNTAX

```
Set-TssIpRestrictionUser [-TssSession] <Session> -Id <Int32[]> -UserId <Int32[]> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Set IP Address Restriction(s) for a user(s)

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssIpRestrictionUser -TssSession session -Id 42 -UserId 14
```

Set IP Restriction 42 on User 14

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssIpRestrictionUser -TssSession session -Id 65, 43, 13 -UserId 97, 463, 109
```

Set each IP Restriction provided on each User provided

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssIpRestrictionUser -TssSession session -Id 65, 43, 13 -UserId 97, 463, 109 -WhatIf
```

Outputs verbose messages of action to be performed

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
IP Address Restriction ID(s)

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: IpAddressRestrictionId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UserId
User ID(s)

```yaml
Type: Int32[]
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

## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/Set-TssIpRestrictionUser](https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/Set-TssIpRestrictionUser)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/Set-TssIpRestrictionUser.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/Set-TssIpRestrictionUser.ps1)

