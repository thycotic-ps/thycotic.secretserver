---
title: Get-TssDistributedEngineSiteConnectorDownload
parent: Distributed Engines
grand_parent: Commands
---
# Get-TssDistributedEngineSiteConnectorDownload

## SYNOPSIS
Download the MemoryMQ site connector installer

## SYNTAX

```
Get-TssDistributedEngineSiteConnectorDownload [-TssSession] <Session> -Id <Int32[]> -Output <String>
 [<CommonParameters>]
```

## DESCRIPTION
Downloads the MemoryMQ site connector service installer, configured for the given site connector, as a zip file into a folder.
Works only for MemoryMQ site connectors; the server rejects RabbitMQ and Azure Service Bus connectors.
Returns the downloaded file.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDistributedEngineSiteConnectorDownload -TssSession $session -Id 1 -Output C:\installers
```

Downloads the installer for site connector 1 into C:\installers

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
Site connector ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SiteConnectorId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Output
Folder to save the zip file in; the file is named Thycotic.MemoryMq.SiteConnector.Service.x64.\<Id\>.zip and an existing file is overwritten

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.IO.FileInfo
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Get-TssDistributedEngineSiteConnectorDownload](https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Get-TssDistributedEngineSiteConnectorDownload)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Get-TssDistributedEngineSiteConnectorDownload.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Get-TssDistributedEngineSiteConnectorDownload.ps1)
