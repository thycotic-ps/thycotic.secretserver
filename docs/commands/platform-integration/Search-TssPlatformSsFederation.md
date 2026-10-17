---
title: Search-TssPlatformSsFederation
parent: Platform Integration
grand_parent: Commands
---
# Search-TssPlatformSsFederation

## SYNOPSIS
Get the Secret Server federations for Platform integration

## SYNTAX

```
Search-TssPlatformSsFederation [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Get the OpenID Connect and SAML federations of this Secret Server that Platform data integration would consume.
Returns one object with an OidcFederations and a SamlFederations list.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Search-TssPlatformSsFederation -TssSession $session).SamlFederations
```

List the SAML federations

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

### Thycotic.PowerShell.PlatformIntegration.SsFederation
## NOTES
Requires TssSession object returned by New-TssSession

Requires Platform integration: a Secret Server without it answers 500 API_PlatformNotEnabled.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-integration/Search-TssPlatformSsFederation](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-integration/Search-TssPlatformSsFederation)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-integration/Search-TssPlatformSsFederation.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-integration/Search-TssPlatformSsFederation.ps1)
