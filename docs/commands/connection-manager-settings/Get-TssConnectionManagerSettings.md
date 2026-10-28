---
title: Get-TssConnectionManagerSettings
parent: Connection Manager Settings
grand_parent: Commands
---
# Get-TssConnectionManagerSettings

## SYNOPSIS
Get the Connection Manager client settings

## SYNTAX

```
Get-TssConnectionManagerSettings [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Get the settings Secret Server hands to the Connection Manager desktop client: whether local connections and saved credentials are allowed, the license state and the client download URL.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssConnectionManagerSettings -TssSession $session
```

Get the Connection Manager client settings

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

### Thycotic.PowerShell.ConnectionManager.Settings
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/connection-manager-settings/Get-TssConnectionManagerSettings](https://thycotic-ps.github.io/thycotic.secretserver/commands/connection-manager-settings/Get-TssConnectionManagerSettings)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/connection-manager-settings/Get-TssConnectionManagerSettings.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/connection-manager-settings/Get-TssConnectionManagerSettings.ps1)
