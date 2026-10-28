---
title: Update-TssSecretEraseRequest
parent: Secret Erase Requests
grand_parent: Commands
---
# Update-TssSecretEraseRequest

## SYNOPSIS
Approve, deny, cancel or reschedule a secret erase request

## SYNTAX

```
Update-TssSecretEraseRequest [-TssSession] <Session> -Id <Int32> -Status <String> [-EraseAfter <DateTime>]
 [-Comment <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a secret erase request.
Approvers set Status to Approved or Denied; the requester can set Canceled.
-EraseAfter moves the erase date.
Requires the Secret Erase feature.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssSecretEraseRequest -TssSession $session -Id 17 -Status Approved -Comment 'Approved by security'
```

Approves secret erase request 17

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretEraseRequestInbox -TssSession $session -Status Pending -IsMyRequest | Update-TssSecretEraseRequest -TssSession $session -Status Canceled
```

Cancels all of your pending secret erase requests

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
Type: Int32
Parameter Sets: (All)
Aliases: SecretEraseRequestId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Status
New status: approvers set Approved or Denied, the requester sets Canceled

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

### -EraseAfter
New date after which the secrets are erased

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

### -Comment
Comment recorded with the response

```yaml
Type: String
Parameter Sets: (All)
Aliases: ResponseComment

Required: False
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

### Thycotic.PowerShell.EraseRequests.ActionResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-erase-requests/Update-TssSecretEraseRequest](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-erase-requests/Update-TssSecretEraseRequest)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-erase-requests/Update-TssSecretEraseRequest.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-erase-requests/Update-TssSecretEraseRequest.ps1)
