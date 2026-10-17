---
title: Search-TssSecretFavorite
parent: Secrets
grand_parent: Commands
---
# Search-TssSecretFavorite

## SYNOPSIS
Get the favorite secrets of the current user

## SYNTAX

```
Search-TssSecretFavorite [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the ID, name, folder ID and folder path of each secret the current user marked as a favorite.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecretFavorite -TssSession $session
```

Returns your favorite secrets

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Secrets.Favorite[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Search-TssSecretFavorite](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Search-TssSecretFavorite)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Search-TssSecretFavorite.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Search-TssSecretFavorite.ps1)
