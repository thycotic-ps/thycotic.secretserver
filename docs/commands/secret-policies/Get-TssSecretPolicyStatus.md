---
title: Get-TssSecretPolicyStatus
parent: Secret Policies
grand_parent: Commands
---
# Get-TssSecretPolicyStatus

## SYNOPSIS
Get the application status of a Secret Policy

## SYNTAX

```
Get-TssSecretPolicyStatus [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns how many secrets the Secret Policy is applied to, how many are still queued to pick it up, and the completion ratio between 0 and 1.
Secret Server returns zero counts rather than an error for an ID that matches no Secret Policy.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretPolicyStatus -TssSession $session -Id 4
```

Returns the application status of Secret Policy ID 4

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecretPolicy -TssSession $session -IncludeInactive | Get-TssSecretPolicyStatus -TssSession $session
```

Returns the application status of every Secret Policy

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
Secret Policy ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SecretPolicyId

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

### Thycotic.PowerShell.SecretPolicies.Status
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-policies/Get-TssSecretPolicyStatus](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-policies/Get-TssSecretPolicyStatus)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-policies/Get-TssSecretPolicyStatus.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-policies/Get-TssSecretPolicyStatus.ps1)
