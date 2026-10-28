---
title: Set-TssApplicationAccessRequest
parent: Application Access Requests
grand_parent: Commands
---
# Set-TssApplicationAccessRequest

## SYNOPSIS
Approve or deny an application access request

## SYNTAX

```
Set-TssApplicationAccessRequest [-TssSession] <Session> -Id <Int32> -Status <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Application access requests are created by Privilege Manager when an application on a managed device asks for access through Secret Server.
Sets the status of the request for the given device ID and returns the updated request.
Without permission to manage application access requests the server answers API_AccessDenied.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssApplicationAccessRequest -TssSession $session -Id 12 -Status Approved
```

Approve the application access request of device 12

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssApplicationAccessRequest -TssSession $session -Status Pending | Set-TssApplicationAccessRequest -TssSession $session -Status Denied
```

Deny every pending application access request

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
Type: Int32
Parameter Sets: (All)
Aliases: DeviceId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Status
New status: Approved, Pending or Denied

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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

### Thycotic.PowerShell.ApplicationAccessRequests.Request
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/application-access-requests/Set-TssApplicationAccessRequest](https://thycotic-ps.github.io/thycotic.secretserver/commands/application-access-requests/Set-TssApplicationAccessRequest)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/application-access-requests/Set-TssApplicationAccessRequest.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/application-access-requests/Set-TssApplicationAccessRequest.ps1)
