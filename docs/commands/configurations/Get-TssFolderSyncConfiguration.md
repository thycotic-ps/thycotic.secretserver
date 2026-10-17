---
title: Get-TssFolderSyncConfiguration
parent: Configurations
grand_parent: Commands
---
# Get-TssFolderSyncConfiguration

## SYNOPSIS
Get the folder synchronization configuration

## SYNTAX

```
Get-TssFolderSyncConfiguration [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Get how Secret Server synchronizes folders from ConnectWise: the method, the interval, the folder to synchronize, the connection settings and how long operational logs are kept.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssFolderSyncConfiguration -TssSession $session
```

Show the folder synchronization configuration

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

### Thycotic.PowerShell.Configuration.FolderSyncConfiguration
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssFolderSyncConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssFolderSyncConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssFolderSyncConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssFolderSyncConfiguration.ps1)
