# Get-TssSite

## SYNOPSIS
Get a list of Sites

## SYNTAX

```
Get-TssSite [-TssSession] <Session> [-IncludeInactive] [<CommonParameters>]
```

## DESCRIPTION
Get a list of Sites

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSite -TssSession $session -IncludeInactive
```

Get a list of Sites, including those disabled in the results

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

### -IncludeInactive
Include inactive sites

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Common.Site
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/sites/Get-TssSite](https://thycotic-ps.github.io/thycotic.secretserver/commands/sites/Get-TssSite)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sites/Get-TssSite.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sites/Get-TssSite.ps1)

