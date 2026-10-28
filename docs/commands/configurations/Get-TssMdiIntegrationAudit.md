---
title: Get-TssMdiIntegrationAudit
parent: Configurations
grand_parent: Commands
---
# Get-TssMdiIntegrationAudit

## SYNOPSIS
Get the audit of the MDI integration configuration

## SYNTAX

```
Get-TssMdiIntegrationAudit [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get the audit records of changes to the Microsoft Defender for Identity (MDI) integration configuration.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssMdiIntegrationAudit -TssSession $session
```

List the MDI integration configuration audit

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

### Thycotic.PowerShell.Configuration.Audit[]
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server Cloud only: an on-premises Secret Server answers this endpoint with Access denied.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssMdiIntegrationAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssMdiIntegrationAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssMdiIntegrationAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssMdiIntegrationAudit.ps1)
