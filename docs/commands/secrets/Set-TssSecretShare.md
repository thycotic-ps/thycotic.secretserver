---
title: Set-TssSecretShare
parent: Secrets
grand_parent: Commands
---
# Set-TssSecretShare

## SYNOPSIS
Turn permission inheritance on or off for a secret

## SYNTAX

```
Set-TssSecretShare [-TssSession] <Session> -Id <Int32> [-InheritPermissions]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sets whether the secret inherits permissions from its folder.
Turn inheritance off before adding explicit permissions with New-TssSecretPermission.
Secret Server rejects turning it on for a secret in the root folder.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecretShare -TssSession $session -Id 42 -InheritPermissions:$false
```

Breaks permission inheritance on secret 42

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecretShare -TssSession $session -Id 42 -InheritPermissions
```

Makes secret 42 inherit permissions from its folder again

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
Type: Int32
Parameter Sets: (All)
Aliases: SecretId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InheritPermissions
Inherit permissions from the folder.
Use -InheritPermissions:$false to break inheritance

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

### Thycotic.PowerShell.Secrets.Share
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Set-TssSecretShare](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Set-TssSecretShare)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Set-TssSecretShare.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Set-TssSecretShare.ps1)
