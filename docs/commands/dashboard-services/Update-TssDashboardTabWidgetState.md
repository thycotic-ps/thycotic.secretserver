---
title: Update-TssDashboardTabWidgetState
parent: Dashboard Services
grand_parent: Commands
---
# Update-TssDashboardTabWidgetState

## SYNOPSIS
Replace the saved state of a dashboard widget

## SYNTAX

### state (Default)
```
Update-TssDashboardTabWidgetState [-TssSession] <Session> -TabWidgetId <Int32> -State <Object>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### clear
```
Update-TssDashboardTabWidgetState [-TssSession] <Session> -TabWidgetId <Int32> [-Clear]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Replaces the state string saved for a widget on a dashboard tab, the value the web UI keeps for settings such as a filter or page size.
The previous state is overwritten, not merged.
Read it first with Get-TssDashboardTabWidgetState to restore it later.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssDashboardTabWidgetState -TssSession $session -TabWidgetId 3 -State @{ pageSize = 25 }
```

Save the state of widget 3 as the JSON text of the hashtable

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$old = Get-TssDashboardTabWidgetState -TssSession $session -TabWidgetId 3
if ($null -eq $old) {
    Update-TssDashboardTabWidgetState -TssSession $session -TabWidgetId 3 -Clear
} else {
    Update-TssDashboardTabWidgetState -TssSession $session -TabWidgetId 3 -State $old
}
```

Restore a widget state read earlier, clearing it when the widget had no saved state

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

### -TabWidgetId
Id of the widget on the tab, the TabWidgetId property of Search-TssDashboardTabWidget output.
Not the widget type id.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -State
New widget state.
A string is saved as is; any other object is saved as compressed JSON.

```yaml
Type: Object
Parameter Sets: state
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Clear
Remove the saved state, so the widget falls back to its defaults.

```yaml
Type: SwitchParameter
Parameter Sets: clear
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

### Thycotic.PowerShell.DashboardServices.DashboardWidgetStateResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Update-TssDashboardTabWidgetState](https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Update-TssDashboardTabWidgetState)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Update-TssDashboardTabWidgetState.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Update-TssDashboardTabWidgetState.ps1)
