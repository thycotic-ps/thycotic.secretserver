---
title: Get-TssRpcScanTemplate
parent: Remote Password Changing
grand_parent: Commands
---
# Get-TssRpcScanTemplate

## SYNOPSIS
Get the scan item templates available to password types

## SYNTAX

```
Get-TssRpcScanTemplate [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get the scan item templates a password type can be mapped to, with the fields each template defines and whether each field is required.
A password type's fields are mapped to these fields with Set-TssRpcScanTemplateField.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssRpcScanTemplate -TssSession $session
```

List every scan item template and its fields

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssRpcScanTemplate -TssSession $session | Where-Object ScanItemTemplateId -eq 10).Fields | Where-Object IsRequired
```

List the required fields of scan item template 10

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

### Thycotic.PowerShell.Rpc.ScanTemplate[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Get-TssRpcScanTemplate](https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Get-TssRpcScanTemplate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Get-TssRpcScanTemplate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Get-TssRpcScanTemplate.ps1)
