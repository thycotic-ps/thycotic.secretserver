# Search-TssConfigurationAudit

## SYNOPSIS
Search system configuration audit

## SYNTAX

```
Search-TssConfigurationAudit [-TssSession] <Session> [-SearchText <String>] [-SortBy <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Search system configuration audit, latest record first

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssConfigurationAudit -TssSession $session -SearchText admin
```

Return audit records containing "admin" in any of the properties

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssConfigurationAudit -TssSession $session | Select-Object -First 25
```

Return 25 latest audit entries for Secret Server configuration

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

### -SearchText
Search text

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

### -SortBy
Sort by specific property, default Date

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Date
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Configuration.Audit
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Search-TssConfigurationAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Search-TssConfigurationAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Search-TssConfigurationAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Search-TssConfigurationAudit.ps1)

