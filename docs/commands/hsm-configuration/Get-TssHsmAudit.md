---
title: Get-TssHsmAudit
parent: Hsm Configuration
grand_parent: Commands
---
# Get-TssHsmAudit

## SYNOPSIS
Get the HSM configuration audit trail

## SYNTAX

```
Get-TssHsmAudit [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Gets the audit records of Hardware Security Module (HSM) configuration changes: who changed the HSM settings, what was done and when.
Requires the View HSM or Administer HSM role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssHsmAudit -TssSession $session
```

Get the HSM configuration audit trail

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

### Thycotic.PowerShell.HsmConfiguration.HsmAudit[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/hsm-configuration/Get-TssHsmAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/hsm-configuration/Get-TssHsmAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/hsm-configuration/Get-TssHsmAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/hsm-configuration/Get-TssHsmAudit.ps1)
