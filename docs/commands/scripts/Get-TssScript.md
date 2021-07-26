# Get-TssScript

## SYNOPSIS
Get a single Secret Server Script by Id

## SYNTAX

```
Get-TssScript [-TssSession] <Session> -Id <Int32[]> [<CommonParameters>]
```

## DESCRIPTION
Get a single Secret Server Script by Id (Admin \> Scripts)

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssScript -TssSession $session -Id 10
```

Return Script ID 10

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
Script ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: ScriptId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Scripts.Script
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/Get-TssScript](https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/Get-TssScript)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/Get-TssScript.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/Get-TssScript.ps1)

