# Remove-TssSecretPermission

## SYNOPSIS
Delete a Secret Permission

## SYNTAX

```
Remove-TssSecretPermission [-TssSession] <Session> -Id <Int32[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Delete a Secret Permission

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssSecretPermission -TssSession $session -Id 231
```

Delete the Secert Permissions 231

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
Secret Permission ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SecretPermissionId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### Thycotic.PowerShell.Common.Delete
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-permissions/Remove-TssSecretPermission](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-permissions/Remove-TssSecretPermission)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-permissions/Remove-TssSecretPermission.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-permissions/Remove-TssSecretPermission.ps1)

