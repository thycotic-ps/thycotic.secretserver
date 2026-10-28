---
title: Set-TssConfigurationSaml
parent: Configurations
grand_parent: Commands
---
# Set-TssConfigurationSaml

## SYNOPSIS
Set the global SAML configuration

## SYNTAX

```
Set-TssConfigurationSaml [-TssSession] <Session> [-Enabled] [-DisableAutoRedirect] [-UseLegacy]
 [-EnableLegacySLO] [-LegacyUsernameAttribute <String>] [-ServiceProviderName <String>]
 [-ServiceProviderCertificate <String>] [-ServiceProviderCertificatePassword <SecureString>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the global SAML settings and returns the SAML configuration.
Only the parameters you pass are changed.
Identity providers are managed with Get-TssSamlIdentityProvider, Add-TssSamlIdentityProviderCertificate and Remove-TssSamlIdentityProviderCertificate.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssConfigurationSaml -TssSession $session -Enabled -ServiceProviderName 'Secret Server'
```

Enables SAML and sets the service provider name

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssConfigurationSaml -TssSession $session -DisableAutoRedirect:$false
```

Sends users to the identity provider login page automatically

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

### -Enabled
Enable SAML authentication.
Use -Enabled:$false to disable it

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisableAutoRedirect
Do not send users to the identity provider login page automatically

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseLegacy
Use the legacy SAML implementation

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableLegacySLO
Enable single logout for the legacy SAML implementation

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -LegacyUsernameAttribute
SAML attribute used as the username by the legacy implementation

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

### -ServiceProviderName
Service provider name.
It cannot be cleared once set

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

### -ServiceProviderCertificate
Base64-encoded service provider certificate (PFX)

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

### -ServiceProviderCertificatePassword
Password of the service provider certificate

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
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

### Thycotic.PowerShell.Configuration.Saml
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssConfigurationSaml](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssConfigurationSaml)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssConfigurationSaml.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssConfigurationSaml.ps1)
