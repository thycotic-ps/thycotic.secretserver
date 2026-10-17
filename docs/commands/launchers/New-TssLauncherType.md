---
title: New-TssLauncherType
parent: Launchers
grand_parent: Commands
---
# New-TssLauncherType

## SYNOPSIS
Create a custom launcher type

## SYNTAX

```
New-TssLauncherType [-TssSession] <Session> [-Active] [-AdditionalProcessesToRecord <String>]
 [-AdditionalPromptField] [-AdditionalPromptFieldName <String>] [-Application <String>] [-BatchFileId <Int32>]
 [-CharactersToEscape <String>] [-ChildLauncherId <Int32>] [-EscapeCharacter <String>]
 [-LaunchAsSecretCredentials] -Name <String> [-LoadUserProfile] [-MacProcessArguments <String>]
 [-MacProcessName <String>] [-MstscLauncherOption] [-OverrideDisallowAdditionalParametersInQuotes]
 [-PreserveSSHClientProcess] [-ProcessArguments <String>] [-ProcessName <String>]
 [-RdsCredentialsSecretId <Int32>] [-RdsServerHostname <String>] [-RdsServerPort <Int32>] [-RecordKeystrokes]
 [-RecordMultipleWindows] [-RecordOnlyKeystrokes] [-RecordSSHTunnel] [-RunType <Int32>] [-ScriptId <Int32>]
 [-ShellScriptId <Int32>] [-UseSFTPTunnel] [-UseShellExecute] [-UseSSHTunnel] [-UseTemporaryFile]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create a custom (process) launcher type.
Only the parameters you pass are sent; omitted switches are created as false, so omit -Active to create the launcher type inactive.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssLauncherType -TssSession $session -Name 'Admin CMD' -ProcessName cmd.exe -ProcessArguments '/k echo $MACHINE' -Application 1 -RunType 1 -Active
```

Create an active custom launcher type that opens cmd.exe

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

### -Active
Create the launcher type active

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

### -AdditionalProcessesToRecord
The additional process to record if record multiple windows is set to true

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

### -AdditionalPromptField
Prompt the user for additional input at launch

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

### -AdditionalPromptFieldName
Label of the additional prompt

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

### -Application
Application identifier of the launcher type

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

### -BatchFileId
The batch file id

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

### -CharactersToEscape
Denotes a group of characters to escape

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

### -ChildLauncherId
The ID of the child launcher associated to this launcher

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

### -EscapeCharacter
Denotes an escape character

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

### -LaunchAsSecretCredentials
Determines whether to launch as secret credentials

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

### -Name
Name of the launcher type

```yaml
Type: String
Parameter Sets: (All)
Aliases: LauncherTypeName

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LoadUserProfile
Determines whether to load user profile if launch as secret credentials is set to true

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

### -MacProcessArguments
The updated mac process arguments

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

### -MacProcessName
The updated mac process name

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

### -MstscLauncherOption
The mstsc launcher option

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

### -OverrideDisallowAdditionalParametersInQuotes
Determines whether to wrap parameters in quotes

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

### -PreserveSSHClientProcess
Determines whether to preserve ssh client

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

### -ProcessArguments
Command-line arguments template for the process

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

### -ProcessName
Process to launch, for example cmd.exe or putty.exe

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

### -RdsCredentialsSecretId
The rds credentials secret ID

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

### -RdsServerHostname
The rds server hostname

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

### -RdsServerPort
The rds server port

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

### -RecordKeystrokes
Determines whether to record keystrokes

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

### -RecordMultipleWindows
Determines whether to record multiple windows

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

### -RecordOnlyKeystrokes
Determines whether to record only keystrokes and no video.
This option will override RecordKeystrokes if set to true

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

### -RecordSSHTunnel
Determines whether to record ssh tunnel

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

### -RunType
Run type id of the launcher (1 = process).
5 = PowerShell launcher, which needs -ScriptId

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

### -ScriptId
The tbScript.ScriptId of the customer-authored PowerShell script for the PowerShell Launcher type.
Required when RunType is PowerShellLauncherType (5).
The PowerShell engine choice is owned by the referenced script

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

### -ShellScriptId
The updated shell script id

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

### -UseSFTPTunnel
Determines whether to use sftp tunnel to allow multiple data connections

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

### -UseShellExecute
Determines whether to use shell execute

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

### -UseSSHTunnel
Determines whether to use ssh tunnel

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

### -UseTemporaryFile
PowerShell Launcher invocation mode: false = inline -EncodedCommand (default); true = -File (opt-in)

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

### Thycotic.PowerShell.Launchers.LauncherType
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/launchers/New-TssLauncherType](https://thycotic-ps.github.io/thycotic.secretserver/commands/launchers/New-TssLauncherType)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launchers/New-TssLauncherType.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launchers/New-TssLauncherType.ps1)
