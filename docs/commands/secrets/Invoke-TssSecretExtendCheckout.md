---
title: Invoke-TssSecretExtendCheckout
parent: Secrets
grand_parent: Commands
---
# Invoke-TssSecretExtendCheckout

## SYNOPSIS
Extend a secret check out

## SYNTAX

```
Invoke-TssSecretExtendCheckout [-TssSession] <Session> -Id <Int32[]> -MinutesToAdd <Int32> [-Notes <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Adds minutes to the active check out of a secret by the current user and returns the new check out end time.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Invoke-TssSecretExtendCheckout -TssSession $session -Id 42 -MinutesToAdd 30 -Notes 'Maintenance window'
```

Extends the check out of secret 42 by 30 minutes

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

### -MinutesToAdd
Minutes to add to the check out

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

### -Notes
Reason for the extension

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Secrets.ExtendCheckout
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Invoke-TssSecretExtendCheckout](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Invoke-TssSecretExtendCheckout)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Invoke-TssSecretExtendCheckout.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Invoke-TssSecretExtendCheckout.ps1)
