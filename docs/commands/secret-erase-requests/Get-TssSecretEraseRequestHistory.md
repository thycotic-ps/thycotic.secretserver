---
title: Get-TssSecretEraseRequestHistory
parent: Secret Erase Requests
grand_parent: Commands
---
# Get-TssSecretEraseRequestHistory

## SYNOPSIS
Get the history of a secret erase request

## SYNTAX

```
Get-TssSecretEraseRequestHistory [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the actions recorded for a secret erase request: action, date, user and details.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretEraseRequestHistory -TssSession $session -Id 17
```

Returns the history of secret erase request 17

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

### Thycotic.PowerShell.EraseRequests.History[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-erase-requests/Get-TssSecretEraseRequestHistory](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-erase-requests/Get-TssSecretEraseRequestHistory)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-erase-requests/Get-TssSecretEraseRequestHistory.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-erase-requests/Get-TssSecretEraseRequestHistory.ps1)
