---
title: Get-TssDashboardTabWidgetState
parent: Dashboard Services
grand_parent: Commands
---
# Get-TssDashboardTabWidgetState

## SYNOPSIS
Get the saved state of a dashboard widget

## SYNTAX

```
Get-TssDashboardTabWidgetState [-TssSession] <Session> -TabWidgetId <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the state string the web UI saved for a widget on a dashboard tab, usually serialized JSON such as a filter or page size.
Returns nothing when no state was saved.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDashboardTabWidgetState -TssSession $session -TabWidgetId 3
```

Get the saved state of the widget with tab widget id 3

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDashboardTabWidget -TssSession $session -Id 1 | Get-TssDashboardTabWidgetState -TssSession $session
```

Get the saved state of every widget on dashboard tab 1

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
Type: Int32[]
Parameter Sets: (All)
Aliases:

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

### System.String
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Get-TssDashboardTabWidgetState](https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Get-TssDashboardTabWidgetState)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Get-TssDashboardTabWidgetState.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Get-TssDashboardTabWidgetState.ps1)
