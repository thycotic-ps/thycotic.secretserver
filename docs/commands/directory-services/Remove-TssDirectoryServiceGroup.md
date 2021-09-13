# Remove-TssDirectoryServiceGroup

## SYNOPSIS
Remove or unlink a Group from a Directory Services domain

## SYNTAX

```
Remove-TssDirectoryServiceGroup [-TssSession] <Session> -DomainId <Int32> -GroupId <Int32[]> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Remove or unlink a Group from a Directory Services domain

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssDirectoryServiceGroup -TssSession $session -DomainId 2 -GroupId 6
```

Remove Group ID 6 from Directory Services domain Id 2, will also disable the Group in Secret Server

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssGroup -TssSession $session -DomainId 1 -SearchText 'Secret' | Remove-TssDirectoryServiceGroup -TssSession $session -DomainId 1 -Verbose
```

Remove all Groups in Domain ID that contain "Secret" in the Group Name from the Directory Services Domain ID 1

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

### -DomainId
Domain ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -GroupId
Group ID(s) to remove

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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

### Thycotic.PowerShell.Common.Delete
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Remove-TssDirectoryServiceGroup](https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Remove-TssDirectoryServiceGroup)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Remove-TssDirectoryServiceGroup.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Remove-TssDirectoryServiceGroup.ps1)

