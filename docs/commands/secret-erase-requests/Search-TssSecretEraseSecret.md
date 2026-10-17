---
title: Search-TssSecretEraseSecret
parent: Secret Erase Requests
grand_parent: Commands
---
# Search-TssSecretEraseSecret

## SYNOPSIS
Get the secrets of a secret erase request

## SYNTAX

```
Search-TssSecretEraseSecret [-TssSession] <Session> -RequestId <Int32> [-Erased]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the secrets in a secret erase request and when each one was erased.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecretEraseSecret -TssSession $session -RequestId 17
```

Returns the secrets in secret erase request 17

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretEraseRequest -TssSession $session -Id 17 | Search-TssSecretEraseSecret -TssSession $session -Erased
```

Returns the secrets of request 17 that are already erased

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

### -RequestId
Secret erase request ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: Id, SecretEraseRequestId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Erased
Only secrets already erased; -Erased:$false returns the secrets not yet erased

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

### Thycotic.PowerShell.EraseRequests.Secret[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-erase-requests/Search-TssSecretEraseSecret](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-erase-requests/Search-TssSecretEraseSecret)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-erase-requests/Search-TssSecretEraseSecret.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-erase-requests/Search-TssSecretEraseSecret.ps1)
