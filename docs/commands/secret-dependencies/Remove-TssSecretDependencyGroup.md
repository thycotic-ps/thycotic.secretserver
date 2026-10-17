---
title: Remove-TssSecretDependencyGroup
parent: Secret Dependencies
grand_parent: Commands
---
# Remove-TssSecretDependencyGroup

## SYNOPSIS
Delete a secret dependency group

## SYNTAX

```
Remove-TssSecretDependencyGroup [-TssSession] <Session> -Id <Int32[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Delete a secret dependency group by its ID (the Id property of Get-TssSecretDependencyGroup output).
The server refuses to delete a group that still holds dependencies: remove them first with Remove-TssSecretDependency.
Prompts for confirmation unless -Confirm:$false is passed.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssSecretDependencyGroup -TssSession $session -Id 42
```

Delete secret dependency group 42 after confirmation

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretDependencyGroup -TssSession $session -Id 1050 | Where-Object Name -eq 'Old servers' | Remove-TssSecretDependencyGroup -TssSession $session -Confirm:$false
```

Delete the dependency group named Old servers of secret 1050 without a prompt

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
Id of the secret dependency group to delete

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SecretDependencyGroupId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### Thycotic.PowerShell.Common.Delete
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-dependencies/Remove-TssSecretDependencyGroup](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-dependencies/Remove-TssSecretDependencyGroup)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/Remove-TssSecretDependencyGroup.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/Remove-TssSecretDependencyGroup.ps1)
