---
title: Get-TssSecretEraseRequestInbox
parent: Secret Erase Requests
grand_parent: Commands
---
# Get-TssSecretEraseRequestInbox

## SYNOPSIS
Get the secret erase requests in your inbox

## SYNTAX

```
Get-TssSecretEraseRequestInbox [-TssSession] <Session> -Status <String> [-IsMyRequest]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the secret erase requests in the inbox of the current user with the given status, for example the requests waiting for your approval.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretEraseRequestInbox -TssSession $session -Status Pending
```

Returns the pending secret erase requests in your inbox

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
Status of the requests to return

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-erase-requests/Get-TssSecretEraseRequestInbox](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-erase-requests/Get-TssSecretEraseRequestInbox)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-erase-requests/Get-TssSecretEraseRequestInbox.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-erase-requests/Get-TssSecretEraseRequestInbox.ps1)
