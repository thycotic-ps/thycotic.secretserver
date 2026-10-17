---
title: Get-TssServerNodeAudit
parent: Server Nodes
grand_parent: Commands
---
# Get-TssServerNodeAudit

## SYNOPSIS
Get the server node audit history

## SYNTAX

```
Get-TssServerNodeAudit [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Gets the audit records of server node changes, such as nodes being created, joining or leaving the cluster and role changes.
Returns every record; the endpoint is not paged.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssServerNodeAudit -TssSession $session | Sort-Object Date -Descending | Select-Object -First 10
```

Gets the ten most recent server node audit records

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

### Thycotic.PowerShell.ServerNodes.Audit[]
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/server-nodes/Get-TssServerNodeAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/server-nodes/Get-TssServerNodeAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/server-nodes/Get-TssServerNodeAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/server-nodes/Get-TssServerNodeAudit.ps1)
