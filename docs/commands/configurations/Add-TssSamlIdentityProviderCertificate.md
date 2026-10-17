---
title: Add-TssSamlIdentityProviderCertificate
parent: Configurations
grand_parent: Commands
---
# Add-TssSamlIdentityProviderCertificate

## SYNOPSIS
Add a certificate to a SAML identity provider

## SYNTAX

```
Add-TssSamlIdentityProviderCertificate [-TssSession] <Session> -IdentityProviderId <Int32>
 -CertificateData <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Uploads a public certificate for a SAML identity provider and returns the new certificate entry.
Secret Server uses the certificate to validate SAML messages signed by that provider.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$certificate = [System.Convert]::ToBase64String([System.IO.File]::ReadAllBytes('./idp-signing.cer'))
Add-TssSamlIdentityProviderCertificate -TssSession $session -IdentityProviderId 2 -CertificateData $certificate
```

Adds the certificate in idp-signing.cer to SAML identity provider 2

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

### -IdentityProviderId
SAML identity provider ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -CertificateData
Base64-encoded public certificate of the identity provider

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
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

### Thycotic.PowerShell.Configuration.SamlIdentityProviderCertificate
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Add-TssSamlIdentityProviderCertificate](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Add-TssSamlIdentityProviderCertificate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Add-TssSamlIdentityProviderCertificate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Add-TssSamlIdentityProviderCertificate.ps1)
