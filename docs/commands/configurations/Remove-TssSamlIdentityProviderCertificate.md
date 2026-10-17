---
title: Remove-TssSamlIdentityProviderCertificate
parent: Configurations
grand_parent: Commands
---
# Remove-TssSamlIdentityProviderCertificate

## SYNOPSIS
Remove a certificate from a SAML identity provider

## SYNTAX

```
Remove-TssSamlIdentityProviderCertificate [-TssSession] <Session> -IdentityProviderId <Int32> -Id <Int32>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes a certificate of a SAML identity provider.
Returns True when Secret Server removed it.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssSamlIdentityProviderCertificate -TssSession $session -IdentityProviderId 2 -Id 5
```

Removes certificate 5 from SAML identity provider 2

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

### -Id
Certificate ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: CertificateId

Required: True
Position: Named
Default value: 0
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

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Remove-TssSamlIdentityProviderCertificate](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Remove-TssSamlIdentityProviderCertificate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Remove-TssSamlIdentityProviderCertificate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Remove-TssSamlIdentityProviderCertificate.ps1)
