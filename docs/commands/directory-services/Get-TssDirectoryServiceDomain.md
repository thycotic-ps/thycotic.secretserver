# Get-TssDirectoryServiceDomain

## SYNOPSIS
Get a Directory Service Domain

## SYNTAX

```
Get-TssDirectoryServiceDomain [-TssSession] <Session> -Id <Int32[]> [<CommonParameters>]
```

## DESCRIPTION
Get a Directory Service Domain

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDirectoryServiceDomain -TssSession $session -Id 4
```

Return details on Directory Services Domain ID 4

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDirectoryServiceDomain -TssSession $session | Get-TssDirectoryServiceDomain -TssSession $session
```

Return details on all active Directory Services domains found

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
Short description for parameter

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: DomainId

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

### Thycotic.PowerShell.DirectoryServices.Domain
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Get-TssDirectoryServiceDomain](https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Get-TssDirectoryServiceDomain)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Get-TssDirectoryServiceDomain.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Get-TssDirectoryServiceDomain.ps1)

