---
title: Get-TssDatabaseConfiguration
parent: Configurations
grand_parent: Commands
---
# Get-TssDatabaseConfiguration

## SYNOPSIS
Get the database configuration

## SYNTAX

```
Get-TssDatabaseConfiguration [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the SQL Server connection settings Secret Server uses: server, database, authentication type and login name, encryption, failover and timeout, plus the configuration file path and application pool identity.
No password is returned.
The database configuration is set per web node: the result comes from the node that answered the request, which behind a load-balanced address can be any node.
Point the session directly at a node to read that node's configuration.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDatabaseConfiguration -TssSession $session
```

Get the database configuration

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

### Thycotic.PowerShell.Configuration.DatabaseConfiguration
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssDatabaseConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssDatabaseConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssDatabaseConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssDatabaseConfiguration.ps1)
