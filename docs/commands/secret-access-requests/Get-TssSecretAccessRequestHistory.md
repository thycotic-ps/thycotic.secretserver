---
title: Get-TssSecretAccessRequestHistory
parent: Secret Access Requests
grand_parent: Commands
---
# Get-TssSecretAccessRequestHistory

## SYNOPSIS
Get the history of a secret access request

## SYNTAX

### Default (Default)
```
Get-TssSecretAccessRequestHistory [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

### V2
```
Get-TssSecretAccessRequestHistory [-TssSession] <Session> -Id <Int32[]> [-V2]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the actions recorded for a secret access request (created, approved, denied, canceled, expired), with the date and the user who acted.
The history is returned to the user that created the request.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretAccessRequestHistory -TssSession $session -Id 17
```

Get the history of access request 17

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecretAccessRequest -TssSession $session -Status Approved | Get-TssSecretAccessRequestHistory -TssSession $session -V2
```

Get the history of every approved request of the current user, using the v2 endpoint

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
Secret access request ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SecretAccessRequestId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -V2
Use the v2 endpoint.
Both versions return the same history

```yaml
Type: SwitchParameter
Parameter Sets: V2
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.AccessRequests.History[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-access-requests/Get-TssSecretAccessRequestHistory](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-access-requests/Get-TssSecretAccessRequestHistory)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-access-requests/Get-TssSecretAccessRequestHistory.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-access-requests/Get-TssSecretAccessRequestHistory.ps1)
