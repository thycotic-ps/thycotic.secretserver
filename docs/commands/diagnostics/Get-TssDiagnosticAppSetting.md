---
title: Get-TssDiagnosticAppSetting
parent: Diagnostics
grand_parent: Commands
---
# Get-TssDiagnosticAppSetting

## SYNOPSIS
Get the Secret Server application settings

## SYNTAX

### Default (Default)
```
Get-TssDiagnosticAppSetting [-TssSession] <Session> [<CommonParameters>]
```

### Legacy
```
Get-TssDiagnosticAppSetting [-TssSession] <Session> [-Legacy]
 [<CommonParameters>]
```

## DESCRIPTION
Gets the application settings (the appSettings section of web.config) as Key and Value pairs, the same list shown under Admin, Diagnostics.
Uses the version 2 endpoint.
Use -Legacy to read the version 1 endpoint, which returns the same settings as one object; each property becomes a Key and Value pair.
Requires the Administer Configuration or View Configuration permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiagnosticAppSetting -TssSession $session
```

Get the application settings

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiagnosticAppSetting -TssSession $session | Where-Object Key -Like 'webLauncher*'
```

Get the web launcher settings

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

### -Legacy
Read the settings from the version 1 endpoint (GET api/v1/diagnostics/app-settings), for Secret Server versions without the version 2 endpoint

```yaml
Type: SwitchParameter
Parameter Sets: Legacy
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Diagnostics.AppSetting[]
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Get-TssDiagnosticAppSetting](https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Get-TssDiagnosticAppSetting)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Get-TssDiagnosticAppSetting.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Get-TssDiagnosticAppSetting.ps1)
