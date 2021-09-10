# Get-TssDirectoryServiceSyncStatus

## SYNOPSIS
Get status of the Directory Services synchronization

## SYNTAX

```
Get-TssDirectoryServiceSyncStatus [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get status of the Directory Services synchronization

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDirectoryServiceSyncStatus -TssSession $session
```

Return status of the directory service synchronization

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

### Thycotic.PowerShell.DirectoryServices.SyncStatus
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Get-TssDirectoryServiceSyncStatus](https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Get-TssDirectoryServiceSyncStatus)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Get-TssDirectoryServiceSyncStatus.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Get-TssDirectoryServiceSyncStatus.ps1)

