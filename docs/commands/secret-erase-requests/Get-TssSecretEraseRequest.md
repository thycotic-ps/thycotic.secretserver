---
title: Get-TssSecretEraseRequest
parent: Secret Erase Requests
grand_parent: Commands
---
# Get-TssSecretEraseRequest

## SYNOPSIS
Get a secret erase request

## SYNTAX

```
Get-TssSecretEraseRequest [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns a secret erase request: requester, comment, number of secrets, status, erase after date and whether you can approve, deny or cancel it.
Requires the Secret Erase feature.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretEraseRequest -TssSession $session -Id 17
```

Returns secret erase request 17

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
Secret erase request ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SecretEraseRequestId

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

### Thycotic.PowerShell.EraseRequests.Request
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-erase-requests/Get-TssSecretEraseRequest](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-erase-requests/Get-TssSecretEraseRequest)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-erase-requests/Get-TssSecretEraseRequest.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-erase-requests/Get-TssSecretEraseRequest.ps1)
