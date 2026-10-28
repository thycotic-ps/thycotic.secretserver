---
title: New-TssAdvancedConfigurationSetting
parent: Advanced Config Settings
grand_parent: Commands
---
# New-TssAdvancedConfigurationSetting

## SYNOPSIS
Create an advanced configuration setting value

## SYNTAX

```
New-TssAdvancedConfigurationSetting [-TssSession] <Session> -AdvancedSettingId <Int32> -Value <String> [-Force]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a value for an advanced configuration setting, identified by its setting id.
Advanced configuration settings are server-wide tuning options meant to be changed under Delinea support direction.
Use Search-TssAdvancedConfigurationSetting to find setting ids and current values.
Secret Server returns no setting from this request, so nothing is output; read the stored value back with Search-TssAdvancedConfigurationSetting.
Listing the settings stores a value for every setting that has none, and this request changes nothing (and reports no error) for a setting that already has a value: change an existing value with Update-TssAdvancedConfigurationSetting.
Advanced configuration settings are only to be updated by Delinea Support: modifying them will have a major impact on Secret Server.
The command writes that warning and asks OK to proceed?
before it sends the request.
-Force skips the question, and the confirmation prompt unless -Confirm is passed, for unattended runs; -WhatIf shows the request without sending it.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssAdvancedConfigurationSetting -TssSession $session -AdvancedSettingId 12 -Value '30'
```

Store the value 30 for advanced configuration setting 12

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
Value to store for the setting

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

### -Force
Skip the OK to proceed?
question, and the confirmation prompt unless -Confirm is passed.
The warning is still written.

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

## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/advanced-config-settings/New-TssAdvancedConfigurationSetting](https://thycotic-ps.github.io/thycotic.secretserver/commands/advanced-config-settings/New-TssAdvancedConfigurationSetting)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/advanced-config-settings/New-TssAdvancedConfigurationSetting.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/advanced-config-settings/New-TssAdvancedConfigurationSetting.ps1)
