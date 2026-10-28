---
title: Search-TssDashboardToolboxWidget
parent: Dashboard Services
grand_parent: Commands
---
# Search-TssDashboardToolboxWidget

## SYNOPSIS
List the widgets that can be added to a dashboard tab

## SYNTAX

```
Search-TssDashboardToolboxWidget [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the toolbox widgets for the dashboard tab with the given id: the widget types not yet placed on the tab.
Id is the widget type id; TabWidgetId is 0 because the widget is not on the tab.
The list is not paged.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDashboardToolboxWidget -TssSession $session -Id 1
```

List the widgets that can still be added to dashboard tab 1

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
Dashboard tab id.

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: TabId

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

### Thycotic.PowerShell.DashboardServices.DashboardWidget[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Search-TssDashboardToolboxWidget](https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Search-TssDashboardToolboxWidget)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Search-TssDashboardToolboxWidget.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Search-TssDashboardToolboxWidget.ps1)
