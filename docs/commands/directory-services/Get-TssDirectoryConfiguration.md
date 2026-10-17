---
title: Get-TssDirectoryConfiguration
parent: Directory Services
grand_parent: Commands
---
# Get-TssDirectoryConfiguration

## SYNOPSIS
Get the Directory Services configuration

## SYNTAX

```
Get-TssDirectoryConfiguration [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get the Directory Services settings: whether directory integration, synchronization and integrated Windows authentication are enabled, the synchronization interval, how new users are imported, inactive user disabling and how long operational logs are kept.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDirectoryConfiguration -TssSession $session
```

Show the Directory Services settings

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

### Thycotic.PowerShell.DirectoryServices.Configuration
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Get-TssDirectoryConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Get-TssDirectoryConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Get-TssDirectoryConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Get-TssDirectoryConfiguration.ps1)
