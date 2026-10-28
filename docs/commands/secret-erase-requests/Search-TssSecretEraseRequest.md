---
title: Search-TssSecretEraseRequest
parent: Secret Erase Requests
grand_parent: Commands
---
# Search-TssSecretEraseRequest

## SYNOPSIS
Search secret erase requests

## SYNTAX

```
Search-TssSecretEraseRequest [-TssSession] <Session> [-Status <String>] [-SecretId <Int32>] [-IsMyRequest]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the secret erase requests visible to the current user, filtered by status, by secret or to the requests you created.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecretEraseRequest -TssSession $session -Status Pending
```

Returns the pending secret erase requests

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecretEraseRequest -TssSession $session -SecretId 42 -IsMyRequest
```

Returns your secret erase requests that include secret 42

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

### -Status
Only requests with this status

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

### -SecretId
Only requests that include this secret ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsMyRequest
Only requests you created

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

### Thycotic.PowerShell.EraseRequests.Request[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-erase-requests/Search-TssSecretEraseRequest](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-erase-requests/Search-TssSecretEraseRequest)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-erase-requests/Search-TssSecretEraseRequest.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-erase-requests/Search-TssSecretEraseRequest.ps1)
