---
title: Search-TssEventPipelinePolicySecretPolicy
parent: Event Pipeline Policies
grand_parent: Commands
---
# Search-TssEventPipelinePolicySecretPolicy

## SYNOPSIS
Get the secret policies that use an event pipeline policy

## SYNTAX

```
Search-TssEventPipelinePolicySecretPolicy [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the secret policies an event pipeline policy is assigned to.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssEventPipelinePolicySecretPolicy -TssSession $session -Id 3
```

Returns the secret policies that use event pipeline policy 3

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
Event pipeline policy ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: EventPipelinePolicyId

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

### Thycotic.PowerShell.SecretPolicies.Summary[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policies/Search-TssEventPipelinePolicySecretPolicy](https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policies/Search-TssEventPipelinePolicySecretPolicy)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Search-TssEventPipelinePolicySecretPolicy.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Search-TssEventPipelinePolicySecretPolicy.ps1)
