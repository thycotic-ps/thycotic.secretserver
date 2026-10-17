---
title: Get-TssPbaConfiguration
parent: Pba Configuration
grand_parent: Commands
---
# Get-TssPbaConfiguration

## SYNOPSIS
Get the Privilege Behavior Analytics (PBA) configuration

## SYNTAX

```
Get-TssPbaConfiguration [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the PBA integration settings: enabled state, PBA URL, upload and metadata intervals, retention, challenge options and key pair status.
PbaKey and SecretServerKey are key pair ids, not key material.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPbaConfiguration -TssSession $session
```

Returns the PBA configuration

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

### Thycotic.PowerShell.PbaConfiguration.Configuration
## NOTES
Requires TssSession object returned by New-TssSession

Requires the View or Administer Security Analytics permission and a Privilege Behavior Analytics license; otherwise the server returns 403.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/pba-configuration/Get-TssPbaConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/pba-configuration/Get-TssPbaConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/pba-configuration/Get-TssPbaConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/pba-configuration/Get-TssPbaConfiguration.ps1)
