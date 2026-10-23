---
title: Set-TssDirectoryServiceConfiguration
parent: Directory Services
grand_parent: Commands
---
# Set-TssDirectoryServiceConfiguration

## SYNOPSIS
Update the Directory Services configuration

## SYNTAX

```
Set-TssDirectoryServiceConfiguration [-TssSession] <Session> [-DaysToKeepOperationalLogs <Int32>]
 [-DisableInactiveUsersMonths <Int32>] [-EnableDirectoryIntegration] [-EnableDirectorySynchronization]
 [-EnableIntegratedWindowsAuthentication] [-EnableUserDisabling] [-SynchronizationIntervalDays <Int32>]
 [-SynchronizationIntervalHours <Int32>] [-SynchronizationIntervalMinutes <Int32>]
 [-UserAccountOptions <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Update the Directory Services settings.
Only the parameters you pass are sent; everything else stays as it is.
Pass a switch as -EnableUserDisabling:$false to turn that setting off.
The server applies -DisableInactiveUsersMonths only while user disabling is on (already on, or turned on with -EnableUserDisabling in the same call) and ignores it otherwise.
Turning user disabling off clears the stored months, which then read back as 3.
The synchronization interval is applied only while directory synchronization is on, and synchronization cannot be turned on while directory integration is off.
Returns the updated configuration.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDirectoryServiceConfiguration -TssSession $session -SynchronizationIntervalDays 0 -SynchronizationIntervalHours 4 -SynchronizationIntervalMinutes 0
```

Synchronize the directory every four hours (directory synchronization must already be on)

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDirectoryServiceConfiguration -TssSession $session -EnableUserDisabling -DisableInactiveUsersMonths 6
```

Disable directory users after six months without a login

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

### -DaysToKeepOperationalLogs
Days to keep the directory synchronization log

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

### -DisableInactiveUsersMonths
Months without a login before a directory user is disabled, 1 to 12; applied only while user disabling is on

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

### -EnableDirectoryIntegration
Enable directory integration (Active Directory, Azure AD, OpenLDAP)

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

### -EnableDirectorySynchronization
Enable the scheduled directory synchronization

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

### -EnableIntegratedWindowsAuthentication
Enable integrated Windows authentication

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

### -EnableUserDisabling
Disable directory users who have not logged in for DisableInactiveUsersMonths months; turning it off resets DisableInactiveUsersMonths to the server default of 3

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
Days part of the synchronization interval, applied only while directory synchronization is on

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
Hours part of the synchronization interval, applied only while directory synchronization is on

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

### -SynchronizationIntervalMinutes
Minutes part of the synchronization interval, applied only while directory synchronization is on

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

### -UserAccountOptions
How synchronized users are created: ImportEnabled, ImportDisabled or MirrorDirectory

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

### Thycotic.PowerShell.DirectoryServices.Configuration
## NOTES
Requires TssSession object returned by New-TssSession

Requires the Administer Active Directory permission.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Set-TssDirectoryServiceConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Set-TssDirectoryServiceConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Set-TssDirectoryServiceConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Set-TssDirectoryServiceConfiguration.ps1)
