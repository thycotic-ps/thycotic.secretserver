---
title: Get-TssGeneralLog
parent: Diagnostics
grand_parent: Commands
---
# Get-TssGeneralLog

## SYNOPSIS
Get the general diagnostics log

## SYNTAX

```
Get-TssGeneralLog [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Gets the general log shown under Admin, Diagnostics as one string: comma-separated sections with the server, database, distributed engine, site, license, thread, application, remote password changing and discovery settings, plus recent dependency, backup, engine and site log entries.
Requires the Administer Configuration or View Configuration permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssGeneralLog -TssSession $session
```

Get the general diagnostics log

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssGeneralLog -TssSession $session | Set-Content C:\export\general-log.csv
```

Save the general diagnostics log to a file

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

### System.String
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Get-TssGeneralLog](https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Get-TssGeneralLog)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Get-TssGeneralLog.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Get-TssGeneralLog.ps1)
