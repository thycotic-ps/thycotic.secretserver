---
title: Update-TssSecretDependency
parent: Secret Dependencies
grand_parent: Commands
---
# Update-TssSecretDependency

## SYNOPSIS
Update a secret dependency

## SYNTAX

```
Update-TssSecretDependency [-TssSession] <Session> -Dependency <Dependency[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Update a secret dependency by sending the whole dependency object back to Secret Server.
Read the dependency with Get-TssSecretDependency, change its properties (for example Active, Description, Settings, or the field values in DependencyTemplate.DependencyScanItemFields) and pass it to this command.
Every property of the object is saved, so start from a current Get-TssSecretDependency result.
A SshKeySecretId, PrivilegedAccountSecretId or ConditionDependencyId of 0 means none and is sent as null (the server rejects 0 as a secret ID).

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$dependency = Get-TssSecretDependency -TssSession $session -Id 15
$dependency.Active = $false
Update-TssSecretDependency -TssSession $session -Dependency $dependency
```

Disable secret dependency 15

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$dependency = Get-TssSecretDependency -TssSession $session -Id 15
($dependency.DependencyTemplate.DependencyScanItemFields | Where-Object Name -EQ 'Machine').Value = 'app02.corp.example.com'
$dependency | Update-TssSecretDependency -TssSession $session
```

Point template-based secret dependency 15 at another machine (its Machine field wins over RunScript.MachineName)

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

### -Dependency
Secret dependency object, as returned by Get-TssSecretDependency

```yaml
Type: Dependency[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
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

### Thycotic.PowerShell.SecretDependencies.Dependency
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-dependencies/Update-TssSecretDependency](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-dependencies/Update-TssSecretDependency)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/Update-TssSecretDependency.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/Update-TssSecretDependency.ps1)
