# New-TssSession

## SYNOPSIS
Create new session

## SYNTAX

### clientSdk
```
New-TssSession -SecretServer <Uri> [-UseSdkClient] -ConfigPath <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### winauth
```
New-TssSession -SecretServer <Uri> [-UseWindowsAuth] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### sdk
```
New-TssSession -SecretServer <Uri> -AccessToken <Object> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### new
```
New-TssSession -SecretServer <Uri> [-Credential] <PSCredential> [[-OtpCode] <Int32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Create a new TssSession for working with a Secret Server

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

## PARAMETERS

### -SecretServer
Secret Server URL

```yaml
Type: Uri
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Specify a Secret Server user account.

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

### -OtpCode
Provide 2FA code

```yaml
Type: Int32
Parameter Sets: new
Aliases:

Required: False
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -AccessToken
Specify Access Token

```yaml
Type: Object
Parameter Sets: sdk
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

