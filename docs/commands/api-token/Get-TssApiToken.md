---
title: Get-TssApiToken
parent: Api Token
grand_parent: Commands
---
# Get-TssApiToken

## SYNOPSIS
Generate a new API token for the current user

## SYNTAX

```
Get-TssApiToken [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Generate a new API token for the user that owns the session.
Each call returns a new token, earlier tokens stay valid until they expire.
The output carries the token value in GeneratedToken: treat it as a credential.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$token = Get-TssApiToken -TssSession $session
```

Generates a new API token and stores the output in $token

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

### Thycotic.PowerShell.ApiToken.Token
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/api-token/Get-TssApiToken](https://thycotic-ps.github.io/thycotic.secretserver/commands/api-token/Get-TssApiToken)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/api-token/Get-TssApiToken.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/api-token/Get-TssApiToken.ps1)
