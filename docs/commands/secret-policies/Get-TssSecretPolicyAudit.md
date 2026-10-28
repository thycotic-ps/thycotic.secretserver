---
title: Get-TssSecretPolicyAudit
parent: Secret Policies
grand_parent: Commands
---
# Get-TssSecretPolicyAudit

## SYNOPSIS
Get the audit trail of a Secret Policy

## SYNTAX

```
Get-TssSecretPolicyAudit [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns one entry per change made to a Secret Policy: who made it, when, the action, and any notes.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretPolicyAudit -TssSession $session -Id 4
```

Returns the audit entries for Secret Policy ID 4

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecretPolicy -TssSession $session -PolicyName 'Windows' -IncludeInactive | Get-TssSecretPolicyAudit -TssSession $session
```

Returns the audit entries for every Secret Policy with "Windows" in the name

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

### Thycotic.PowerShell.SecretPolicies.Audit[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-policies/Get-TssSecretPolicyAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-policies/Get-TssSecretPolicyAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-policies/Get-TssSecretPolicyAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-policies/Get-TssSecretPolicyAudit.ps1)
