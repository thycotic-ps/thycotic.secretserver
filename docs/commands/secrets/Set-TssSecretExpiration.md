# Set-TssSecretExpiration

## SYNOPSIS
Set Secret expiration

## SYNTAX

### SpecificDate
```
Set-TssSecretExpiration [-TssSession] <Session> -Id <Int32[]> [-DateExpiration <DateTime>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### DayInterval
```
Set-TssSecretExpiration [-TssSession] <Session> -Id <Int32[]> [-Interval <Int32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### Template
```
Set-TssSecretExpiration [-TssSession] <Session> -Id <Int32[]> [-Template] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Set Secret expiration

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecretExpiration -TssSession $session -Id 46 -DateExpiration (Get-Date).AddDays(21)
```

Set Secret expiration on Secret 46 to specific date 21 days from the current date

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecretExpiration -TssSession $session -Id 23 -Template
```

Set Secret expiration on Secret 23 to template, expiration being controlled with the Secret Template

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecretExpiration -TssSession $session -Id 42 -Interval 21
```

Set Secret expiration on Secret 23 to interval of 21 days

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

### -DateExpiration
Set expiration to specific date and time

```yaml
Type: DateTime
Parameter Sets: SpecificDate
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Interval
Set expiration to an interval (days)

```yaml
Type: Int32
Parameter Sets: DayInterval
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Template
Set expiration to Template

```yaml
Type: SwitchParameter
Parameter Sets: Template
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

## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Set-TssSecretExpiration](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Set-TssSecretExpiration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Set-TssSecretExpiration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Set-TssSecretExpiration.ps1)

