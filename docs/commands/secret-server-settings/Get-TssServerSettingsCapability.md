---
title: Get-TssServerSettingsCapability
parent: Secret Server Settings
grand_parent: Commands
---
# Get-TssServerSettingsCapability

## SYNOPSIS
Get which Secret Server settings sections can be exported or imported

## SYNTAX

### export (Default)
```
Get-TssServerSettingsCapability [-TssSession] <Session>
 [<CommonParameters>]
```

### path
```
Get-TssServerSettingsCapability [-TssSession] <Session> -Path <String>
 [<CommonParameters>]
```

### text
```
Get-TssServerSettingsCapability [-TssSession] <Session> -FileText <String>
 [<CommonParameters>]
```

## DESCRIPTION
Without a settings file, returns the settings sections the current user can export.
With a settings file from Export-TssServerSettings (-Path or -FileText), returns the sections in that file and whether each can be imported.
Each section is a field descriptor: value holds the section content from the file, readOnly and readOnlyReason say why a section is unavailable.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssServerSettingsCapability -TssSession $session
```

Returns the settings sections the current user can export

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssServerSettingsCapability -TssSession $session -Path ./ss-settings.json
```

Returns the sections in ss-settings.json and whether each can be imported

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$export = Export-TssServerSettings -TssSession $session -Section TicketSystem -Password (Read-Host -AsSecureString)
Get-TssServerSettingsCapability -TssSession $session -FileText $export.ExportedSecretSettingsFileText
```

Checks which sections of a fresh export can be imported

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

### -Path
Path of a settings file saved from the ExportedSecretSettingsFileText of Export-TssServerSettings

```yaml
Type: String
Parameter Sets: path
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FileText
Settings file text, the ExportedSecretSettingsFileText of Export-TssServerSettings

```yaml
Type: String
Parameter Sets: text
Aliases: ExportedSecretSettingsFileText

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.SecretServerSettings.Capability
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-server-settings/Get-TssServerSettingsCapability](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-server-settings/Get-TssServerSettingsCapability)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-server-settings/Get-TssServerSettingsCapability.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-server-settings/Get-TssServerSettingsCapability.ps1)
