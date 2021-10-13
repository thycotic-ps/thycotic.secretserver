# Test-TssDistributedEngineSiteConnector

## SYNOPSIS
Validate a Site Connector

## SYNTAX

```
Test-TssDistributedEngineSiteConnector [-TssSession] <Session> [-Id] <Int32[]> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Validate a Site Connector

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Test-TssDistributedEngineSiteConnector -TssSession $session -Id 2
```

Validate Site Connector ID 2

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
Site Connector ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SiteConnectorId

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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

### Thycotic.PowerShell.DistributedEngines.Validation
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Test-TssDistributedEngineSiteConnector](https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Test-TssDistributedEngineSiteConnector)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Test-TssDistributedEngineSiteConnector.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Test-TssDistributedEngineSiteConnector.ps1)

