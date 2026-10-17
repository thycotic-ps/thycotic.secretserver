---
title: Search-TssApplicationAccessRequestAudit
parent: Application Access Requests
grand_parent: Commands
---
# Search-TssApplicationAccessRequestAudit

## SYNOPSIS
Search the audit records of application access requests

## SYNTAX

```
Search-TssApplicationAccessRequestAudit [-TssSession] <Session> -DeviceId <Int32>
 [<CommonParameters>]
```

## DESCRIPTION
Application access requests are created by Privilege Manager when an application on a managed device asks for access through Secret Server.
Returns the audit records (action, date, IP address) of the application access request of one device.
The device ID is required: without it the server answers 500.
Without permission to manage application access requests the server answers API_AccessDenied.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssApplicationAccessRequestAudit -TssSession $session -DeviceId 12
```

List the audit records of the application access request of device 12

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

### -DeviceId
Device ID whose audit records to return; required by the server

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.ApplicationAccessRequests.Audit[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/application-access-requests/Search-TssApplicationAccessRequestAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/application-access-requests/Search-TssApplicationAccessRequestAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/application-access-requests/Search-TssApplicationAccessRequestAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/application-access-requests/Search-TssApplicationAccessRequestAudit.ps1)
