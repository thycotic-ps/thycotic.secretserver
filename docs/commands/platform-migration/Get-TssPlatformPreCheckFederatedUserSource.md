---
title: Get-TssPlatformPreCheckFederatedUserSource
parent: Platform Migration
grand_parent: Commands
---
# Get-TssPlatformPreCheckFederatedUserSource

## SYNOPSIS
Get the Delinea Platform migration pre-check of federated user sources

## SYNTAX

```
Get-TssPlatformPreCheckFederatedUserSource [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the migration pre-check summary of the SAML and OpenID Connect user sources: totals, valid counts and the errors that would prevent or affect their migration to the Delinea Platform.
Requires Delinea Platform integration on the Secret Server instance; without it the server returns an error (API_PlatformNotEnabled).

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPlatformPreCheckFederatedUserSource -TssSession $session
```

Returns the SAML and OpenID Connect pre-check totals and errors

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssPlatformPreCheckFederatedUserSource -TssSession $session).Errors
```

Returns only the pre-check errors

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

### Thycotic.PowerShell.PlatformMigration.PlatformPreCheckFederatedUserSource
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Get-TssPlatformPreCheckFederatedUserSource](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Get-TssPlatformPreCheckFederatedUserSource)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Get-TssPlatformPreCheckFederatedUserSource.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Get-TssPlatformPreCheckFederatedUserSource.ps1)
