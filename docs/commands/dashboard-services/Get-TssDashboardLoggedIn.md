---
title: Get-TssDashboardLoggedIn
parent: Dashboard Services
grand_parent: Commands
---
# Get-TssDashboardLoggedIn

## SYNOPSIS
Check whether the session is still logged in

## SYNTAX

```
Get-TssDashboardLoggedIn [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns True when the access token of the session is still accepted as a logged-in user.
The web UI calls the same endpoint to detect a session timeout.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDashboardLoggedIn -TssSession $session
```

Check that the session token is still logged in

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

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Get-TssDashboardLoggedIn](https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Get-TssDashboardLoggedIn)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Get-TssDashboardLoggedIn.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Get-TssDashboardLoggedIn.ps1)
