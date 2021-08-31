# Start-TssConfigurationSearchIndex

## SYNOPSIS
Start a rebuild for the Secret Search Index

## SYNTAX

```
Start-TssConfigurationSearchIndex [-TssSession] <Session> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Start a rebuild for the Secret Search Index

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Start-TssConfigurationSearchIndex -TssSession $session
```

Start a rebuild for the Secret Search Index

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Start-TssConfigurationSearchIndex](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Start-TssConfigurationSearchIndex)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Start-TssConfigurationSearchIndex.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Start-TssConfigurationSearchIndex.ps1)

