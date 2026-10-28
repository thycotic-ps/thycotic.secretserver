---
title: Enable-TssSecret
parent: Secrets
grand_parent: Commands
---
# Enable-TssSecret

## SYNOPSIS
Activate a deleted secret

## SYNTAX

```
Enable-TssSecret [-TssSession] <Session> -Id <Int32[]> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Activates (undeletes) a deleted secret through the v3 activate endpoint and returns Success.
Success is True when the secret is already active.
Restore-TssSecret does the same through the older undelete endpoint.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Enable-TssSecret -TssSession $session -Id 42
```

Activates secret 42

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSecret -TssSession $session -IncludeInactive -ExcludeActive | Enable-TssSecret -TssSession $session -WhatIf
```

Shows which deleted secrets would be activated

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
Secret ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SecretId

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

### Thycotic.PowerShell.Secrets.ActivateResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Enable-TssSecret](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Enable-TssSecret)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Enable-TssSecret.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Enable-TssSecret.ps1)
