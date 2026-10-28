---
title: New-TssSecretAccessRequest
parent: Secret Access Requests
grand_parent: Commands
---
# New-TssSecretAccessRequest

## SYNOPSIS
Create a secret access request

## SYNTAX

### Default (Default)
```
New-TssSecretAccessRequest [-TssSession] <Session> [-ExpirationDate <DateTime>] [-RequestComment <String>]
 -SecretId <Int32> [-StartDate <DateTime>] [-TicketNumber <String>] [-TicketSystemId <Int32>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### V2
```
New-TssSecretAccessRequest [-TssSession] <Session> [-ExpirationDate <DateTime>] [-RequestComment <String>]
 -SecretId <Int32> [-StartDate <DateTime>] [-TicketNumber <String>] [-TicketSystemId <Int32>] [-V2]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates an access request for a secret that requires approval before it can be viewed (Request Access on the secret, or a secret workflow).
The request is created for the current user.
The approvers are notified and the request stays Pending until it is approved, denied or canceled.
The secret must require approval (otherwise the server answers API_AccessApprovalNotRequired).
Pass -StartDate and -ExpirationDate: the v2 endpoint rejects a request without them, and a window that overlaps another pending request of the same user is rejected.
Without -V2 the v1 endpoint is used, which reports a revoked request as Denied.
With -V2 the v2 endpoint is used, which returns the Revoked state.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssSecretAccessRequest -TssSession $session -SecretId 42 -RequestComment 'Patch window for app servers' -StartDate (Get-Date) -ExpirationDate (Get-Date).AddHours(4)
```

Request four hours of access to secret 42, starting now

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssSecretAccessRequest -TssSession $session -SecretId 42 -TicketSystemId 1 -TicketNumber CHG0012345 -V2
```

Request access to secret 42 with a change ticket, using the v2 endpoint

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

### -ExpirationDate
End of the requested access window

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequestComment
Reason for the request, shown to the approvers

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
Secret ID to request access to

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

### -StartDate
Start of the requested access window

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TicketNumber
Ticket number from the ticket system, when the secret requires one

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

### -TicketSystemId
Ticket system ID, when the secret requires a ticket

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

### -V2
Use the v2 endpoint.
v2 returns the Revoked state; v1 reports a revoked request as Denied

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

### Thycotic.PowerShell.AccessRequests.Request
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-access-requests/New-TssSecretAccessRequest](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-access-requests/New-TssSecretAccessRequest)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-access-requests/New-TssSecretAccessRequest.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-access-requests/New-TssSecretAccessRequest.ps1)
