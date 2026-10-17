---
title: Get-TssDpapiState
parent: Configurations
grand_parent: Commands
---
# Get-TssDpapiState

## SYNOPSIS
Get the DPAPI encryption state

## SYNTAX

```
Get-TssDpapiState [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get whether the Secret Server encryption key file is protected with the Windows Data Protection API or an HSM, and the path of that file on the web server.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDpapiState -TssSession $session
```

Show whether the encryption key file is DPAPI or HSM protected

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

### Thycotic.PowerShell.Configuration.DpapiState
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only: Secret Server Cloud answers this endpoint with Access denied.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssDpapiState](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssDpapiState)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssDpapiState.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssDpapiState.ps1)
