---
title: Get-TssReadOnlyMode
parent: Configurations
grand_parent: Commands
---
# Get-TssReadOnlyMode

## SYNOPSIS
Get the Read-Only Mode setting

## SYNTAX

```
Get-TssReadOnlyMode [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns whether Secret Server is in Read-Only Mode.
In Read-Only Mode users can view secrets but Secret Server rejects some changes, such as creating a secret or saving a whole secret (Update-TssSecret). Not every change is blocked: creating a folder still works, and a single field update (Set-TssSecretField) can still save its value, even when it returns a read-only error.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssReadOnlyMode -TssSession $session
```

Returns whether Read-Only Mode is enabled

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

### Thycotic.PowerShell.Configuration.ReadOnlyMode
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssReadOnlyMode](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssReadOnlyMode)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssReadOnlyMode.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssReadOnlyMode.ps1)
