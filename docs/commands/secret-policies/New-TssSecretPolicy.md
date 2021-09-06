# New-TssSecretPolicy

## SYNOPSIS
Create a new Secret Policy

## SYNTAX

```
New-TssSecretPolicy [-TssSession] <Session> -Name <String> [-Description <String>] [-Active]
 [-PolicyItem <PolicyItem[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create a new Secret Policy, configure Policy Items using Update-TssSecretPolicy

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssSecretPolicy -TssSession $session -Name 'Require Checkout'
```

Create a new secret policy setting enforcing various policy items

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$policyItem1 = Get-TssSecretPolicyItemStub -TssSession $session -ItemName AssociatedSecretId1 -ApplyType Enforced
$policyItem1.ValueSecretId = 54
$policyItem2 = Get-TssSecretPolicyItemStub -TssSession $session -ItemName AssociatedSecretId2 -ApplyType Enforced
$policyItem2.ValueSecretId = 65
New-TssSecretPolicy -TssSession $session -Name 'Policy - Associated Secrets Enforced' -Active -PolicyItem $policyItem1, $policyItem2
```

Create a new secret policy, configuring Associated Secret 1 and 2 policy items.

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

### -Name
Secret Policy Name

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

### -Description
Secret Policy Description

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

### -Active
Activate the policy after creation

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PolicyItem
Policy Item(s) to add (utilize Get-TssSecretPolicyItemStub to create each object)

```yaml
Type: PolicyItem[]
Parameter Sets: (All)
Aliases:

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

### Thycotic.PowerShell.SecretPolicies.Policy
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-policies/New-TssSecretPolicy](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-policies/New-TssSecretPolicy)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-policies/New-TssSecretPolicy.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-policies/New-TssSecretPolicy.ps1)

