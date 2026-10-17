---
title: Update-TssAdvancedConfigurationSetting
parent: Advanced Config Settings
grand_parent: Commands
---
# Update-TssAdvancedConfigurationSetting

## SYNOPSIS
Update an advanced configuration setting value

## SYNTAX

```
Update-TssAdvancedConfigurationSetting [-TssSession] <Session> -AdvancedSettingId <Int32> -Value <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Replaces the stored value of an advanced configuration setting, identified by its setting id, and returns the updated setting.
Advanced configuration settings are server-wide tuning options meant to be changed under Delinea support direction.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssAdvancedConfigurationSetting -TssSession $session -AdvancedSettingId 12 -Value '60'
```

Change the value of advanced configuration setting 12 to 60

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

### -AdvancedSettingId
Advanced configuration setting id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value
New value for the setting

```yaml
Type: String
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

### Thycotic.PowerShell.AdvancedConfigSettings.Setting
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/advanced-config-settings/Update-TssAdvancedConfigurationSetting](https://thycotic-ps.github.io/thycotic.secretserver/commands/advanced-config-settings/Update-TssAdvancedConfigurationSetting)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/advanced-config-settings/Update-TssAdvancedConfigurationSetting.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/advanced-config-settings/Update-TssAdvancedConfigurationSetting.ps1)
