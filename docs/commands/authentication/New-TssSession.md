---
title: New-TssSession
parent: Authentication
grand_parent: Commands
---
# New-TssSession

## SYNOPSIS
Create new session

## SYNTAX

### platformToken
```
New-TssSession [-SecretServer <Uri>] -AccessToken <Object> -PlatformUrl <Uri> [-VaultId <String>]
 [-AllowedVaultHost <String[]>] [-SkipCertificateCheck] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### platform
```
New-TssSession [-SecretServer <Uri>] -Credential <PSCredential> -PlatformUrl <Uri> [-VaultId <String>]
 [-AllowedVaultHost <String[]>] [-AutoRefresh] [-SkipCertificateCheck] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### clientSdk
```
New-TssSession -SecretServer <Uri> [-UseSdkClient] -ConfigPath <String> [-SkipCertificateCheck] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### winauth
```
New-TssSession -SecretServer <Uri> [-UseWindowsAuth] [-SkipCertificateCheck] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### sdk
```
New-TssSession -SecretServer <Uri> -AccessToken <Object> [-SkipCertificateCheck] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### new
```
New-TssSession -SecretServer <Uri> [-Credential] <PSCredential> [[-OtpCode] <String>] [-SkipCertificateCheck]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create a new TssSession for working with a Secret Server

With -PlatformUrl the session authenticates to the Delinea Platform instead: -Credential takes a Platform service user (client credentials grant, scope xpmheadless) or -AccessToken takes a Platform access token you already have.
The Platform vault broker supplies the Secret Server vault URL (the active vault with -VaultId, else the global default, else the default, else the first active vault) and the Platform token is sent to that vault.
The vault URL must use https and its host must be a Secret Server Cloud host, the Platform host itself, or a host listed in -AllowedVaultHost; nothing is sent to any other host.

## EXAMPLES

### EXAMPLE 1
```
$cred = [PSCredential]::new('apiuser',(ConvertTo-SecureString -String 'Fancy%$#Pa33w0rd' -AsPlainText -Force))
$session = New-TssSession -SecretServer https://ssvault.com/SecretServer -Credential $cred
```

A PSCredential is created for the apiuser account.
The internal TssSession is updated upon successful authentication, and then output to the console.

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://ssvault.com/SecretServer -Credential (Get-Credential apiuser)
```

A prompt to enter the password for the apiuser is given by PowerShell.
Upon successful authentication the response from the oauth2/token endpoint is output to the console.

### EXAMPLE 3
```
$tssSdkParams = @{
    SecretServer = 'https://ssvault.com/SecretServer'
    RuleName = 'tss_module'
    ConfigPath = 'c:\thycotic'
    Force = $true
}
Initialize-TssSdk @tssSdkParams
$session = New-TssSession -SecretServer https://ssvault.com/SecretServer -UseSdkClient -ConfigPath c:\thycotic
```

Use packaged Client SDK and initialize for vault using Onboarding Client rule and configuration path.
Create a new TssSession object that uses the initialized Client SDK under the configuration path "c:\thycotic"

### EXAMPLE 4
```
$session = nts https://ssvault.com/SecretServer -UseWindowsAuth
```

Create a session object utilizing Windows Integrated Authentication (IWA)
Use the alias nts to create a session object

### EXAMPLE 5
```
$session = New-TssSession -SecretServer https://vault.secretservercloud.com -Credential $cred -OtpCode 256380
Show-TssCurrentUser -TssSession $session
```

Create a session object using OAuth2 credential and 2FA/OTP code.
Then output the current user to verify toke is for the specific user credential.

### EXAMPLE 6
```
$session = New-TssSession -SecretServer https://vault.secretservercloud.com -Credential $cred
$secrets = Search-TssSecret -TssSession $session
foreach ($s in $secrets) {
    if ($session.CheckTokenTtl(3)) { $session.SessionRefresh() }
    # code to execute against each Secret
}
$session.SessionExpire()
```

Creates a session object and pulls a list of Secrets to process.
Uses method CheckTokenTtl() on the TssSession object if the TimeOfDeath is within 3 minutes of expiring will run the SessionRefresh() method to request a new access token.
Once processing is complete, run the SessionExpire() method to expire the access token.

### EXAMPLE 7
```
$serviceUser = Get-Credential platform-automation
$session = New-TssSession -PlatformUrl https://mytenant.delinea.app -Credential $serviceUser
Search-TssFolder -TssSession $session
```

Authenticates the Delinea Platform service user platform-automation with the client credentials grant, finds the default Secret Server vault through the Platform vault broker, and searches folders in that vault.

### EXAMPLE 8
```
$session = New-TssSession -PlatformUrl https://mytenant.delinea.app -Credential $serviceUser -AutoRefresh
if ($session.CheckTokenTtl(5)) { $session.SessionRefresh() }
```

Creates a Platform session that keeps the service user client secret (as a SecureString) so SessionRefresh() can request a new Platform access token when fewer than 5 minutes remain.

### EXAMPLE 9
```
$session = New-TssSession -PlatformUrl https://mytenant.delinea.app -AccessToken $platformToken -VaultId 5b2e8f1c-0d3a-4b7e-9c61-2f4a8d9e0b13
```

Uses a Delinea Platform access token obtained elsewhere, validates it with the Platform vault broker, and connects to the active vault with that id.

### EXAMPLE 10
```
$session = New-TssSession -PlatformUrl https://mytenant.delinea.app -Credential $serviceUser -SecretServer https://vault.example.com/SecretServer -AllowedVaultHost vault.example.com
```

Sends the Platform token to an on-premises Secret Server connected to the Platform.
The host is not a Secret Server Cloud host, so it is trusted only because -AllowedVaultHost lists it.

## PARAMETERS

### -SecretServer
Secret Server URL.
With -PlatformUrl, the vault URL to use instead of the vault broker answer (with -Credential the vault broker is not called).

```yaml
Type: Uri
Parameter Sets: platformToken, platform
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: Uri
Parameter Sets: clientSdk, winauth, sdk, new
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Specify a Secret Server user account.
With -PlatformUrl, a Delinea Platform service user: the user name is the client id and the password is the client secret.

```yaml
Type: PSCredential
Parameter Sets: new
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: PSCredential
Parameter Sets: platform
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OtpCode
Provide 2FA code.
Quote the value to preserve any leading zeros (e.g. `'012345'`).

```yaml
Type: String
Parameter Sets: new
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AccessToken
Specify Access Token.
With -PlatformUrl, a Delinea Platform access token you already have; it is validated with the Platform vault broker.

```yaml
Type: Object
Parameter Sets: platformToken, sdk
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseWindowsAuth
Utilize Windows Authentication (IWA)

```yaml
Type: SwitchParameter
Parameter Sets: winauth
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSdkClient
Utilize SDK Client

```yaml
Type: SwitchParameter
Parameter Sets: clientSdk
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ConfigPath
Config path for the key/config files

```yaml
Type: String
Parameter Sets: clientSdk
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PlatformUrl
URL of the Delinea Platform tenant, for example https://mytenant.delinea.app.
Only https is accepted.

```yaml
Type: Uri
Parameter Sets: platformToken, platform
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VaultId
Vault id to use from the Platform vault broker.
The vault must be active.

```yaml
Type: String
Parameter Sets: platformToken, platform
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowedVaultHost
Additional vault hosts to trust, as host or host:port (a host alone covers port 443 only).
Needed when the vault is not a Secret Server Cloud host, for example an on-premises Secret Server connected to the Platform.

```yaml
Type: String[]
Parameter Sets: platformToken, platform
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AutoRefresh
Keep the Platform service user client secret on the session (as a SecureString) so SessionRefresh() can request a new Platform access token.
Without it nothing is kept and SessionRefresh() returns False for a Platform session.

```yaml
Type: SwitchParameter
Parameter Sets: platform
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipCertificateCheck
Skip TLS certificate validation for the session.
Use only against lab/test Secret Server instances with self-signed certificates; this disables a key TLS protection and should not be used in production.

Available in all parameter sets as of v0.62.0 (RestSharp 112 no longer trusts self-signed certificates by default).

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

### TssSession
## NOTES

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/authentication/New-TssSession](https://thycotic-ps.github.io/thycotic.secretserver/commands/authentication/New-TssSession)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/authentication/New-TssSession.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/authentication/New-TssSession.ps1)