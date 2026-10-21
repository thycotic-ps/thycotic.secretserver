---
title: Test-TssPlatformIntegration
parent: Platform
grand_parent: Commands
---
# Test-TssPlatformIntegration

## SYNOPSIS
Test the Delinea Platform integration of a Secret Server instance

## SYNTAX

```
Test-TssPlatformIntegration [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Asks Secret Server whether Delinea Platform integration is configured and whether the session token was issued by that Platform.
With a Delinea Platform access token (New-TssSession -AccessToken) every flag is True when the vault is integrated with the Platform that issued the token.
Every flag is False when the session token is not a Platform token the server accepts, for example a Secret Server token or an instance with no Platform integration.
The endpoint allows anonymous access; the session token is sent so the server can inspect it.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://vault.secretservercloud.com -AccessToken $platformToken
Test-TssPlatformIntegration -TssSession $session
```

Uses a Delinea Platform access token and shows whether the vault accepts the Platform token and matches the Platform issuer

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Test-TssPlatformIntegration -TssSession $session).HasIntegrationConfigured
```

Returns False for a Secret Server token, because the server only reports integration details for a Platform token

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

### Thycotic.PowerShell.Platform.Integration
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Test-TssPlatformIntegration](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Test-TssPlatformIntegration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Test-TssPlatformIntegration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Test-TssPlatformIntegration.ps1)
