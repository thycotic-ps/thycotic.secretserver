---
title: Set-TssProxyRdpConfiguration
parent: Proxy
grand_parent: Commands
---
# Set-TssProxyRdpConfiguration

## SYNOPSIS
Set the RDP proxy configuration

## SYNTAX

### Default (Default)
```
Set-TssProxyRdpConfiguration [-TssSession] <Session> [-EnableRdpProxy] [-RdpProxyPort <Int32>]
 [-EnableRemoteHostValidation] [-AllowSiteSelectionForActiveDirectoryAccounts]
 [-DaysToKeepOperationalLogs <Int32>] [-SspiAuthenticationMethod <String>] [-ProxyNewSecretsByDefault]
 [-EnableRdpGateway] [-RdpGatewayPort <Int32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### Certificate
```
Set-TssProxyRdpConfiguration [-TssSession] <Session> [-EnableRdpProxy] [-RdpProxyPort <Int32>]
 [-EnableRemoteHostValidation] [-AllowSiteSelectionForActiveDirectoryAccounts]
 [-DaysToKeepOperationalLogs <Int32>] [-SspiAuthenticationMethod <String>] [-ProxyNewSecretsByDefault]
 [-EnableRdpGateway] [-RdpGatewayPort <Int32>] -CertificatePath <String> [-CertificatePassword <SecureString>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the RDP proxy configuration.
Only the parameters provided are changed.
Use -CertificatePath to upload a PFX certificate for the RDP proxy, with -CertificatePassword when the file is protected.
Returns the RDP proxy configuration after the change.
The response includes key material: treat the output as sensitive, do not log it or write it to disk unprotected.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssProxyRdpConfiguration -TssSession $session -EnableRdpProxy -RdpProxyPort 4489 | Out-Null
```

Enables the RDP proxy on port 4489

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$pfxPassword = Read-Host -AsSecureString -Prompt 'PFX password'
Set-TssProxyRdpConfiguration -TssSession $session -CertificatePath ./rdp-proxy.pfx -CertificatePassword $pfxPassword | Out-Null
```

Uploads a PFX certificate for the RDP proxy

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

### -EnableRdpProxy
Enable or disable the RDP proxy

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

### -RdpProxyPort
Port the RDP proxy listens on (1-65535)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableRemoteHostValidation
Enforce certificate validation on the remote hosts the proxy connects to

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

### -AllowSiteSelectionForActiveDirectoryAccounts
Allow users to pick a site when launching or generating proxy credentials for an RDP proxied secret

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

### -DaysToKeepOperationalLogs
Number of days to keep RDP proxy logs (1 or more)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SspiAuthenticationMethod
Authentication method for SSPI connections

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

### -ProxyNewSecretsByDefault
Create new RDP secrets with proxying enabled

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

### -EnableRdpGateway
Enable or disable the RDP gateway

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

### -RdpGatewayPort
Port the RDP gateway listens on (1-65535)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -CertificatePath
Path to a PFX file to upload as the RDP proxy server certificate

```yaml
Type: String
Parameter Sets: Certificate
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CertificatePassword
Password of the PFX file given in CertificatePath

```yaml
Type: SecureString
Parameter Sets: Certificate
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

### Thycotic.PowerShell.Proxy.RdpConfiguration
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Set-TssProxyRdpConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Set-TssProxyRdpConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Set-TssProxyRdpConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Set-TssProxyRdpConfiguration.ps1)
