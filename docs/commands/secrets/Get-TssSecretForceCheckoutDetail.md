---
title: Get-TssSecretForceCheckoutDetail
parent: Secrets
grand_parent: Commands
---
# Get-TssSecretForceCheckoutDetail

## SYNOPSIS
Get details of a pending force checkout request on a secret

## SYNTAX

```
Get-TssSecretForceCheckoutDetail [-TssSession] <Session> -RequesterId <Int32> -SecretId <Int32>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the secret name, the requester name, and whether the request was already approved.
Approvers use it to review a request before calling Approve-TssSecretForceCheckout.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretForceCheckoutDetail -TssSession $session -SecretId 42 -RequesterId 7
```

Returns the force checkout request user 7 filed on secret 42

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

### -RequesterId
ID of the user who filed the request

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SecretId
Secret ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Secrets.ForceCheckoutDetail
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretForceCheckoutDetail](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretForceCheckoutDetail)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretForceCheckoutDetail.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretForceCheckoutDetail.ps1)
