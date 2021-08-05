# Remove-TssSecretDependency

## SYNOPSIS
Remove a Secret Dependency

## SYNTAX

```
Remove-TssSecretDependency [-TssSession] <Session> -Id <Int32[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Remove a Secret Dependency, this is permanent and not reversable

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssSecretDependency -TssSession $session -Id 24
```

Remove Secret Dependency 24

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
Short description for parameter

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SecretDependencyId

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-dependencies/Remove-TssSecretDependency](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-dependencies/Remove-TssSecretDependency)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/Remove-TssSecretDependency.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/Remove-TssSecretDependency.ps1)

