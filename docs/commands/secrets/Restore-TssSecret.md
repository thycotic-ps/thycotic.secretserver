# Restore-TssSecret

## SYNOPSIS
Undelete a Secret(s)

## SYNTAX

```
Restore-TssSecret [-TssSession] <Session> -Id <Int32[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Undelete a Secret(s)

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Restore-TssSecret -TssSession $session -Id 34, 56
```

Un-delete Secrets 34 and 56

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
Folder Id to modify

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

## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Restore-TssSecret](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Restore-TssSecret)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Restore-TssSecret.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Restore-TssSecret.ps1)

