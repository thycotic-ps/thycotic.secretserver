---
title: Search-TssDistributedEngineSiteLog
parent: Distributed Engines
grand_parent: Commands
---
# Search-TssDistributedEngineSiteLog

## SYNOPSIS
Search the logs of a Distributed Engine site

## SYNTAX

```
Search-TssDistributedEngineSiteLog [-TssSession] <Session> -Id <Int32[]> [-EngineId <Int32>]
 [-SearchTerm <String>] [<CommonParameters>]
```

## DESCRIPTION
Searches the log entries of a site, newest first: date, engine name and message.
Filter by engine with -EngineId and by text with -SearchTerm.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDistributedEngineSiteLog -TssSession $session -Id 3 -SearchTerm error
```

Gets the log entries of site 3 that mention error

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
Site ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SiteId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -EngineId
Only logs of this engine

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SearchTerm
Text to match in the engine name or the message

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.DistributedEngines.SiteLog[]
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Search-TssDistributedEngineSiteLog](https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Search-TssDistributedEngineSiteLog)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Search-TssDistributedEngineSiteLog.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Search-TssDistributedEngineSiteLog.ps1)
