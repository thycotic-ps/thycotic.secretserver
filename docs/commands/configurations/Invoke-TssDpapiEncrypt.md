---
title: Invoke-TssDpapiEncrypt
parent: Configurations
grand_parent: Commands
---
# Invoke-TssDpapiEncrypt

## SYNOPSIS
Encrypt the Secret Server encryption key file with DPAPI

## SYNTAX

```
Invoke-TssDpapiEncrypt [-TssSession] <Session> -Password <SecureString>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Protect the Secret Server encryption key file (encryption.config) with the Windows Data Protection API, the Encrypt action on the DPAPI section of the Security configuration page.
The server re-validates your own password before it changes anything and refuses when the key is protected by an HSM.
DPAPI binds the file to the machine key of the web server: decrypt it before you move the file to another server.
Returns the DPAPI state after the change.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Invoke-TssDpapiEncrypt -TssSession $session -Password (Read-Host -AsSecureString -Prompt 'Your password')
```

Encrypt the encryption key file with DPAPI after prompting for your password

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

### -Password
Your own Secret Server password; the server checks it before it encrypts the file

```yaml
Type: SecureString
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

### Thycotic.PowerShell.Configuration.DpapiState
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only: Secret Server Cloud answers this endpoint with Access denied.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Invoke-TssDpapiEncrypt](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Invoke-TssDpapiEncrypt)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Invoke-TssDpapiEncrypt.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Invoke-TssDpapiEncrypt.ps1)
