---
title: Get-TssDashboardLastSelectedTab
parent: Dashboard Services
grand_parent: Commands
---
# Get-TssDashboardLastSelectedTab

## SYNOPSIS
Get the dashboard tab the current user selected last

## SYNTAX

```
Get-TssDashboardLastSelectedTab [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the dashboard tab the current user selected last, which is the tab the dashboard opens on.
When no tab was saved, or the saved tab no longer exists, the server returns the system tab.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDashboardLastSelectedTab -TssSession $session
```

Get the dashboard tab the current user selected last

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDashboardLastSelectedTab -TssSession $session | Search-TssDashboardTabWidget -TssSession $session
```

List the widgets on the tab the dashboard opens on

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.DashboardServices.DashboardTab
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Get-TssDashboardLastSelectedTab](https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Get-TssDashboardLastSelectedTab)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Get-TssDashboardLastSelectedTab.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Get-TssDashboardLastSelectedTab.ps1)
