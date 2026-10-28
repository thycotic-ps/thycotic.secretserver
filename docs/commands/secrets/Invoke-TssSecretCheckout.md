---
title: Invoke-TssSecretCheckout
parent: Secrets
grand_parent: Commands
---
# Invoke-TssSecretCheckout

## SYNOPSIS
Check out a secret

## SYNTAX

```
Invoke-TssSecretCheckout [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Checks out a secret that requires check out and returns the response codes Secret Server sends back.
Check the secret in again with Close-TssSecret.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Invoke-TssSecretCheckout -TssSession $session -Id 42
```

Checks out secret 42

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Invoke-TssSecretCheckout -TssSession $session -Id 42
Close-TssSecret -TssSession $session -Id 42
```

Checks out secret 42 and checks it in again

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

### Thycotic.PowerShell.Secrets.Checkout
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Invoke-TssSecretCheckout](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Invoke-TssSecretCheckout)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Invoke-TssSecretCheckout.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Invoke-TssSecretCheckout.ps1)
