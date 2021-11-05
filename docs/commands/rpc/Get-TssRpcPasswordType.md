# Get-TssRpcPasswordType

## SYNOPSIS
Get Password Type

## SYNTAX

```
Get-TssRpcPasswordType [-TssSession] <Session> -Id <Int32[]> [<CommonParameters>]
```

## DESCRIPTION
Get Password Type

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssRpcPasswordType -TssSession $session -Id 52
```

Get Password Type 52

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
Password Type ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: PasswordTypeId

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

### Thycotic.PowerShell.Rpc.PasswordType
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/rpc/Get-TssRpcPasswordType](https://thycotic-ps.github.io/thycotic.secretserver/commands/rpc/Get-TssRpcPasswordType)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/rpc/Get-TssRpcPasswordType.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/rpc/Get-TssRpcPasswordType.ps1)

