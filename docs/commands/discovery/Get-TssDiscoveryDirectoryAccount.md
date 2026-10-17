---
title: Get-TssDiscoveryDirectoryAccount
parent: Discovery
grand_parent: Commands
---
# Get-TssDiscoveryDirectoryAccount

## SYNOPSIS
Get a discovered directory account

## SYNTAX

### Default (Default)
```
Get-TssDiscoveryDirectoryAccount [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

### Services
```
Get-TssDiscoveryDirectoryAccount [-TssSession] <Session> -Id <Int32[]> [-Services]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the detail of one or more directory accounts found by Discovery, including the computer, organizational unit and secret they are linked to.
With Services, returns the service accounts linked to the directory account instead.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoveryDirectoryAccount -TssSession $session -Id 120
```

Get the detail of discovered directory account 120

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoveryDirectoryAccount -TssSession $session -Id 120 -Services
```

Get the service accounts linked to directory account 120

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
Network item id of the directory account

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: NetworkItemId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Services
Return the services, scheduled tasks and application pools that run as the directory account

```yaml
Type: SwitchParameter
Parameter Sets: Services
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Discovery.DirectoryAccount
### Thycotic.PowerShell.Discovery.DirectoryAccountService
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryDirectoryAccount](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryDirectoryAccount)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryDirectoryAccount.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryDirectoryAccount.ps1)
