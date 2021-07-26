# Update-TssSecretPermission

## SYNOPSIS
Update a Secret Permission

## SYNTAX

```
Update-TssSecretPermission [-TssSession] <Session> -Id <Int32[]> -SecretId <Int32> -AccessRole <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Update a Secret Permission

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecretPermission -TssSession $session -Id 242
```

Update Secret Permission 242, setting access role to View

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

### -SecretId
Secret Permission ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AccessRole
Granted Role name

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

### Thycotic.PowerShell.SecretPermissions.Permission
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-permissions/Set-TssSecretPermission](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-permissions/Set-TssSecretPermission)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-permission/Set-TssSecretPermission.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-permission/Set-TssSecretPermission.ps1)

