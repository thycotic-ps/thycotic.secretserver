---
title: Get-TssPlatformProvisionStatus
parent: Platform
grand_parent: Commands
---
# Get-TssPlatformProvisionStatus

## SYNOPSIS
Get the Platform provisioning status

## SYNTAX

```
Get-TssPlatformProvisionStatus [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Get the status of Delinea Platform provisioning for this Secret Server: when it started and whether Platform integration is enabled.
The status can include a one-time Platform login URL: treat it as a credential.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPlatformProvisionStatus -TssSession $session | Select-Object RequestStartDateTime, OpenIdConnectEnabled
```

Show when provisioning started and whether Platform integration is on

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

### Thycotic.PowerShell.Platform.ProvisionStatus
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server Cloud only: an on-premises Secret Server answers this endpoint with an error.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Get-TssPlatformProvisionStatus](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Get-TssPlatformProvisionStatus)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Get-TssPlatformProvisionStatus.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Get-TssPlatformProvisionStatus.ps1)
