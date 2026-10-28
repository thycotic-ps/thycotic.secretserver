---
title: Set-TssSecretFavorite
parent: Secrets
grand_parent: Commands
---
# Set-TssSecretFavorite

## SYNOPSIS
Add or remove a secret from your favorites

## SYNTAX

```
Set-TssSecretFavorite [-TssSession] <Session> -Id <Int32[]> -Favorite <Boolean>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sets the favorite flag of a secret for the current user and returns the new state.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecretFavorite -TssSession $session -Id 42 -Favorite $true
```

Adds secret 42 to your favorites

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecretFavorite -TssSession $session | Set-TssSecretFavorite -TssSession $session -Favorite $false
```

Removes all of your favorites

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
Aliases: SecretId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Favorite
$true adds the secret to your favorites, $false removes it

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: IsFavorite

Required: True
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

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Set-TssSecretFavorite](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Set-TssSecretFavorite)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Set-TssSecretFavorite.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Set-TssSecretFavorite.ps1)
