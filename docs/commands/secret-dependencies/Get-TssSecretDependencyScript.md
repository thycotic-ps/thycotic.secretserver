# Get-TssSecretDependencyScript

## SYNOPSIS
Get Scripts that are possible to use for Dependencies

## SYNTAX

```
Get-TssSecretDependencyScript [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get Scripts that are possible to use for Dependencies

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretDependencyScript -TssSession $session - some test value
```

Return Dependency scripts available for use

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

### Thycotic.PowerShell.SecretDependencies.Script
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-dependencies/Get-TssSecretDependencyScript](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-dependencies/Get-TssSecretDependencyScript)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/Get-TssSecretDependencyScript.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/Get-TssSecretDependencyScript.ps1)

