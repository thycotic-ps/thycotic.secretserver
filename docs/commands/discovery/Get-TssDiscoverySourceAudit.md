---
title: Get-TssDiscoverySourceAudit
parent: Discovery
grand_parent: Commands
---
# Get-TssDiscoverySourceAudit

## SYNOPSIS
Get discovery source audit records

## SYNTAX

```
Get-TssDiscoverySourceAudit [-TssSession] <Session> [-DiscoverySourceId <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
Lists the audit records of discovery sources (create, update, enable, disable), newest first.
Use -DiscoverySourceId to list the records of one source.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoverySourceAudit -TssSession $session
```

List the audit records of all discovery sources

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoverySourceAudit -TssSession $session -DiscoverySourceId 3
```

List the audit records of discovery source 3

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

### -DiscoverySourceId
Only return the audit records of this discovery source

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Discovery.SourceAudit[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoverySourceAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoverySourceAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoverySourceAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoverySourceAudit.ps1)
