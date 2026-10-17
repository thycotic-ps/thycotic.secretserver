---
title: Get-TssSamlIdentityProvider
parent: Configurations
grand_parent: Commands
---
# Get-TssSamlIdentityProvider

## SYNOPSIS
Get a SAML identity provider

## SYNTAX

```
Get-TssSamlIdentityProvider [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns a SAML identity provider by ID, with its settings and certificates.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSamlIdentityProvider -TssSession $session -Id 2
```

Returns SAML identity provider 2

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
SAML identity provider ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: IdentityProviderId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Configuration.SamlIdentityProvider
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssSamlIdentityProvider](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssSamlIdentityProvider)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssSamlIdentityProvider.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssSamlIdentityProvider.ps1)
