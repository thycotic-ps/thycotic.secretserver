---
title: Search-TssSecretExtended
parent: Secrets
grand_parent: Commands
---
# Search-TssSecretExtended

## SYNOPSIS
Get extended search details for secrets

## SYNTAX

```
Search-TssSecretExtended [-TssSession] <Session> -SecretId <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns, for each secret ID, whether the secret has launchers, whether it is a favorite, its total views and when it was last accessed.
Use it to add these details to Search-TssSecret results.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecretExtended -TssSession $session -SecretId (Search-TssSecret -TssSession $session -FolderId 7).Id
```

Returns the extended details of the secrets in folder 7

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
Secret IDs

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SecretIds

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Secrets.ExtendedSearchDetail[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Search-TssSecretExtended](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Search-TssSecretExtended)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Search-TssSecretExtended.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Search-TssSecretExtended.ps1)
