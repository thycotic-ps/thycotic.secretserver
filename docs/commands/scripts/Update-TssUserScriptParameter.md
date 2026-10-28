---
title: Update-TssUserScriptParameter
parent: Scripts
grand_parent: Commands
---
# Update-TssUserScriptParameter

## SYNOPSIS
Replace the parameters and type settings of a user script

## SYNTAX

### powershell
```
Update-TssUserScriptParameter [-TssSession] <Session> -Id <Int32> [-UsePowerShellCore]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### sql
```
Update-TssUserScriptParameter [-TssSession] <Session> -Id <Int32> [-SqlDatabase <String>] [-SqlPort <Int32>]
 [-SqlPasswordChangerId <Int32>] [-SqlParameter <Object[]>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### ssh
```
Update-TssUserScriptParameter [-TssSession] <Session> -Id <Int32> [-SshPort <Int32>] [-SshLineEnding <String>]
 [-SshDoNotUseEnvironment] [-SshParameter <Object[]>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Replaces the type settings block of a user script: PowerShell Core use for a PowerShell script, database, port, password changer and parameters for a SQL script, or port, line ending, environment use and parameters for an SSH script.
This is a full replace, not a partial update: every setting of the block you do not pass is cleared, including the password changer of a SQL script and the parameter list.
Read the current values with Get-TssUserScript (AdditionalData) first.
The server applies only the block that matches the script type and ignores the others, so use the parameter set of that type.
Requires the Administer Scripts permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssUserScriptParameter -TssSession $session -Id 12 -UsePowerShellCore
```

Run PowerShell user script 12 under PowerShell Core

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssUserScriptParameter -TssSession $session -Id 14 -SqlDatabase master -SqlPort 1433 -SqlPasswordChangerId 2 -SqlParameter @{ parameterName = '@id'; parameterDbType = 'Int32' }
```

Set the database, port, password changer and one parameter of SQL user script 14

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssUserScriptParameter -TssSession $session -Id 15 -SshLineEnding CarriageReturnNewLine -SshParameter @{ parameterName = 'host'; parameterSshType = 'Literal' }
```

Set the line ending and one parameter of SSH user script 15

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
User script ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: ScriptId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UsePowerShellCore
PowerShell scripts: run the script under PowerShell Core, or under Windows PowerShell with -UsePowerShellCore:$false

```yaml
Type: SwitchParameter
Parameter Sets: powershell
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SqlDatabase
SQL scripts: database the script runs against

```yaml
Type: String
Parameter Sets: sql
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SqlPort
SQL scripts: port used to connect

```yaml
Type: Int32
Parameter Sets: sql
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SqlPasswordChangerId
SQL scripts: ID of the password changer the script uses to connect.
Omitting it clears the password changer

```yaml
Type: Int32
Parameter Sets: sql
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SqlParameter
SQL scripts: the complete parameter list; pass @() to clear it.
Each item is a hashtable or object with parameterName and parameterDbType (a System.Data.DbType name such as Int32 or String), for example the items of AdditionalData.sqlSettings.parameters from Get-TssUserScript.
Omitting it clears the parameter list

```yaml
Type: Object[]
Parameter Sets: sql
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SshPort
SSH scripts: port used to connect

```yaml
Type: Int32
Parameter Sets: ssh
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SshLineEnding
SSH scripts: line ending sent after each script line

```yaml
Type: String
Parameter Sets: ssh
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SshDoNotUseEnvironment
SSH scripts: do not use environment variables in the script

```yaml
Type: SwitchParameter
Parameter Sets: ssh
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SshParameter
SSH scripts: the complete parameter list; pass @() to clear it.
Each item is a hashtable or object with parameterName and parameterSshType (Intrepreted or Literal), for example the items of AdditionalData.sshSettings.parameters from Get-TssUserScript.
Omitting it clears the parameter list

```yaml
Type: Object[]
Parameter Sets: ssh
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

### Thycotic.PowerShell.Scripts.ScriptItem
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/Update-TssUserScriptParameter](https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/Update-TssUserScriptParameter)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/Update-TssUserScriptParameter.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/Update-TssUserScriptParameter.ps1)
