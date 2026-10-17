---
title: Set-TssConfigurationApplication
parent: Configurations
grand_parent: Commands
---
# Set-TssConfigurationApplication

## SYNOPSIS
Set the application settings configuration

## SYNTAX

```
Set-TssConfigurationApplication [-TssSession] <Session> [-AllowSendTelemetry] [-AllowSoftwareUpdateChecks]
 [-ApiRefreshTokensEnabled] [-ApiSessionTimeoutDays <Int32>] [-ApiSessionTimeoutHours <Int32>]
 [-ApiSessionTimeoutMinutes <Int32>] [-ApiSessionTimeoutUnlimited] [-ConfigurationEarlyAdopterEnabled]
 [-CustomUrl <String>] [-DisplayDowntimeMessageToAdminsOnly] [-EnableCredSsp] [-EnableSyslogCefLogging]
 [-EnableWebServices] [-MaximumTokenRefreshesAllowed <Int32>] [-MaxSecretLogLength <Int32>]
 [-MobileMaxOfflineDays <Int32>] [-MobileMaxOfflineHours <Int32>] [-ObfuscatePersonallyIdentifiableInformation]
 [-PiiObfuscationLevel <String>] [-PreventApplicationFromSleeping] [-PreventDirectApiAuthentication]
 [-SyslogCefDateTimeFormat <String>] [-SyslogCefLogSite <Int32>] [-SyslogCefPort <Int32>]
 [-SyslogCefProtocol <String>] [-SyslogCefServer <String>] [-SyslogCefTimeZone <String>]
 [-TmsInstallationPath <String>] [-WinRmEndpointUrl <String>] [-WriteSyslogToEventLog]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the application settings configuration (API sessions and tokens, web services, Syslog/CEF logging, PII obfuscation, mobile offline access and related settings) and returns the full updated configuration.
Only the parameters you pass are sent; everything else keeps its current value.
Switch parameters send their value, so -Name:$false turns a setting off.
Secret Server Cloud rejects AllowSoftwareUpdateChecks, ConfigurationEarlyAdopterEnabled, PreventApplicationFromSleeping, WriteSyslogToEventLog, TmsInstallationPath and CustomUrl.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssConfigurationApplication -TssSession $session -ApiSessionTimeoutUnlimited:$false -ApiSessionTimeoutHours 8
```

Expire API sessions after 8 hours

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssConfigurationApplication -TssSession $session -EnableSyslogCefLogging -SyslogCefServer 'syslog.example.com' -SyslogCefPort 514 -SyslogCefProtocol 'UDP'
```

Send audit events to syslog.example.com over UDP port 514

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

### -AllowSendTelemetry
Send Anonymized System Metrics Information

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

### -AllowSoftwareUpdateChecks
Allow software update checks.
This setting is ignored in cloud environments

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

### -ApiRefreshTokensEnabled
Allow API refresh tokens

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

### -ApiSessionTimeoutDays
API session timeout, days part

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

### -ApiSessionTimeoutHours
API session timeout, hours part

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

### -ApiSessionTimeoutMinutes
API session timeout, minutes part

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

### -ApiSessionTimeoutUnlimited
API sessions never time out

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

### -ConfigurationEarlyAdopterEnabled
Notify when preview releases are available.
False by default

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

### -CustomUrl
Outward accessible url to get to application.
This setting is ignored in cloud environments

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

### -DisplayDowntimeMessageToAdminsOnly
Only show downtime messages to admins.
This setting is only used in cloud environments

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

### -EnableCredSsp
Use CredSSP for WinRM

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

### -EnableSyslogCefLogging
Send audit events to a Syslog/CEF server

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

### -EnableWebServices
Enable the web services (API)

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

### -MaximumTokenRefreshesAllowed
Maximum number of times an API token can be refreshed

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

### -MaxSecretLogLength
Maximum number of entries in secret log

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

### -MobileMaxOfflineDays
Maximum offline access on mobile devices, days part

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

### -MobileMaxOfflineHours
Maximum offline access on mobile devices, hours part

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

### -ObfuscatePersonallyIdentifiableInformation
Should Secret Server obfuscate information that could identify a person

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

### -PiiObfuscationLevel
Delimit or replace personally identifiable information and automatically remove from Audit Exports

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

### -PreventApplicationFromSleeping
A keep alive thread will run in the background pinging the web URL to make sure IIS does not stop running due to inactivity.
This setting is ignored in cloud environments

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

### -PreventDirectApiAuthentication
Prevent non-Application Account users from directly authenticating against the API

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

### -SyslogCefDateTimeFormat
DateTime Format for Syslog/CEF Protocol log timestamps.
Syslog: Jun 23 2022 11:22:33; ISO 8601: 2022-06-23T11:22:33.000

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

### -SyslogCefLogSite
Site id the Syslog/CEF logging runs on

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

### -SyslogCefPort
Syslog/CEF server port

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

### -SyslogCefProtocol
Syslog/CEF Protocol to use when sending logs

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

### -SyslogCefServer
Syslog/CEF Server Address

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

### -SyslogCefTimeZone
Time Zone to use when sending Syslog/CEF Protocol log entries

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

### -TmsInstallationPath
If TMS is installed, the file location.
This setting is ignored in cloud environments

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

### -WinRmEndpointUrl
WinRM endpoint URL

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

### -WriteSyslogToEventLog
Enable syslog events to the windows event log.
This setting is ignored in cloud environments

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

### Thycotic.PowerShell.Configuration.ApplicationSettings
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssConfigurationApplication](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssConfigurationApplication)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssConfigurationApplication.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssConfigurationApplication.ps1)
