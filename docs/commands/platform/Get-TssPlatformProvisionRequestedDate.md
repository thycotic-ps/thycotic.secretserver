---
title: Get-TssPlatformProvisionRequestedDate
parent: Platform
grand_parent: Commands
---
# Get-TssPlatformProvisionRequestedDate

## SYNOPSIS
Get when Platform provisioning was requested

## SYNTAX

```
Get-TssPlatformProvisionRequestedDate [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Get the date and time Delinea Platform provisioning was last requested for this Secret Server.
RequestDateTime is empty when it was never requested.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPlatformProvisionRequestedDate -TssSession $session
```

Show when Platform provisioning was requested

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

### Thycotic.PowerShell.Platform.ProvisionRequestedDate
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Get-TssPlatformProvisionRequestedDate](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Get-TssPlatformProvisionRequestedDate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Get-TssPlatformProvisionRequestedDate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Get-TssPlatformProvisionRequestedDate.ps1)
