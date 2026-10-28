---
title: Get-TssSecretMfa
parent: Secrets
grand_parent: Commands
---
# Get-TssSecretMfa

## SYNOPSIS
Test whether a secret requires multifactor authentication

## SYNTAX

```
Get-TssSecretMfa [-TssSession] <Session> -Id <Int32> [-IncludeInactive] [-NoAutoCheckout]
 [<CommonParameters>]
```

## DESCRIPTION
Returns True when the secret requires multifactor authentication to view it, False otherwise.
Secret Server audits the request as a secret view.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretMfa -TssSession $session -Id 42
```

Returns True when secret 42 requires multifactor authentication

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
Type: Int32
Parameter Sets: (All)
Aliases: SecretId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IncludeInactive
Include the secret when it is inactive

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

### -NoAutoCheckout
Do not check out the secret automatically

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretMfa](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretMfa)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretMfa.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretMfa.ps1)
