---
title: Search-TssDashboardTab
parent: Dashboard Services
grand_parent: Commands
---
# Search-TssDashboardTab

## SYNOPSIS
List the dashboard tabs of the current user

## SYNTAX

```
Search-TssDashboardTab [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns every dashboard tab of the current user with its id, name, type and hash parameters.
The list is not paged.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDashboardTab -TssSession $session
```

List the dashboard tabs of the current user

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

### Thycotic.PowerShell.DashboardServices.DashboardTab[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Search-TssDashboardTab](https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Search-TssDashboardTab)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Search-TssDashboardTab.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Search-TssDashboardTab.ps1)
