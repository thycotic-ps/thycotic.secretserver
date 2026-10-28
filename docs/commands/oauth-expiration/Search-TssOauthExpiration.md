---
title: Search-TssOauthExpiration
parent: Oauth Expiration
grand_parent: Commands
---
# Search-TssOauthExpiration

## SYNOPSIS
Search OAuth token expiration records

## SYNTAX

```
Search-TssOauthExpiration [-TssSession] <Session> [-UserName <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Search the OAuth token expiration records, one per issued API token that has not expired.
Pipe the output to Invoke-TssOauthExpireBulk to expire those tokens.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssOauthExpiration -TssSession $session -UserName 'svc-backup'
```

Returns the token expiration records for user svc-backup

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

### -UserName
Filter by user name

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.OauthExpiration.Summary[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/oauth-expiration/Search-TssOauthExpiration](https://thycotic-ps.github.io/thycotic.secretserver/commands/oauth-expiration/Search-TssOauthExpiration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/oauth-expiration/Search-TssOauthExpiration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/oauth-expiration/Search-TssOauthExpiration.ps1)
