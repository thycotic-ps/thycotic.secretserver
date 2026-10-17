---
title: Get-TssDashboardInfo
parent: Dashboard Services
grand_parent: Commands
---
# Get-TssDashboardInfo

## SYNOPSIS
Get the dashboard load information for the current user

## SYNTAX

```
Get-TssDashboardInfo [-TssSession] <Session> [-NoHtmlEncode]
 [<CommonParameters>]
```

## DESCRIPTION
Returns what the web UI loads when the dashboard opens: every dashboard tab of the current user, the tab that opens by default, the widgets on that tab, and dashboard configuration settings such as whether passwords can be unmasked.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDashboardInfo -TssSession $session
```

Get the dashboard tabs, default tab and its widgets for the current user

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssDashboardInfo -TssSession $session -NoHtmlEncode).Tabs
```

List the dashboard tabs with their names as stored, without HTML encoding

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

### -NoHtmlEncode
Return the tab names in Tabs as stored.
By default the server HTML-encodes them.
The server applies this to Tabs only: LastSelectedTab.TabName is always HTML-encoded.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.DashboardServices.DashboardInfo
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Get-TssDashboardInfo](https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Get-TssDashboardInfo)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Get-TssDashboardInfo.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Get-TssDashboardInfo.ps1)
