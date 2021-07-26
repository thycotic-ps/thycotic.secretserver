# Set-TssSecretRpcAssociated

## SYNOPSIS
Set a Secret's Associated Secret for RPC Scripts

## SYNTAX

```
Set-TssSecretRpcAssociated [-TssSession] <Session> -Id <Int32[]> -AssociatedSecretId <Int32[]> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Set a Secret's Associated Secret for RPC Scripts

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecretRpcAssociated -TssSession $session -Id 42 -AssociateSecretId 342,242
```

Will update Secret 42 and set the Associated Secrets to 342 (index 1) and 242 (index 2).
This will overwrite any currently Associated Secrets.

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha/SecretServer -Credential $ssCred
$current = Get-TssSecretRpcAssociated -TssSession $session -Id 330
$updatedList = $current.AssociatedSecrets
$updatedList += 42
Set-TssSecretRpcAssociated -TssSession $session -AssociatedSecretId $updatedList
```

Pull the current Associated Secrets on Secret ID 330, add the Secret ID 42 to the end of that list (order 3), and then update Secret ID 330

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
Secret ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: ParentSecretId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AssociatedSecretId
Secret IDs to Associate

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: True
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Set-TssSecretRpcAssociated](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Set-TssSecretRpcAssociated)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Set-TssSecretRpcAssociated.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Set-TssSecretRpcAssociated.ps1)

