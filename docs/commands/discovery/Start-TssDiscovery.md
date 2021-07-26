# Start-TssDiscovery

## SYNOPSIS
Start Discovery processing

## SYNTAX

```
Start-TssDiscovery [-TssSession] <Session> [-Type] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Start Discovery processing

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Start-TssDiscovery -TssSession $session -Type ComputerScan
```

Run Discovery Computer Scan

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Start-TssDiscovery -TssSession $session -Type Discovery
```

Run Discovery Scan

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

### -Type
Secret Id

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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

## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Start-TssSecretHearbeat](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Start-TssSecretHearbeat)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Start-TssSecretHearbeat.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Start-TssSecretHearbeat.ps1)

