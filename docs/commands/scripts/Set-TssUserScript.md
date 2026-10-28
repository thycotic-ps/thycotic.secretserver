---
title: Set-TssUserScript
parent: Scripts
grand_parent: Commands
---
# Set-TssUserScript

## SYNOPSIS
Update a user script

## SYNTAX

```
Set-TssUserScript [-TssSession] <Session> -Id <Int32> [-Name <String>] [-Description <String>]
 [-Script <String>] [-ScriptCategoryId <Int32>] [-Active] [-UsePowerShellCore]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the fields you pass on a user script and returns the updated script; fields you omit are unchanged.
Name, description and script must not be empty when passed.
ScriptCategoryId must be an existing category; category 9 (Dependency Validation) needs a PowerShell script.
The script type cannot be changed.
To change the parameters or SQL and SSH settings use Update-TssUserScriptParameter.
Requires the Administer Scripts permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssUserScript -TssSession $session -Id 12 -Description 'Restart IIS and the app pool'
```

Change the description of user script 12

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssUserScript -TssSession $session -Id 12 -Active:$false
```

Deactivate user script 12

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

### -Name
New script name

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

### -Description
New script description

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

### -Script
New script body

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

### -ScriptCategoryId
New script category ID, see Search-TssUserScriptCategory

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

### -Active
Activate the script, or deactivate it with -Active:$false

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

### -UsePowerShellCore
PowerShell scripts: run the script under PowerShell Core, or under Windows PowerShell with -UsePowerShellCore:$false

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

### Thycotic.PowerShell.Scripts.ScriptItem
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/Set-TssUserScript](https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/Set-TssUserScript)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/Set-TssUserScript.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/Set-TssUserScript.ps1)
