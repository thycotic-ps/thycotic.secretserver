# Get-TssConfiguration

## SYNOPSIS
Get Secret Server configuration section(s)

## SYNTAX

```
Get-TssConfiguration [-TssSession] <Session> [-Type <String>] [<CommonParameters>]
```

## DESCRIPTION
Get Secret Server configuration section(s) found under Admin \> Configuration

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssConfiguration -TssSession $session -All
```

Return all configuration objects

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
Configuration type (Application, Email, Folders, Launcher, LocalUserPasswords, PermissionOptions, UserExperience, UserInterface)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: All
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Configuration.General
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssConfiguration.ps1)

