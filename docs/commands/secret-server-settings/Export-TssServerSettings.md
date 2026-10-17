---
title: Export-TssServerSettings
parent: Secret Server Settings
grand_parent: Commands
---
# Export-TssServerSettings

## SYNOPSIS
Export Secret Server settings

## SYNTAX

### password (Default)
```
Export-TssServerSettings [-TssSession] <Session> [-Section <String[]>] -Password <SecureString>
 [<CommonParameters>]
```

### doubleLock
```
Export-TssServerSettings [-TssSession] <Session> [-Section <String[]>] -DoubleLockPassword <SecureString>
 [<CommonParameters>]
```

## DESCRIPTION
Exports the chosen settings sections and returns them as an object (SecretServerSettings) and as file text (ExportedSecretSettingsFileText).
Secret Server re-checks the password of the session user (-Password) or the DoubleLock password (-DoubleLockPassword) before exporting.
Requires the Administer Export and Administer Configuration role permissions.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$export = Export-TssServerSettings -TssSession $session -Section Email, Login -Password (Read-Host -AsSecureString)
Set-Content -Path ./ss-settings.json -Value $export.ExportedSecretSettingsFileText
```

Exports the email and login settings and saves the file text

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Export-TssServerSettings -TssSession $session -Password (Read-Host -AsSecureString)
```

Exports every settings section

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

### -Section
Settings sections to export.
Default All

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: All
Accept pipeline input: False
Accept wildcard characters: False
```

### -Password
Password of the session user.
Secret Server checks it before exporting

```yaml
Type: SecureString
Parameter Sets: password
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DoubleLockPassword
DoubleLock password of the session user, used instead of -Password

```yaml
Type: SecureString
Parameter Sets: doubleLock
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.SecretServerSettings.ExportResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-server-settings/Export-TssServerSettings](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-server-settings/Export-TssServerSettings)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-server-settings/Export-TssServerSettings.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-server-settings/Export-TssServerSettings.ps1)
