---
title: Request-TssSecretForceCheckout
parent: Secrets
grand_parent: Commands
---
# Request-TssSecretForceCheckout

## SYNOPSIS
Request a force checkout of a secret another user has checked out

## SYNTAX

```
Request-TssSecretForceCheckout [-TssSession] <Session> -Id <Int32> [-ReasonForRequest <String>]
 -RequesterId <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Files a request to take over a secret whose current checkout has run past its end time, for a user without the Force Check In permission.
An approver grants it with Approve-TssSecretForceCheckout.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Request-TssSecretForceCheckout -TssSession $session -Id 42 -RequesterId 7 -ReasonForRequest 'Checkout expired, need access for an incident'
```

Requests a force checkout of secret 42 for user 7

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

### -ReasonForRequest
Reason shown to the approvers

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequesterId
ID of the user requesting the force checkout, normally the current user

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
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

### Thycotic.PowerShell.Secrets.ForceCheckout
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Request-TssSecretForceCheckout](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Request-TssSecretForceCheckout)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Request-TssSecretForceCheckout.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Request-TssSecretForceCheckout.ps1)
