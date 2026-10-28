---
title: Move-TssDistributedEngine
parent: Distributed Engines
grand_parent: Commands
---
# Move-TssDistributedEngine

## SYNOPSIS
Migrate a Distributed Engine to the Delinea Platform engine pool

## SYNTAX

```
Move-TssDistributedEngine [-TssSession] <Session> -Id <Int32> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Starts the migration of a Distributed Engine to the Delinea Platform engine pool.
Works only on a Secret Server connected to the Delinea Platform with an engine that is eligible for migration; otherwise the server rejects the request.
Returns Success and, when the migration did not start, ErrorMessage.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Move-TssDistributedEngine -TssSession $session -Id 7
```

Migrates Distributed Engine 7 to the Platform engine pool after confirmation

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDistributedEngine -TssSession $session -SiteId 3 | Move-TssDistributedEngine -TssSession $session -Confirm:$false
```

Migrates every engine on site 3 without prompting

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
Distributed Engine ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: EngineId

Required: True
Position: Named
Default value: 0
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

### Thycotic.PowerShell.DistributedEngines.EngineMigration
## NOTES
Requires TssSession object returned by New-TssSession

Moves the engine to the Platform engine pool.
This cmdlet has no reverse operation, so it asks for confirmation by default.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Move-TssDistributedEngine](https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Move-TssDistributedEngine)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Move-TssDistributedEngine.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Move-TssDistributedEngine.ps1)
