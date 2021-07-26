# Update-TssSecretRdpLauncherSetting

## SYNOPSIS
Update RDP Launcher Settings of a Secret for the current user.

## SYNTAX

### allows
```
Update-TssSecretRdpLauncherSetting [-TssSession] <Session> -Id <Int32[]> [-ConnectToConsole] [-AllowPrinters]
 [-AllowDrives] [-AllowClipboard] [-AllowSmartCards] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### resolution
```
Update-TssSecretRdpLauncherSetting [-TssSession] <Session> -Id <Int32[]> -LauncherHeight <Int32>
 -LauncherWidth <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Update RDP Launcher Settings of a Secret for the current user.
The context of these settings are user-based only and is not global.

## EXAMPLES

### EXAMPLE 1
```
session = New-TssSession -SecretServer https://alpha -Credential ssCred
Update-TssSecretSetting -TssSession $session -Primary Parameter
```

Update ...

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

### -Id
SecretSetting ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SecretId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ConnectToConsole
Update Connect to Console

```yaml
Type: SwitchParameter
Parameter Sets: allows
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowPrinters
Update Allow Access to Printers

```yaml
Type: SwitchParameter
Parameter Sets: allows
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowDrives
Update Allow Access to Drives

```yaml
Type: SwitchParameter
Parameter Sets: allows
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowClipboard
Update Allow Access to Clipboard

```yaml
Type: SwitchParameter
Parameter Sets: allows
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowSmartCards
Update Allow Access to Smart Cards

```yaml
Type: SwitchParameter
Parameter Sets: allows
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -LauncherHeight
Use Custom Window Size, Window Height

```yaml
Type: Int32
Parameter Sets: resolution
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -LauncherWidth
Use Custom Window Size, Window Width

```yaml
Type: Int32
Parameter Sets: resolution
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Secrets.RdpLauncherSettings
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/Update-TssSecretRdpLauncherSetting](https://thycotic-ps.github.io/thycotic.secretserver/commands/Update-TssSecretRdpLauncherSetting)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Update-TssSecretRdpLauncherSetting.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Update-TssSecretRdpLauncherSetting.ps1)

