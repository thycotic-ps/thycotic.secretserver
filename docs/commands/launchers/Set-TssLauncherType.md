---
title: Set-TssLauncherType
parent: Launchers
grand_parent: Commands
---
# Set-TssLauncherType

## SYNOPSIS
Update a launcher type

## SYNTAX

```
Set-TssLauncherType [-TssSession] <Session> -Id <Int32> [-Active] [-AdditionalProcessesToRecord <String>]
 [-AdditionalPromptField] [-AdditionalPromptFieldName <String>] [-BatchFileId <Int32>] [-CanUseSSHKey]
 [-CharactersToEscape <String>] [-ChildLauncherId <Int32>] [-CustomLauncherId <Int32>]
 [-EscapeCharacter <String>] [-LaunchAsSecretCredentials] [-Name <String>] [-LoadUserProfile]
 [-MacProcessArguments <String>] [-MacProcessName <String>] [-MstscLauncherOption]
 [-OverrideDisallowAdditionalParametersInQuotes] [-PreserveSSHClientProcess] [-ProcessArguments <String>]
 [-ProcessName <String>] [-RdsCredentialsSecretId <Int32>] [-RdsServerHostname <String>]
 [-RdsServerPort <Int32>] [-RecordKeystrokes] [-RecordMultipleWindows] [-RecordOnlyKeystrokes]
 [-RecordSSHTunnel] [-ScriptId <Int32>] [-ShellScriptId <Int32>] [-UseSFTPTunnel] [-UseShellExecute]
 [-UseSSHTunnel] [-UseTemporaryFile] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Update the properties of a launcher type.
Only the parameters you pass are changed.
Custom launcher types accept every field; built-in launcher types reject some.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssLauncherType -TssSession $session -Id 9 -Active:$false
```

Deactivate launcher type 9

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssLauncherType -TssSession $session -Id 9 -Name 'Admin CMD v2' -ProcessArguments '/k whoami'
```

Rename launcher type 9 and change its arguments

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
Launcher type Id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: LauncherTypeId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Active
Set the launcher type active (-Active) or inactive (-Active:$false)

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
Determines whether to include additional prompts for the launcher

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
The updated name of the additional prompt

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
The updated batch file id

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

### -CanUseSSHKey
Determines whether you can use ssh key

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
The updated ID of the child launcher associated to this launcher

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

### -CustomLauncherId
The custom launcher id

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
New name of the launcher type

```yaml
Type: String
Parameter Sets: (All)
Aliases: LauncherTypeName

Required: False
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
The updated Mstsc launcher option

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
Process to launch (custom launchers)

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
The updated rds credentials secret ID

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
The updated rds server hostname

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
The updated rds server port

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

### -ScriptId
The updated tbScript.ScriptId of the customer-authored PowerShell script for the PowerShell Launcher type.
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
The updated PowerShell Launcher invocation mode: false = inline -EncodedCommand; true = -File

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/launchers/Set-TssLauncherType](https://thycotic-ps.github.io/thycotic.secretserver/commands/launchers/Set-TssLauncherType)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launchers/Set-TssLauncherType.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launchers/Set-TssLauncherType.ps1)
