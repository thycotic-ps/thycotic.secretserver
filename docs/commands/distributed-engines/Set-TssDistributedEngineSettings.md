---
title: Set-TssDistributedEngineSettings
parent: Distributed Engines
grand_parent: Commands
---
# Set-TssDistributedEngineSettings

## SYNOPSIS
Update the feature settings of a Distributed Engine or of a site default

## SYNTAX

### Settings (Default)
```
Set-TssDistributedEngineSettings [-TssSession] <Session> -EngineSettingsId <Int32> [-AdSyncEnabled]
 [-AdvancedAuditingEnabled] [-ExternalVaultsEnabled] [-FipsEnabled] [-LocalAccountDiscoveryEnabled]
 [-LogLevel <String>] [-PasswordChangingEnabled] [-RdpGatewayEnabled] [-RdpProxyCertificateSecretId <Int32>]
 [-RdpProxyEnabled] [-SecretWorkflowEnabled] [-SecurityAnalyticsEnabled] [-ServiceAccountManagementEnabled]
 [-SshProxyEnabled] [-SshTerminalEnabled] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### Engine
```
Set-TssDistributedEngineSettings [-TssSession] <Session> -EngineId <Int32> [-AdSyncEnabled]
 [-AdvancedAuditingEnabled] [-ExternalVaultsEnabled] [-FipsEnabled] [-LocalAccountDiscoveryEnabled]
 [-LogLevel <String>] [-PasswordChangingEnabled] [-RdpGatewayEnabled] [-RdpProxyCertificateSecretId <Int32>]
 [-RdpProxyEnabled] [-SecretWorkflowEnabled] [-SecurityAnalyticsEnabled] [-ServiceAccountManagementEnabled]
 [-SshProxyEnabled] [-SshTerminalEnabled] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Updates engine settings by settings ID (-EngineSettingsId, as returned by Get-TssDistributedEngineSettings) or for one engine (-EngineId).
Only the parameters provided are sent; every other setting is unchanged.
Returns the updated settings.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDistributedEngineSettings -TssSession $session -EngineId 7 -SshProxyEnabled:$false -LogLevel Warn
```

Stops Distributed Engine 7 from processing SSH proxy work and sets its log level to Warn

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDistributedEngineSettings -TssSession $session -SiteId 1 | Set-TssDistributedEngineSettings -TssSession $session -PasswordChangingEnabled
```

Turns on password changing in the default engine settings of site 1

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

### -EngineSettingsId
Engine settings ID, as returned by Get-TssDistributedEngineSettings (0 means the engine has no settings of its own; use -EngineId)

```yaml
Type: Int32
Parameter Sets: Settings
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -EngineId
Distributed Engine ID, to update the settings of that engine

```yaml
Type: Int32
Parameter Sets: Engine
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -AdSyncEnabled
Process directory services synchronization work

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

### -AdvancedAuditingEnabled
Process advanced auditing work

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

### -ExternalVaultsEnabled
Process external vault work

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

### -FipsEnabled
Require FIPS compliance on the engine

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

### -LocalAccountDiscoveryEnabled
Process local account discovery work

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

### -LogLevel
Engine log level: All, Debug, Info, Warn, Error or Off

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

### -PasswordChangingEnabled
Process secret remote password changing work

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

### -RdpGatewayEnabled
Process RDP gateway work

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

### -RdpProxyCertificateSecretId
ID of the secret holding the RDP proxy certificate

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

### -RdpProxyEnabled
Process RDP proxy work

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

### -SecretWorkflowEnabled
Process secret workflow work

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

### -SecurityAnalyticsEnabled
Process security analytics work

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

### -ServiceAccountManagementEnabled
Process service account management work

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

### -SshProxyEnabled
Process SSH proxy work

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

### -SshTerminalEnabled
Process SSH terminal work

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

### Thycotic.PowerShell.DistributedEngines.EngineSettings
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Set-TssDistributedEngineSettings](https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Set-TssDistributedEngineSettings)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Set-TssDistributedEngineSettings.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Set-TssDistributedEngineSettings.ps1)
