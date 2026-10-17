---
title: Search-TssAdvancedConfigurationSetting
parent: Advanced Config Settings
grand_parent: Commands
---
# Search-TssAdvancedConfigurationSetting

## SYNOPSIS
Search advanced configuration settings

## SYNTAX

```
Search-TssAdvancedConfigurationSetting [-TssSession] <Session> [-IsCloud] [-SearchText <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the advanced configuration settings with their setting id, name, type and current value.
Advanced configuration settings are server-wide tuning options meant to be changed under Delinea support direction.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssAdvancedConfigurationSetting -TssSession $session
```

List every advanced configuration setting

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssAdvancedConfigurationSetting -TssSession $session -SearchText 'Timeout'
```

List the advanced configuration settings whose name contains Timeout

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

### -IsCloud
Return only settings that apply to Secret Server Cloud

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

### -SearchText
Text to match against the setting name

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.AdvancedConfigSettings.Summary[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/advanced-config-settings/Search-TssAdvancedConfigurationSetting](https://thycotic-ps.github.io/thycotic.secretserver/commands/advanced-config-settings/Search-TssAdvancedConfigurationSetting)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/advanced-config-settings/Search-TssAdvancedConfigurationSetting.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/advanced-config-settings/Search-TssAdvancedConfigurationSetting.ps1)
