---
title: Set-TssEmailConfiguration
parent: Configurations
grand_parent: Commands
---
# Set-TssEmailConfiguration

## SYNOPSIS
Set the outgoing email configuration

## SYNTAX

```
Set-TssEmailConfiguration [-TssSession] <Session> [-FromEmailAddress <String>] [-FromEmailName <String>]
 [-SendEmailAppRegistrationSecretId <Int32>] [-SendEmailMethod <String>] [-SmtpCheckCertificateRevocation]
 [-SmtpDomain <String>] [-SmtpPassword <SecureString>] [-SmtpPort <Int32>] [-SmtpServer <String>]
 [-SmtpUseCredentials] [-SmtpUseImplicitSSL] [-SmtpUserName <String>] [-SmtpUseSSL]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Set how Secret Server sends email: SMTP server, port, SSL mode and credentials, or an Office 365 app registration.
Only the parameters you pass are sent; everything else keeps its current value.
Returns the full email configuration after the update.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssEmailConfiguration -TssSession $session -SmtpServer smtp.example.com -SmtpPort 587 -SmtpUseSSL -FromEmailAddress secretserver@example.com
```

Send email through smtp.example.com on port 587 over SSL

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$smtpCred = Get-Credential
Set-TssEmailConfiguration -TssSession $session -SmtpUseCredentials -SmtpUserName $smtpCred.UserName -SmtpPassword $smtpCred.Password
```

Authenticate to the SMTP server with the supplied account

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

### -FromEmailAddress
Address every outgoing email is sent from

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

### -FromEmailName
Display name on outgoing email

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

### -SendEmailAppRegistrationSecretId
Id of the secret holding the Azure app registration used when SendEmailMethod is O365

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

### -SendEmailMethod
How email is sent: Smtp or O365

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

### -SmtpCheckCertificateRevocation
Check certificate revocation when using implicit SSL

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

### -SmtpDomain
Domain of the SMTP account

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

### -SmtpPassword
Password of the SMTP account

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

### -SmtpPort
SMTP port, 25 by default

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

### -SmtpServer
Host name of the outgoing SMTP server

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

### -SmtpUseCredentials
Authenticate to the SMTP server; pass -SmtpUseCredentials:$false for anonymous SMTP

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

### -SmtpUseImplicitSSL
Use implicit SSL (SMTPS) instead of STARTTLS

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

### -SmtpUserName
User name of the SMTP account

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

### -SmtpUseSSL
Connect to the SMTP server over SSL

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

### Thycotic.PowerShell.Configuration.EmailConfiguration
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssEmailConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssEmailConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssEmailConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssEmailConfiguration.ps1)
