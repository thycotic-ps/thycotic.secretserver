---
title: Remove-TssAdvancedConfigurationSetting
parent: Advanced Config Settings
grand_parent: Commands
---
# Remove-TssAdvancedConfigurationSetting

## SYNOPSIS
Remove an advanced configuration setting value

## SYNTAX

```
Remove-TssAdvancedConfigurationSetting [-TssSession] <Session> -Id <Int32[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes the stored value of an advanced configuration setting, so the setting goes back to its default.
Advanced configuration settings are server-wide tuning options meant to be changed under Delinea support direction.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssAdvancedConfigurationSetting -TssSession $session -Id 12
```

Remove the stored value of advanced configuration setting 12

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssAdvancedConfigurationSetting -TssSession $session -SearchText 'Timeout' | Remove-TssAdvancedConfigurationSetting -TssSession $session -WhatIf
```

Show which timeout setting values would be removed, without removing them

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

### -Id
Advanced configuration setting id

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: AdvancedSettingId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### Thycotic.PowerShell.Common.Delete
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/advanced-config-settings/Remove-TssAdvancedConfigurationSetting](https://thycotic-ps.github.io/thycotic.secretserver/commands/advanced-config-settings/Remove-TssAdvancedConfigurationSetting)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/advanced-config-settings/Remove-TssAdvancedConfigurationSetting.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/advanced-config-settings/Remove-TssAdvancedConfigurationSetting.ps1)
