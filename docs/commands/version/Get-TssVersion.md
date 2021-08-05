# Get-TssVersion

## SYNOPSIS
Get version of Secret Server

## SYNTAX

```
Get-TssVersion [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get the version of Secret Server

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssVersion -TssSession $session
```

Returns version of Secret Server alpha

## PARAMETERS

### -TssSession
TssSession object created by New-TssSession

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Common.SemanticVersion
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/version/Get-TssVersion](https://thycotic-ps.github.io/thycotic.secretserver/commands/version/Get-TssVersion)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/version/Get-TssVersion.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/version/Get-TssVersion.ps1)

