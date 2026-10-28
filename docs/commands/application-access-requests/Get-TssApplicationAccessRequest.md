---
title: Get-TssApplicationAccessRequest
parent: Application Access Requests
grand_parent: Commands
---
# Get-TssApplicationAccessRequest

## SYNOPSIS
Get an application access request by device ID

## SYNTAX

```
Get-TssApplicationAccessRequest [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Application access requests are created by Privilege Manager when an application on a managed device asks for access through Secret Server.
Returns the request for the given device ID with its status (Approved, Pending or Denied).
Without permission to manage application access requests the server answers API_AccessDenied.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssApplicationAccessRequest -TssSession $session -Id 12
```

Get the application access request of device 12

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
Device ID of the application access request

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: DeviceId

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

### Thycotic.PowerShell.ApplicationAccessRequests.Request
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/application-access-requests/Get-TssApplicationAccessRequest](https://thycotic-ps.github.io/thycotic.secretserver/commands/application-access-requests/Get-TssApplicationAccessRequest)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/application-access-requests/Get-TssApplicationAccessRequest.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/application-access-requests/Get-TssApplicationAccessRequest.ps1)
