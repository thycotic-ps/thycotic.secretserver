---
title: Import-TssServerSettings
parent: Secret Server Settings
grand_parent: Commands
---
# Import-TssServerSettings

## SYNOPSIS
Import Secret Server settings

## SYNTAX

### v3 (Default)
```
Import-TssServerSettings [-TssSession] <Session> -Data <Object> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### v1
```
Import-TssServerSettings [-TssSession] <Session> -Data <Object> [-Legacy]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Applies settings sections to Secret Server and returns the applied settings with errors and warnings per section.
-Data is keyed by section (advancedSettings, applicationSettings, email, configurationEmailMessageHeaders, folderSettings, launcherSettings, licenses, localUserPasswords, login, permissionOptions, protocolHandlerSettings, saml, security, sessionRecording, sshCommands, ticketSystem, userExperience, userInterface).
Each section uses the PATCH shape of its configuration endpoint: a field is set with @{ dirty = $true; value = \<value\> }.
Only the sections present in -Data are imported.
-Legacy uses the version 1 endpoint.
Requires the Advanced Import and Administer Configuration role permissions.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$data = @{ applicationSettings = @{ maxSecretLogLength = @{ dirty = $true; value = 5000 } } }
Import-TssServerSettings -TssSession $session -Data $data
```

Imports one application setting

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$data = @{ login = @{ maximumLoginFailures = @{ dirty = $true; value = 5 } } }
Import-TssServerSettings -TssSession $session -Data $data -Legacy -WhatIf
```

Shows the version 1 import request for one login setting without sending it

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

### -Data
Settings to import, keyed by section (hashtable or object)

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Legacy
Use the version 1 import endpoint

```yaml
Type: SwitchParameter
Parameter Sets: v1
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

### Thycotic.PowerShell.SecretServerSettings.ImportResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-server-settings/Import-TssServerSettings](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-server-settings/Import-TssServerSettings)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-server-settings/Import-TssServerSettings.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-server-settings/Import-TssServerSettings.ps1)
