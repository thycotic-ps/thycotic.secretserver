# Get-TssSecretDependencyRunStatus

## SYNOPSIS
Get Run status of a Secret Dependency identifier

## SYNTAX

```
Get-TssSecretDependencyRunStatus [-TssSession] <Session> -Identifier <String[]> [<CommonParameters>]
```

## DESCRIPTION
Get Run status of a Secret Dependency identifier

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$ident = Start-TssSecretDependency -TssSession $session -Id 46
Get-TssSecretDependencyRunStatus -TssSession $session -Identifier $run
```

After starting a Secret's Dependency 46, get the status of that run

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

### -Identifier
Identifier, output from Start-TssSecretDependency

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.SecretDependencies.TaskProgress
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-dependencies/Get-TssSecretDependencyRunStatus](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-dependencies/Get-TssSecretDependencyRunStatus)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/Get-TssSecretDependencyRunStatus.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/Get-TssSecretDependencyRunStatus.ps1)

