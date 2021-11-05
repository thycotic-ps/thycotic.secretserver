# Get-TssRpcAssociatedSecret

## SYNOPSIS
Get a list of the Associated Secrets configured for a Secret

## SYNTAX

```
Get-TssRpcAssociatedSecret [-TssSession] <Session> -Id <Int32[]> [<CommonParameters>]
```

## DESCRIPTION
Get a list of the Associated Secrets configured for a Secret

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssRpcAssociatedSecret -TssSession $session - some test value
```

Add minimum example for each parameter

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
Secret ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SecretId

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

### Thycotic.PowerShell.Rpc.AssociatedSecret
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/rpc/Get-TssRpcAssociatedSecret](https://thycotic-ps.github.io/thycotic.secretserver/commands/rpc/Get-TssRpcAssociatedSecret)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/rpc/Get-TssRpcAssociatedSecret.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/rpc/Get-TssRpcAssociatedSecret.ps1)

