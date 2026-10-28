---
title: Export-TssBundle
parent: Bundle
grand_parent: Commands
---
# Export-TssBundle

## SYNOPSIS
Export a discovery bundle

## SYNTAX

```
Export-TssBundle [-TssSession] <Session> [-DiscoverySourceId <Int32>] [-PasswordTypeId <Int32[]>]
 [<CommonParameters>]
```

## DESCRIPTION
Exports the configuration bundle of a discovery source: the discovery source, its scanners, scan templates and discovery command sets, plus the password changers, scripts and secret templates of the given password types.
The bundle is returned as JSON text in ExportedSecretSettingsFileText, with its FileName and FileType.
Pipe that text to ConvertFrom-Json to read the bundle as an object.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Export-TssBundle -TssSession $session -DiscoverySourceId 3 -PasswordTypeId 1, 2
```

Exports the bundle of discovery source 3 with password types 1 and 2

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Export-TssBundle -TssSession $session -DiscoverySourceId 3).ExportedSecretSettingsFileText | Set-Content -Path ./bundle.json
```

Exports the bundle of discovery source 3 and saves it as bundle.json

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

### -DiscoverySourceId
Discovery source ID to export

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

### -PasswordTypeId
Password type (password changer) IDs to include

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: PasswordTypeIds

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

### Thycotic.PowerShell.Bundle.Settings
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/bundle/Export-TssBundle](https://thycotic-ps.github.io/thycotic.secretserver/commands/bundle/Export-TssBundle)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bundle/Export-TssBundle.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bundle/Export-TssBundle.ps1)
