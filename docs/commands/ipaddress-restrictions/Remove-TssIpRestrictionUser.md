# Remove-TssIpRestrictionUser

## SYNOPSIS
Remove a User IP Address restriction by ID

## SYNTAX

```
Remove-TssIpRestrictionUser [-TssSession] <Session> -Id <Int32[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Remove a User IP Address restriction by ID

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssIpRestrictionUser -TssSession $session -Id 45 -UserId 98
```

Remove IP Address restriction 45 from User ID 98

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssIpRestrictionUser -TssSession $session -Id 45 -UserId 98, 54, 164, 4254
```

Remove IP Address Restriction 45 from each User

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssIpRestrictionUser -TssSession $session -Id 45, 98, 12 -UserId 98, 54, 164, 4254
```

Remove each IP Address Restriction from each User

### EXAMPLE 4
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssIpRestrictionUser -TssSession $session -Id 45, 98, 12 -UserId 98, 54, 164, 4254 -WhatIf
```

Verbose output of actions to be performed.

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
IP Address Restriction ID

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

### Thycotic.PowerShell.Common.Delete
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/Remove-TssIpRestrictionUser](https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/Remove-TssIpRestrictionUser)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/Remove-TssIpRestrictionUser.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/Remove-TssIpRestrictionUser.ps1)

