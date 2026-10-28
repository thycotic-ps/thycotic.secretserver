---
title: Approve-TssSecretForceCheckout
parent: Secrets
grand_parent: Commands
---
# Approve-TssSecretForceCheckout

## SYNOPSIS
Approve a pending force checkout request on a secret

## SYNTAX

```
Approve-TssSecretForceCheckout [-TssSession] <Session> -Id <Int32> [-Comment <String>] -RequesterUserId <Int32>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Approves a request, filed with Request-TssSecretForceCheckout, to take over a secret that another user has checked out past the checkout end time.
The caller needs the Force Check In permission on the secret.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Approve-TssSecretForceCheckout -TssSession $session -Id 42 -RequesterUserId 7 -Comment 'Approved for the maintenance window'
```

Approves the force checkout request user 7 filed on secret 42

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

### -Comment
Comment recorded with the approval

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

### -RequesterUserId
ID of the user whose request is approved

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Approve-TssSecretForceCheckout](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Approve-TssSecretForceCheckout)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Approve-TssSecretForceCheckout.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Approve-TssSecretForceCheckout.ps1)
