---
title: Update-TssSecretDependencyGroup
parent: Secret Dependencies
grand_parent: Commands
---
# Update-TssSecretDependencyGroup

## SYNOPSIS
Rename a secret dependency group or change its site

## SYNTAX

```
Update-TssSecretDependencyGroup [-TssSession] <Session> -Id <Int32> -GroupId <Int32> [-GroupName <String>]
 [-SiteId <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Rename a dependency group on a secret, or change the site its dependencies run on.
The server replaces both the name and the site on every update, so the command first reads the secret's dependency groups (Get-TssSecretDependencyGroup) and keeps the current value of anything you do not pass.
The group must be one of the secret's dependency groups; otherwise nothing is sent.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssSecretDependencyGroup -TssSession $session -Id 1050 -GroupId 12 -GroupName 'Prod web servers'
```

Rename dependency group 12 of secret 1050, keeping its site

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Update-TssSecretDependencyGroup -TssSession $session -Id 1050 -GroupId 12 -SiteId 3
```

Run the dependencies of group 12 on site 3

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
ID of the secret the dependency group is on

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: SecretId

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupId
ID of the dependency group (the Id property of Get-TssSecretDependencyGroup output)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: SecretDependencyGroupId

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupName
New name of the dependency group

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

### -SiteId
Site the group's dependencies run on; 0 sets Site from Secret

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

### Thycotic.PowerShell.SecretDependencies.Group
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-dependencies/Update-TssSecretDependencyGroup](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-dependencies/Update-TssSecretDependencyGroup)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/Update-TssSecretDependencyGroup.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/Update-TssSecretDependencyGroup.ps1)
