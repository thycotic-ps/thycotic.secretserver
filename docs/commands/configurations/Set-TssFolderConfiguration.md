---
title: Set-TssFolderConfiguration
parent: Configurations
grand_parent: Commands
---
# Set-TssFolderConfiguration

## SYNOPSIS
Set the folder configuration

## SYNTAX

```
Set-TssFolderConfiguration [-TssSession] <Session> [-EnablePersonalFolders] [-PersonalFolderName <String>]
 [-PersonalFolderNameOption <String>] [-PersonalFolderWarning <String>] [-RequireViewFolderPermission]
 [-ShowPersonalFolderWarning] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Set the personal folder and folder permission options of the Folders configuration.
Only the parameters you pass are sent.
Returns the folder configuration after the update; Get-TssConfiguration -Type Folders reads it.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssFolderConfiguration -TssSession $session -PersonalFolderNameOption UsernameAndDomain
```

Name personal folders by user name and domain

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

### -EnablePersonalFolders
Create a personal folder for every user; pass -EnablePersonalFolders:$false to turn it off

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

### -PersonalFolderName
Name of the root folder that holds the personal folders

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

### -PersonalFolderNameOption
How each personal folder is named: DisplayName or UsernameAndDomain

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

### -PersonalFolderWarning
Warning text shown when ShowPersonalFolderWarning is on

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

### -RequireViewFolderPermission
Users only see folders they have View permission on

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

### -ShowPersonalFolderWarning
Show the personal folder warning text

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

### Thycotic.PowerShell.Configuration.Folders
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssFolderConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssFolderConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssFolderConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssFolderConfiguration.ps1)
