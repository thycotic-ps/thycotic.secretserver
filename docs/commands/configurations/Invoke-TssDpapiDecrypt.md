---
title: Invoke-TssDpapiDecrypt
parent: Configurations
grand_parent: Commands
---
# Invoke-TssDpapiDecrypt

## SYNOPSIS
Turn off DPAPI protection of the encryption key file

## SYNTAX

```
Invoke-TssDpapiDecrypt [-TssSession] <Session> -Password <SecureString>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Stops protecting the Secret Server encryption key file (encryption.config) with Windows DPAPI and returns the resulting encryption state.
This changes how the master encryption key is stored on the web server; it does not decrypt secrets or other data.
The current user re-enters their own login password to confirm.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Invoke-TssDpapiDecrypt -TssSession $session -Password (Read-Host -AsSecureString)
```

Turn off DPAPI protection of the encryption key file

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
Login password of the current user, to confirm the change

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

Secret Server on-premises only (Secret Server Cloud denies the request).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Invoke-TssDpapiDecrypt](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Invoke-TssDpapiDecrypt)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Invoke-TssDpapiDecrypt.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Invoke-TssDpapiDecrypt.ps1)
