---
title: Invoke-TssOauthExpireBulk
parent: Oauth Expiration
grand_parent: Commands
---
# Invoke-TssOauthExpireBulk

## SYNOPSIS
Expire OAuth tokens by expiration record ID

## SYNTAX

```
Invoke-TssOauthExpireBulk [-TssSession] <Session> -OAuthExpirationId <Guid[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Expire OAuth tokens in bulk by their expiration record ID, as returned by Search-TssOauthExpiration.
The tokens stop working at once.
Requires the Administer Users permission.
IDs from the pipeline are sent in one request.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssOauthExpiration -TssSession $session -UserName 'svc-backup' | Invoke-TssOauthExpireBulk -TssSession $session
```

Expires every API token issued to user svc-backup

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

### -OAuthExpirationId
Expiration record ID (OAuthExpirationId from Search-TssOauthExpiration)

```yaml
Type: Guid[]
Parameter Sets: (All)
Aliases:

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

### Thycotic.PowerShell.OauthExpiration.ExpireResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/oauth-expiration/Invoke-TssOauthExpireBulk](https://thycotic-ps.github.io/thycotic.secretserver/commands/oauth-expiration/Invoke-TssOauthExpireBulk)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/oauth-expiration/Invoke-TssOauthExpireBulk.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/oauth-expiration/Invoke-TssOauthExpireBulk.ps1)
