---
title: Get-TssDistributedEngineSiteAudit
parent: Distributed Engines
grand_parent: Commands
---
# Get-TssDistributedEngineSiteAudit

## SYNOPSIS
Get the audit history of a Distributed Engine site

## SYNTAX

```
Get-TssDistributedEngineSiteAudit [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Gets the audit records of a site, newest first: action, date, notes and user.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDistributedEngineSiteAudit -TssSession $session -Id 3
```

Gets the audit history of site 3

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.DistributedEngines.SiteAudit[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Get-TssDistributedEngineSiteAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Get-TssDistributedEngineSiteAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Get-TssDistributedEngineSiteAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Get-TssDistributedEngineSiteAudit.ps1)
