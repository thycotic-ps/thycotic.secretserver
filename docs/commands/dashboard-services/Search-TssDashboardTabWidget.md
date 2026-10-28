---
title: Search-TssDashboardTabWidget
parent: Dashboard Services
grand_parent: Commands
---
# Search-TssDashboardTabWidget

## SYNOPSIS
List the widgets on a dashboard tab

## SYNTAX

```
Search-TssDashboardTabWidget [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the widgets placed on the dashboard tab with the given id, with their position and saved state.
TabWidgetId identifies the widget on the tab and is the id the widget state cmdlets take.
Id is always 0 here: the server does not return the widget type id for a placed widget; ControlName names the widget type.
The list is not paged.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDashboardTabWidget -TssSession $session -Id 1
```

List the widgets on dashboard tab 1

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDashboardTab -TssSession $session | Search-TssDashboardTabWidget -TssSession $session
```

List the widgets on every dashboard tab of the current user

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Search-TssDashboardTabWidget](https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Search-TssDashboardTabWidget)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Search-TssDashboardTabWidget.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Search-TssDashboardTabWidget.ps1)
