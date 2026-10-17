---
title: Set-TssReadOnlyMode
parent: Configurations
grand_parent: Commands
---
# Set-TssReadOnlyMode

## SYNOPSIS
Enable or disable Read-Only Mode

## SYNTAX

```
Set-TssReadOnlyMode [-TssSession] <Session> [-Enabled] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Turns Read-Only Mode on (-Enabled) or off (-Enabled:$false) and returns the setting.
While Read-Only Mode is on, Secret Server rejects some changes for every user, such as creating a secret or saving a whole secret (Update-TssSecret). Not every change is blocked: creating a folder still works, and a single field update (Set-TssSecretField) can still save its value, even when it returns a read-only error.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssReadOnlyMode -TssSession $session -Enabled
```

Puts Secret Server in Read-Only Mode

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssReadOnlyMode -TssSession $session -Enabled:$false
```

Takes Secret Server out of Read-Only Mode

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

### -Enabled
Turn Read-Only Mode on.
Use -Enabled:$false to turn it off

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

### Thycotic.PowerShell.Configuration.ReadOnlyMode
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssReadOnlyMode](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssReadOnlyMode)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssReadOnlyMode.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssReadOnlyMode.ps1)
