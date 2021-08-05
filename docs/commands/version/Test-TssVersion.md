# Test-TssVersion

## SYNOPSIS
Test Secret Server version

## SYNTAX

```
Test-TssVersion [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Tests whether Secret Server version returned by Get-TssVersion is the latest

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Test-TssVersion -TssSession $session
```

Pulls version of Secret Server and queries for latest version, returning object with details

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Common.TestVersion
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/version/Test-TssVersion](https://thycotic-ps.github.io/thycotic.secretserver/commands/version/Test-TssVersion)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/version/Test-TssVersion.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/version/Test-TssVersion.ps1)

