---
category: general
external help file: Thycotic.SecretServer-help.xml
Module Name: Thycotic.SecretServer
online version: https://thycotic-ps.github.io/thycotic.secretserver/commands/New-TssSession
schema: 2.0.0
title: New-TssSession
---

# New-TssSession

## SYNOPSIS
Create new session

## SYNTAX

### winauth
```
New-TssSession [-SecretServer] <Uri> [-UseWindowsAuth] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### sdk
```
New-TssSession [-SecretServer] <Uri> -AccessToken <Object> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### new
```
New-TssSession [-SecretServer] <Uri> -Credential <PSCredential> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create a new TssSession for working with a Secret Server

## EXAMPLES

### EXAMPLE 1
```
$cred = [PSCredential]::new('apiuser',(ConvertTo-SecureString -String "Fancy%$#Passwod" -AsPlainText -Force))
New-TssSession -SecretServer https://ssvault.com/SecretServer -Credential $cred
```

A PSCredential is created for the apiuser account.
The internal TssSession is updated upon successful authentication, and then output to the console.

### EXAMPLE 2
```
$token = .\tss.exe -kd c:\secretserver\module_testing\ -cd c:\secretserver\module_testing
$tssSession = New-TssSession -SecretServer https://ssvault.com/SecretServer -AccessToken $token
```

A token is requested via Client SDK (after proper init has been done)
TssSession object is created with minimum properties required by the module.
Note that this use case, SessionRefresh and SessionExpire are not supported

### EXAMPLE 3
```
New-TssSession -SecretServer https://ssvault.com/SecretServer -Credential (Get-Credential apiuser)
```

A prompt to enter the password for the apiuser is given by PowerShell.
Upon successful authentication the response from the oauth2/token endpoint is output to the console.

### EXAMPLE 4
```
$secretCred = [pscredential]::new('ssadmin',(ConvertTo-SecureString -String 'F@#R*(@#$SFSDF1234' -AsPlainText -Force)))
$session = nts https://ssvault.com/SecretServer $secretCred
```

Create a credential object
Use the alias nts to create a session object

### EXAMPLE 5
```
$session = nts https://ssvault.com/SecretServer -UseWindowsAuth
```

Create a session object utilizing Windows Integrated Authentication (IWA)
Use the alias nts to create a session object

## PARAMETERS

### -SecretServer
Secret Server URL

```yaml
Type: Uri
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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
Position: Named
Default value: None
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

### TssSession.
## NOTES

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/New-TssSession](https://thycotic-ps.github.io/thycotic.secretserver/commands/New-TssSession)

