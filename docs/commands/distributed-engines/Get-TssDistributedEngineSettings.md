---
title: Get-TssDistributedEngineSettings
parent: Distributed Engines
grand_parent: Commands
---
# Get-TssDistributedEngineSettings

## SYNOPSIS
Get the feature settings of a Distributed Engine or the default settings of a site

## SYNTAX

### Engine (Default)
```
Get-TssDistributedEngineSettings [-TssSession] <Session> -EngineId <Int32[]>
 [<CommonParameters>]
```

### Site
```
Get-TssDistributedEngineSettings [-TssSession] <Session> -SiteId <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Gets the engine settings that control which kinds of work a Distributed Engine processes (directory sync, password changing, discovery, proxies, workflow and more) and its log level.
With -EngineId returns the settings of each engine. Reading an engine that has no settings of its own saves a copy of its site's default settings as that engine's settings and returns them with the new EngineSettingsId.
An ID that matches no engine returns the built-in defaults with EngineSettingsId 0 and saves nothing.
With -SiteId returns the default settings applied to engines on each site. Reading a site that has no default settings saves the built-in defaults for that site.
Each feature property has Enabled, Display and CanEdit.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDistributedEngineSettings -TssSession $session -EngineId 7
```

Gets the settings of Distributed Engine 7

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDistributedEngineSettings -TssSession $session -SiteId 1 | Select-Object EngineSettingsId, @{n='SshProxy';e={$_.SshProxyEnabled.Enabled}}
```

Gets the default engine settings of site 1 and shows whether SSH proxy work is enabled

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

### -EngineId
Distributed Engine ID

```yaml
Type: Int32[]
Parameter Sets: Engine
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SiteId
Site ID, for the default settings of the engines on that site

```yaml
Type: Int32[]
Parameter Sets: Site
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

### Thycotic.PowerShell.DistributedEngines.EngineSettings
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Get-TssDistributedEngineSettings](https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Get-TssDistributedEngineSettings)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Get-TssDistributedEngineSettings.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Get-TssDistributedEngineSettings.ps1)
