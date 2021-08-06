# Get-TssSecretPolicy

## SYNOPSIS
Get Secret Policy by ID

## SYNTAX

```
Get-TssSecretPolicy [-TssSession] <Session> [-Id] <Int32[]> [<CommonParameters>]
```

## DESCRIPTION
Get Secret Policy by ID

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretPolicy -TssSession $session -Id 4
```

Output Secret Policy ID 4

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretPolicy -TssSession $session -Id 4,56,23
```

Output Secret Policy ID 4, 56, and 23

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
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-policies/Get-TssSecretPolicy](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-policies/Get-TssSecretPolicy)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-policies/Get-TssSecretPolicy.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-policies/Get-TssSecretPolicy.ps1)

