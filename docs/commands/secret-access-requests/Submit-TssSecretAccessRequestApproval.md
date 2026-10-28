---
title: Submit-TssSecretAccessRequestApproval
parent: Secret Access Requests
grand_parent: Commands
---
# Submit-TssSecretAccessRequestApproval

## SYNOPSIS
Submit an approval decision for a secret access request by approval ID

## SYNTAX

### Default (Default)
```
Submit-TssSecretAccessRequestApproval [-TssSession] <Session> -ApprovalId <Guid> [-Hours <Int32>]
 -Status <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### V2
```
Submit-TssSecretAccessRequestApproval [-TssSession] <Session> -ApprovalId <Guid> [-Hours <Int32>]
 -Status <String> [-V2] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Approves or denies a secret access request using the approval ID (a GUID) that Secret Server puts in the approval links of its notification emails.
Use Update-TssSecretAccessRequest instead when you have the numeric access request ID.
The endpoint accepts anonymous calls; the cmdlet still sends the session token.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Submit-TssSecretAccessRequestApproval -TssSession $session -ApprovalId 3f2b8c1e-5d4a-4e7b-9c3d-2a1b0c9d8e7f -Status Approved -Hours 2
```

Approve the request behind the approval ID for two hours

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Submit-TssSecretAccessRequestApproval -TssSession $session -ApprovalId 3f2b8c1e-5d4a-4e7b-9c3d-2a1b0c9d8e7f -Status Denied -V2
```

Deny the request behind the approval ID, using the v2 endpoint

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

### -ApprovalId
Approval ID (GUID) from the approval link

```yaml
Type: Guid
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Hours
Number of hours of access to grant when approving

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

### -Status
Decision: Approved or Denied

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

### -V2
Use the v2 endpoint.
Both versions apply the decision the same way

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

### Thycotic.PowerShell.AccessRequests.ApprovalResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-access-requests/Submit-TssSecretAccessRequestApproval](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-access-requests/Submit-TssSecretAccessRequestApproval)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-access-requests/Submit-TssSecretAccessRequestApproval.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-access-requests/Submit-TssSecretAccessRequestApproval.ps1)
