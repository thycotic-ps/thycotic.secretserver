---
title: Get-TssSqlReplication
parent: Sql Server Replication
grand_parent: Commands
---
# Get-TssSqlReplication

## SYNOPSIS
Get the SQL Server replication configuration

## SYNTAX

```
Get-TssSqlReplication [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Gets the SQL Server replication settings of this Secret Server: whether replication is enabled and licensed, the replicated databases, the allowed and active database counts, and the publications and articles when replication is configured.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSqlReplication -TssSession $session
```

Get the SQL Server replication configuration

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssSqlReplication -TssSession $session).Publications
```

List the replication publications and their last synchronization status

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

### Thycotic.PowerShell.SqlServerReplication.SqlReplication
## NOTES
Requires TssSession object returned by New-TssSession

On-premises Secret Server only.
Secret Server Cloud returns an access denied error.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/sql-server-replication/Get-TssSqlReplication](https://thycotic-ps.github.io/thycotic.secretserver/commands/sql-server-replication/Get-TssSqlReplication)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sql-server-replication/Get-TssSqlReplication.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sql-server-replication/Get-TssSqlReplication.ps1)
