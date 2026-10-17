---
title: Set-TssPlatformConfiguration
parent: Configurations
grand_parent: Commands
---
# Set-TssPlatformConfiguration

## SYNOPSIS
Set the Delinea Platform configuration

## SYNTAX

```
Set-TssPlatformConfiguration [-TssSession] <Session> [-EnablePlatformAuditIntegration]
 [-EnablePlatformInventoryForwarding] [-EnablePlatformOnLoginPage] [-ForcePlatformOnlyLogin]
 [-OpenIdConnectClientId <String>] [-OpenIdConnectClientSecret <SecureString>] [-OpenIdConnectEnabled]
 [-OpenIdConnectLoginUrl <String>] [-OpenIdConnectLogoutUrl <String>] [-PlatformTenantId <String>]
 [-ProfileName <String>] [-RequirePlatformMfa] [-SynchronizationIntervalDays <Int32>]
 [-SynchronizationIntervalHours <Int32>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Set the Delinea Platform integration settings.
Secret Server applies the synchronization intervals, audit and inventory forwarding, MFA and login page options only while OpenIdConnectEnabled is on; with it off they are ignored, and every update resets the login page options to false.
ForcePlatformOnlyLogin turns off local login: make sure a Platform login works before you set it.
The permission cache expiration, provisioning mode, UsePlatformSettings, vault Id and tenant Id that Get-TssPlatformConfiguration returns cannot be set here. While OpenIdConnectEnabled is off, every update clears the vault Id and tenant Id.
Only the parameters you pass are sent.
Returns the Delinea Platform configuration after the update.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssPlatformConfiguration -TssSession $session -SynchronizationIntervalHours 6
```

Synchronize with the Delinea Platform every six hours (Platform integration on)

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

### -EnablePlatformAuditIntegration
Send audit events to the Delinea Platform

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

### -EnablePlatformInventoryForwarding
Send discovered computers to the Delinea Platform inventory

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

### -EnablePlatformOnLoginPage
Show the Delinea Platform login option on the login page

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

### -ForcePlatformOnlyLogin
Allow only Delinea Platform login; local login is turned off

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

### -OpenIdConnectClientId
OpenID Connect client Id

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

### -OpenIdConnectClientSecret
OpenID Connect client secret

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OpenIdConnectEnabled
Turn on OpenID Connect login through the Delinea Platform

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

### -OpenIdConnectLoginUrl
OpenID Connect login URL

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

### -OpenIdConnectLogoutUrl
OpenID Connect logout URL

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

### -PlatformTenantId
Delinea Platform tenant Id (GUID).
Used only to check the client Id and secret while OpenIdConnectEnabled is on; Secret Server does not save it

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

### -ProfileName
Authentication profile name

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

### -RequirePlatformMfa
Require multifactor authentication through the Delinea Platform

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

### -SynchronizationIntervalDays
Days between Platform synchronizations

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SynchronizationIntervalHours
Hours between Platform synchronizations

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
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

### Thycotic.PowerShell.Configuration.PlatformConfiguration
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssPlatformConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssPlatformConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssPlatformConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssPlatformConfiguration.ps1)
