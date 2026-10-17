---
title: Search-TssDistributedEngineAudit
parent: Distributed Engines
grand_parent: Commands
---
# Search-TssDistributedEngineAudit

## SYNOPSIS
Search the audit history of Distributed Engines

## SYNTAX

```
Search-TssDistributedEngineAudit [-TssSession] <Session> [-SiteId <Int32[]>] [-EngineId <Int32>]
 [-SearchTerm <String>] [<CommonParameters>]
```

## DESCRIPTION
Searches the audit records of the Distributed Engines on a site, or on every site when -SiteId is omitted.
Filter by engine with -EngineId and by text with -SearchTerm.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDistributedEngineAudit -TssSession $session -SiteId 3
```

Gets the audit records of every engine on site 3

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDistributedEngineAudit -TssSession $session -EngineId 7 -SearchTerm Activate
```

Searches every site for audit records of engine 7 that mention Activate

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

### -SiteId
Site ID; omit for the engines of every site

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -EngineId
Only audits of this engine

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
Text to match in the audit records

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

### Thycotic.PowerShell.DistributedEngines.EngineAudit[]
## NOTES
Requires TssSession object returned by New-TssSession

A session created with -UseWindowsAuth cannot use this cmdlet: the server publishes the Windows authentication route of this endpoint without the site segment (distributed-engine/{siteId}/engine-audits), so the request fails.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Search-TssDistributedEngineAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Search-TssDistributedEngineAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Search-TssDistributedEngineAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Search-TssDistributedEngineAudit.ps1)
