# Get-TssSecretDependencyTemplate

## SYNOPSIS
Get list of Dependency Templates

## SYNTAX

```
Get-TssSecretDependencyTemplate [-TssSession] <Session> [-Id <Int32[]>] [-Template <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Get list of Dependency Templates

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretDependencyTemplate -TssSession $session
```

Return list of the Dependency Templates found on Secret Server

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretDependencyTemplate -TssSession $session -Id 6
```

Return Dependency Template ID 6

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretDependencyTemplate -TssSession $session -Name 'Windows Service'
```

Return Dependency Template named Window Service

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
Dependency Template Id

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Template
Dependency Template Name

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.SecretDependencies.Template
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-dependencies/Get-TssSecretDependencyTemplate](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-dependencies/Get-TssSecretDependencyTemplate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/Get-TssSecretDependencyTemplate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/Get-TssSecretDependencyTemplate.ps1)

