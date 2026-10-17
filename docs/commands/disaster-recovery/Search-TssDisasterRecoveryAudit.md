---
title: Search-TssDisasterRecoveryAudit
parent: Disaster Recovery
grand_parent: Commands
---
# Search-TssDisasterRecoveryAudit

## SYNOPSIS
Search Disaster Recovery configuration audits

## SYNTAX

```
Search-TssDisasterRecoveryAudit [-TssSession] <Session> [-AuditType <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the audit entries for changes to the Disaster Recovery configuration of this Secret Server.
Incoming audits cover this Secret Server as a data replica (incoming configuration); Outgoing audits cover it as a data source (data replicas).
-AuditType defaults to Incoming.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDisasterRecoveryAudit -TssSession $session
```

List the incoming configuration audits

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDisasterRecoveryAudit -TssSession $session -AuditType Outgoing
```

List the data replica audits of this data source

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

### -AuditType
Audit type: Incoming (data replica side) or Outgoing (data source side).
Default Incoming

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Incoming
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Configuration.Audit[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Search-TssDisasterRecoveryAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Search-TssDisasterRecoveryAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Search-TssDisasterRecoveryAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Search-TssDisasterRecoveryAudit.ps1)
