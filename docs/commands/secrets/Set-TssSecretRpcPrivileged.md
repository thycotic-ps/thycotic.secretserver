# Set-TssSecretRpcPrivileged

## SYNOPSIS
Set the Privileged Account for the RPC configuration on a Secret

## SYNTAX

### secret
```
Set-TssSecretRpcPrivileged [-TssSession] <Session> -Id <Int32[]> [-CredentialOnSecret] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### privileged
```
Set-TssSecretRpcPrivileged [-TssSession] <Session> -Id <Int32[]> [-PrivilegedSecretId <Int32>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Set the Privileged Account for the RPC configuration on a Secret

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecretRpcPrivileged -TssSession $session -Id 46 -PrivilegedSecretId 276
```

Set the RPC Privileged Account on Secret 46 to Secret 276

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecretRpcPrivileged -TssSession $session -Id 56 -CredentialOnSecret
```

Set the RPC Privileged Account on Secret 56 to use the Secret itself (Credentials on Secret)

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
Folder Id to modify

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SecretId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -CredentialOnSecret
Set Privileged Account to Use Credential on Secret

```yaml
Type: SwitchParameter
Parameter Sets: secret
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrivilegedSecretId
Set Privileged Account to specific Secret ID

```yaml
Type: Int32
Parameter Sets: privileged
Aliases: PrivilegedSecret

Required: False
Position: Named
Default value: 0
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Set-TssSecretRpcPrivileged](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Set-TssSecretRpcPrivileged)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Set-TssSecretRpcPrivileged.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Set-TssSecretRpcPrivileged.ps1)

