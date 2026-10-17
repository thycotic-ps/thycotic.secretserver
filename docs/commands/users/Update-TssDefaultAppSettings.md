---
title: Update-TssDefaultAppSettings
parent: Users
grand_parent: Commands
---
# Update-TssDefaultAppSettings

## SYNOPSIS
Set the default application of the current user

## SYNTAX

```
Update-TssDefaultAppSettings [-TssSession] <Session> -DefaultApp <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
When Secret Server and Privilege Manager are both installed, sets which application loads after the current user logs in.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssDefaultAppSettings -TssSession $session -DefaultApp SecretServer
```

Makes Secret Server the application that loads after the current user logs in

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

### -DefaultApp
Application to load after login: None, SecretServer or PrivilegeManager

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

### Thycotic.PowerShell.Users.ActionResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Update-TssDefaultAppSettings](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Update-TssDefaultAppSettings)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Update-TssDefaultAppSettings.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Update-TssDefaultAppSettings.ps1)
