---
title: Get-TssLauncherAgentCollectionAudit
parent: Launcher Agents
grand_parent: Commands
---
# Get-TssLauncherAgentCollectionAudit

## SYNOPSIS
Get launcher agent collection audits

## SYNTAX

### all (Default)
```
Get-TssLauncherAgentCollectionAudit [-TssSession] <Session>
 [<CommonParameters>]
```

### collection
```
Get-TssLauncherAgentCollectionAudit [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Get the audit records of every launcher agent collection, or of one collection with -Id.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssLauncherAgentCollectionAudit -TssSession $session
```

Get the audit records of every launcher agent collection

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssLauncherAgentCollectionAudit -TssSession $session -Id 1
```

Get the audit records of launcher agent collection 1

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
Launcher agent collection Id.
Omit to get the audit records of every collection

```yaml
Type: Int32[]
Parameter Sets: collection
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.LauncherAgents.CollectionAudit[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Get-TssLauncherAgentCollectionAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Get-TssLauncherAgentCollectionAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Get-TssLauncherAgentCollectionAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Get-TssLauncherAgentCollectionAudit.ps1)
