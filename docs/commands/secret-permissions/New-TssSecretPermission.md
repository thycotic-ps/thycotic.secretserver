# New-TssSecretPermission

## SYNOPSIS
Create a new Secret Permission

## SYNTAX

```
New-TssSecretPermission [-TssSession] <Session> -SecretId <Int32[]> -AccessRole <SecretPermissions>
 [-DomainName <String>] [-GroupName <String>] [-Username <String>] [-Force] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Create a new Secret Permission, use -Force to break inheritance

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssSecretPermission -TssSession $session -SecretId 76 -AccessRole View -Username bob.martin
```

Adding user "bob.martin" to Secret 76, granting View rights to the Secret.

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$secrets = Search-TssSecret -TssSession $session -SearchText 'Azure'
New-TssSecretPermission -TssSession $session -SecretId $secrets.Id -AccessRole View -DomainName corp -GroupName 'IT Support' -Force
```

Adding permission to all Secrets that have "Azure" in their name to the group "corp\IT Support" with View rights, breaking inheritance if enabled.

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

### -SecretId
Secret Id

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -AccessRole
Secret Access Role Name (List, View, Edit, Owner)

```yaml
Type: SecretPermissions
Parameter Sets: (All)
Aliases:
Accepted values: List, View, Edit, Owner

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -DomainName
Domain Name (the friendly name), if user or group is an Directory Service domain

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

### -GroupName
Group Name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Username
Username

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Force
If provided will break inheritance on the secret and add the permission

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-permissions/New-TssSecretPermission](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-permissions/New-TssSecretPermission)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-permissions/New-TssSecretPermission.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-permissions/New-TssSecretPermission.ps1)

