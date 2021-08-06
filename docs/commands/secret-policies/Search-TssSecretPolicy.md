# Search-TssSecretPolicy

## SYNOPSIS
Search Secret Policies

## SYNTAX

```
Search-TssSecretPolicy [-TssSession] <Session> [-PolicyName <String>] [-IncludeInactive] [-SortBy <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Search Secret Policies

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecretPolicy -TssSession $session -PolicyName 'heartbeat'
```

Search for Secret Policies with names matching "heartbeat"

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

### -PolicyName
Secret Policy names (contains)

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

### -IncludeInactive
Include inactive policies in search results

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

### -SortBy
Sort by specific property, default SecretPolicyName

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: SecretPolicyName
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.SecretPolicies.Summary
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-policies/Search-TssSecretPolicy](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-policies/Search-TssSecretPolicy)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-policies/Search-TssSecretPolicy.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-policies/Search-TssSecretPolicy.ps1)

