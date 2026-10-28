---
title: Get-TssDashboardTab
parent: Dashboard Services
grand_parent: Commands
---
# Get-TssDashboardTab

## SYNOPSIS
Get a dashboard tab and its widgets

## SYNTAX

```
Get-TssDashboardTab [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the dashboard tab with the given id and the widgets placed on it.
The tab must belong to the current user.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDashboardTab -TssSession $session -Id 1
```

Get dashboard tab 1 and its widgets

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDashboardTab -TssSession $session | Get-TssDashboardTab -TssSession $session
```

Get every dashboard tab of the current user with its widgets

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

### Thycotic.PowerShell.DashboardServices.DashboardTabInfo
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Get-TssDashboardTab](https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Get-TssDashboardTab)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Get-TssDashboardTab.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Get-TssDashboardTab.ps1)
