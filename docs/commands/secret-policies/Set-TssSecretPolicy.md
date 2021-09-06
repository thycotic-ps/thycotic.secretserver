# Set-TssSecretPolicy

## SYNOPSIS
Set a Secret Policy property

## SYNTAX

### policy (Default)
```
Set-TssSecretPolicy [-TssSession] <Session> -Id <Int32> [-Name <String>] [-Description <String>] [-Active]
 [-PolicyItem <PolicyItem[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### item
```
Set-TssSecretPolicy [-TssSession] <Session> -Id <Int32> [-PolicyItem <PolicyItem[]>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Set a Secret Policy property

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential ssCred
Set-TssSecretPolicy -TssSession $session -Id 52 -Active:$false
```

Set Secret Policy ID 52 to inactive, changing Active property to false

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential ssCred
$cPolicy = Get-TssSecretPolicy -TssSession $session -Id 1
$cPolicy.SecretPolicyItems[0].ValueSecretId = 43
Set-TssSecretPolicy -TssSession $session -Id 1 -PolicyItem $cPolicy.SecretPolicyItems[0]
```

Get current Secret Policy ID 1, set the ValueSecretId to 43 (for the AssociatedSecretId1 item)

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
Type: Int32
Parameter Sets: (All)
Aliases: SecretPolicyId

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Secret Policy Name

```yaml
Type: String
Parameter Sets: policy
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Secret Policy Description

```yaml
Type: String
Parameter Sets: policy
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Active
Secret Policy Active or Inactive

```yaml
Type: SwitchParameter
Parameter Sets: policy
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

## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-policies/Set-TssSecretPolicy](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-policies/Set-TssSecretPolicy)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-policies/Set-TssSecretPolicy.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-policies/Set-TssSecretPolicy.ps1)

