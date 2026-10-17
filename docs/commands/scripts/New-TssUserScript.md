---
title: New-TssUserScript
parent: Scripts
grand_parent: Commands
---
# New-TssUserScript

## SYNOPSIS
Create a user script

## SYNTAX

```
New-TssUserScript [-TssSession] <Session> -Name <String> -Description <String> -ScriptType <String>
 -Script <String> [-ScriptCategoryId <Int32>] [-Active] [-PasswordChangerId <Int32>] [-UsePowerShellCore]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a PowerShell, SQL or SSH user script through the v2 userscripts endpoint and returns it with its type settings.
Unlike New-TssScript, it can link a SQL script to a password changer, choose PowerShell Core for a PowerShell script, and returns the v2 script model.
Name, description and script must not be empty.
ScriptCategoryId must be an existing category (see Search-TssUserScriptCategory); category 9 (Dependency Validation) needs a PowerShell script.
The script is created inactive unless -Active is passed.
Requires the Administer Scripts permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssUserScript -TssSession $session -Name 'Restart IIS' -Description 'Restart IIS after a password change' -ScriptType PowerShell -ScriptCategoryId 8 -Script 'iisreset /restart' -Active
```

Create an active PowerShell dependency script

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssUserScript -TssSession $session -Name 'Check DB' -Description 'Connectivity check' -ScriptType SQL -Script 'SELECT 1' -PasswordChangerId 9
```

Create an inactive SQL script linked to password changer 9

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

### -Name
Script name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Script description

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScriptType
Script type: PowerShell, SQL or SSH

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Script
Script body

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScriptCategoryId
Script category ID, see Search-TssUserScriptCategory.
Defaults to 1 (Untyped)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### -Active
Create the script active.
Omit it to create the script inactive

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

### -PasswordChangerId
SQL scripts: ID of the password changer the script uses to connect.
Omit it to keep the server default

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

### -UsePowerShellCore
PowerShell scripts: run the script under PowerShell Core instead of Windows PowerShell

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/New-TssUserScript](https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/New-TssUserScript)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/New-TssUserScript.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/New-TssUserScript.ps1)
