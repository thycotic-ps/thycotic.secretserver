---
title: Get-TssSecretAccessRequestPending
parent: Secret Access Requests
grand_parent: Commands
---
# Get-TssSecretAccessRequestPending

## SYNOPSIS
Get a secret access request with its current and eligible reviewers

## SYNTAX

### Default (Default)
```
Get-TssSecretAccessRequestPending [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

### V2
```
Get-TssSecretAccessRequestPending [-TssSession] <Session> -Id <Int32[]> [-V2]
 [<CommonParameters>]
```

## DESCRIPTION
Returns a secret access request by ID.
While the request is Pending the result also lists the approvers of the current workflow step and the reviewers eligible to act on it.
Without -V2 a revoked request is reported as Denied; with -V2 the Revoked state is returned.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretAccessRequestPending -TssSession $session -Id 17
```

Get access request 17 with its current and eligible reviewers

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretAccessRequestPending -TssSession $session -Id 17 -V2
```

Get access request 17 using the v2 endpoint, which reports the Revoked state

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.AccessRequests.Pending
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-access-requests/Get-TssSecretAccessRequestPending](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-access-requests/Get-TssSecretAccessRequestPending)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-access-requests/Get-TssSecretAccessRequestPending.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-access-requests/Get-TssSecretAccessRequestPending.ps1)
