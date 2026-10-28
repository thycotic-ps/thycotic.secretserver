---
title: Search-TssApplicationAccessRequest
parent: Application Access Requests
grand_parent: Commands
---
# Search-TssApplicationAccessRequest

## SYNOPSIS
Search application access requests by status

## SYNTAX

```
Search-TssApplicationAccessRequest [-TssSession] <Session> [-Status <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Application access requests are created by Privilege Manager when an application on a managed device asks for access through Secret Server.
Returns the requests visible to the current user, optionally filtered by status.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssApplicationAccessRequest -TssSession $session -Status Pending
```

List the pending application access requests

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
Only return requests with this status: Approved, Pending or Denied

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

### Thycotic.PowerShell.ApplicationAccessRequests.Request[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/application-access-requests/Search-TssApplicationAccessRequest](https://thycotic-ps.github.io/thycotic.secretserver/commands/application-access-requests/Search-TssApplicationAccessRequest)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/application-access-requests/Search-TssApplicationAccessRequest.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/application-access-requests/Search-TssApplicationAccessRequest.ps1)
