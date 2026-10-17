---
title: Get-TssPasswordTypeUsage
parent: Remote Password Changing
grand_parent: Commands
---
# Get-TssPasswordTypeUsage

## SYNOPSIS
Get active-secret usage counts per password type

## SYNTAX

```
Get-TssPasswordTypeUsage [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get the number of active secrets that use each password type.
Only password types used by at least one active secret are returned.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPasswordTypeUsage -TssSession $session | Sort-Object ActiveSecretCount -Descending
```

List the password types in use, most used first

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

### Thycotic.PowerShell.Rpc.PasswordTypeUsage[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Get-TssPasswordTypeUsage](https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Get-TssPasswordTypeUsage)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Get-TssPasswordTypeUsage.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Get-TssPasswordTypeUsage.ps1)
