# Update-TssDistributedEngine

## SYNOPSIS
Update a Distributed Engine

## SYNTAX

```
Update-TssDistributedEngine [-TssSession] <Session> -EngineId <Int32[]> -SiteId <Int32>
 -Status <EngineStatusType> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Update a Distributed Engine

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssDistributedEngine -TssSession $session -Id 24 -SiteId 6 -Status Activate
```

Activate Engine 24 on Site 6

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssDistributedEngine -TssSession $session -Id 12,56,34,23 -SiteId 2 -Status RemoveFromSite
```

Remove the Engines provided from Site 2

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
Parameter Sets: (All)
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SiteId
Site ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Status
Change Engine Status (allowed: Activate, Deactivate, Delete, RemoveFromSite)

```yaml
Type: EngineStatusType
Parameter Sets: (All)
Aliases:
Accepted values: Activate, Deactivate, RemoveFromSite, Delete

Required: True
Position: Named
Default value: None
Accept pipeline input: False
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

### Thycotic.PowerShell.DistributedEngines.EngineActivation
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Update-TssDistributedEngine](https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Update-TssDistributedEngine)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Update-TssDistributedEngine.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Update-TssDistributedEngine.ps1)

