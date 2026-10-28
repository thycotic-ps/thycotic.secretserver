---
title: Get-TssDistributedEngineSiteStub
parent: Distributed Engines
grand_parent: Commands
---
# Get-TssDistributedEngineSiteStub

## SYNOPSIS
Get the default values for a new Distributed Engine site

## SYNTAX

```
Get-TssDistributedEngineSiteStub [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Gets a site populated with the default values a new site starts with, such as the heartbeat interval and the WinRM endpoint.
Use it as a starting point for New-TssDistributedEngineSite.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDistributedEngineSiteStub -TssSession $session
```

Gets the default values for a new site

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

### Thycotic.PowerShell.DistributedEngines.Site
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Get-TssDistributedEngineSiteStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Get-TssDistributedEngineSiteStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Get-TssDistributedEngineSiteStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Get-TssDistributedEngineSiteStub.ps1)
