---
title: Get-TssHealthCheck
parent: Healthcheck
grand_parent: Commands
---
# Get-TssHealthCheck

## SYNOPSIS
Get the health check of Secret Server

## SYNTAX

```
Get-TssHealthCheck [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get whether Secret Server and its database are healthy, whether it runs in read-only mode and, on Secret Server Cloud, the state of the service bus and storage accounts.
Values that do not apply to the instance are empty.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssHealthCheck -TssSession $session).Healthy
```

Show whether Secret Server reports itself healthy

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

### Thycotic.PowerShell.HealthCheck.Status
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/healthcheck/Get-TssHealthCheck](https://thycotic-ps.github.io/thycotic.secretserver/commands/healthcheck/Get-TssHealthCheck)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/healthcheck/Get-TssHealthCheck.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/healthcheck/Get-TssHealthCheck.ps1)
