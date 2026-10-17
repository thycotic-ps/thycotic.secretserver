---
title: Update-TssSecretAssociatedSecret
parent: Secrets
grand_parent: Commands
---
# Update-TssSecretAssociatedSecret

## SYNOPSIS
Set the secrets associated with a custom launcher on a secret

## SYNTAX

```
Update-TssSecretAssociatedSecret [-TssSession] <Session> -Id <Int32> -LauncherId <Int32>
 -AssociatedSecretId <Int32[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sets the ordered list of secrets a custom launcher on the secret pulls credentials from.
The list replaces the current one; pass an empty array to clear it.
The custom launcher must already be associated with the secret (normally through its secret template), otherwise Secret Server returns an error.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssSecretAssociatedSecret -TssSession $session -Id 42 -LauncherId 4 -AssociatedSecretId 100, 101
```

Associates secrets 100 and 101, in that order, with custom launcher 4 on secret 42

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssSecretAssociatedSecret -TssSession $session -Id 42 -LauncherId 4 -AssociatedSecretId @()
```

Clears the associated secrets of custom launcher 4 on secret 42

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

### -LauncherId
Custom launcher ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -AssociatedSecretId
Secret IDs to associate, in order.
An empty array clears the list

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

### Thycotic.PowerShell.Secrets.CustomLauncherSettings[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Update-TssSecretAssociatedSecret](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Update-TssSecretAssociatedSecret)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Update-TssSecretAssociatedSecret.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Update-TssSecretAssociatedSecret.ps1)
