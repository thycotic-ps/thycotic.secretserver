# Search-TssDistributedEngineConnector

## SYNOPSIS
Search list of Site Connectors for Distributed Engine

## SYNTAX

```
Search-TssDistributedEngineConnector [-TssSession] <Session> [-IncludeInactive] [-SortBy <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Search list of Site Connectors for Distributed Engine

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDistributedEngineConnector -TssSession $session
```

Return list of active Site Connectors

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDistributedEngineConnector -TssSession $session -IncludeInactive
```

Return list of Site Connectors, including those inactive

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

### -IncludeInactive
Include inactive Site Connectors

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SortBy
Sort by specific property, default SiteConnectorId

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: SiteConnectorId
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.DistributedEngines.SiteConnectorSummary
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Search-TssDistributedEngineConnector](https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Search-TssDistributedEngineConnector)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Search-TssDistributedEngineConnector.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Search-TssDistributedEngineConnector.ps1)

