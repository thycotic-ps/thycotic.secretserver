---
title: Set-TssLauncherSettings
parent: Configurations
grand_parent: Commands
---
# Set-TssLauncherSettings

## SYNOPSIS
Update the launcher settings configuration

## SYNTAX

```
Set-TssLauncherSettings [-TssSession] <Session> [-CheckInSecretOnLastLauncherClose]
 [-CloseLauncherOnCheckInSecret] [-EnableDomainDownload] [-EnableDomainUpload] [-EnableLauncher]
 [-EnableLauncherAutoUpdate] [-EnableWebParsing] [-LauncherDeploymentType <String>] [-SendSecretUrlToLauncher]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Update the launcher settings configuration (launcher on or off, deployment type, auto update, web launcher behavior, check in on close).
Only the parameters you pass are changed.
Returns the launcher settings after the update.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssLauncherSettings -TssSession $session -EnableLauncherAutoUpdate:$false
```

Turn off launcher auto update

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

### -CheckInSecretOnLastLauncherClose
Check in the secret when the user closes their only active launcher

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -CloseLauncherOnCheckInSecret
Close every active launcher of a secret when the secret is checked in

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableDomainDownload
Allow users to download existing tested web launcher mappings

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableDomainUpload
Allow the user to upload mappings

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableLauncher
Enable launcher

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableLauncherAutoUpdate
Enable launcher auto update

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableWebParsing
Allow Secret Server to retrieve and parse the mapped website when using the web launcher

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -LauncherDeploymentType
How launchers are deployed to the client: ProtocolHandler or ClickOnce

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SendSecretUrlToLauncher
Send the URL that is on the Secret to the web password launcher in addition to the bookmarklet

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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

### Thycotic.PowerShell.Configuration.LauncherSettings
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssLauncherSettings](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssLauncherSettings)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssLauncherSettings.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssLauncherSettings.ps1)
