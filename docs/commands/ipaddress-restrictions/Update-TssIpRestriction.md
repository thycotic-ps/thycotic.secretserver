# Update-TssIpRestriction

## SYNOPSIS
Update Id

## SYNTAX

```
Update-TssIpRestriction [-TssSession] <Session> [-IpRestriction] <IpRestriction> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Update Id

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$ip = Search-TssIpRestriction.Where({$_.Name -eq 'Office Range 1'})
$ip.Range = '192.0.1.0/24'
Update-TssIpRestriction -TssSession $session -IpRestriction $ip
```

Update the range on IP restrition "Office Range 1"

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

### -IpRestriction
Ip Address Restriction ID

```yaml
Type: IpRestriction
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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

### Thycotic.PowerShell.IpRestrictions.IpRestriction
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/Update-TssIpRestriction](https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/Update-TssIpRestriction)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/Update-TssIpRestriction.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/Update-TssIpRestriction.ps1)

