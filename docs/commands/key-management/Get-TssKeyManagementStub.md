---
title: Get-TssKeyManagementStub
parent: Key Management
grand_parent: Commands
---
# Get-TssKeyManagementStub

## SYNOPSIS
Get a default Key Management configuration

## SYNTAX

```
Get-TssKeyManagementStub [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Gets the default values for a new Key Management configuration: provider None and every provider setting empty.
Nothing is changed on the server.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssKeyManagementStub -TssSession $session
```

Get the default Key Management configuration values

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

### Thycotic.PowerShell.KeyManagement.KeyManagement
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/key-management/Get-TssKeyManagementStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/key-management/Get-TssKeyManagementStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/key-management/Get-TssKeyManagementStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/key-management/Get-TssKeyManagementStub.ps1)
