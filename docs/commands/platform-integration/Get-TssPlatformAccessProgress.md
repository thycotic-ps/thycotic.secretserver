---
title: Get-TssPlatformAccessProgress
parent: Platform Integration
grand_parent: Commands
---
# Get-TssPlatformAccessProgress

## SYNOPSIS
Get the progress of the secure Platform access step of Delinea Platform data integration

## SYNTAX

```
Get-TssPlatformAccessProgress [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the state of each check in the secure Platform access step: identity policy, deny policy, policy order and policy group membership.
Each property is one of NotStarted, Started, CompletedSuccessfully, CompletedInvalid or Skipped.
Requires Delinea Platform integration on the Secret Server instance; without it the server returns an error (API_PlatformNotEnabled).

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPlatformAccessProgress -TssSession $session
```

Returns the state of each secure Platform access check

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$progress = Get-TssPlatformAccessProgress -TssSession $session
$progress.PSObject.Properties | Where-Object Value -eq 'CompletedInvalid'
```

Lists the checks that completed but are not valid

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

### Thycotic.PowerShell.PlatformIntegration.PlatformAccessProgress
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-integration/Get-TssPlatformAccessProgress](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-integration/Get-TssPlatformAccessProgress)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-integration/Get-TssPlatformAccessProgress.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-integration/Get-TssPlatformAccessProgress.ps1)
