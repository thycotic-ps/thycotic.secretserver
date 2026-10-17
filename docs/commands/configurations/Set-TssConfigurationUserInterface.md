---
title: Set-TssConfigurationUserInterface
parent: Configurations
grand_parent: Commands
---
# Set-TssConfigurationUserInterface

## SYNOPSIS
Set the user interface configuration

## SYNTAX

```
Set-TssConfigurationUserInterface [-TssSession] <Session> [-CustomBannerEndDate <DateTime>]
 [-CustomBannerStartDate <DateTime>] [-CustomBannerStyle <String>] [-CustomBannerText <String>]
 [-CustomBannerViewLink <String>] [-CustomBannerViewLinkText <String>] [-CustomLogoCollapsed <String>]
 [-CustomLogoCollapsedDark <String>] [-CustomLogoFullSize <String>] [-CustomLogoFullSizeDark <String>]
 [-CustomLogoLogin <String>] [-CustomLogoLoginDark <String>] [-IsCustomBannerDismissable] [-ShowCustomBanner]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the user interface configuration (custom logos and the global banner) and returns the updated configuration.
Only the parameters you pass are sent; everything else keeps its current value.
Switch parameters send their value, so -Name:$false turns a setting off.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssConfigurationUserInterface -TssSession $session -ShowCustomBanner -CustomBannerText 'Maintenance Saturday 22:00 UTC' -CustomBannerStyle 'warning' -CustomBannerEndDate (Get-Date).AddDays(3)
```

Show a warning banner for the next three days

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssConfigurationUserInterface -TssSession $session -ShowCustomBanner:$false
```

Hide the global banner

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

### -CustomBannerEndDate
When the global banner stops showing

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CustomBannerStartDate
When the global banner starts showing

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CustomBannerStyle
Banner style: status, failure, information, success, caution, warning or error

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

### -CustomBannerText
Banner text

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

### -CustomBannerViewLink
URL of the banner View link

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

### -CustomBannerViewLinkText
Text of the banner View link

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

### -CustomLogoCollapsed
Custom logo (light mode, collapsed nav)

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

### -CustomLogoCollapsedDark
Custom logo (dark mode, collapsed nav)

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

### -CustomLogoFullSize
Custom logo (light mode, full size)

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

### -CustomLogoFullSizeDark
Custom logo (dark mode, full size)

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

### -CustomLogoLogin
Custom logo on login screen (light mode)

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

### -CustomLogoLoginDark
Custom logo on login screen (dark mode)

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

### -IsCustomBannerDismissable
Users can dismiss the banner

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

### -ShowCustomBanner
Show the global banner

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

### Thycotic.PowerShell.Configuration.ConfigurationUserInterface
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssConfigurationUserInterface](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssConfigurationUserInterface)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssConfigurationUserInterface.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssConfigurationUserInterface.ps1)
