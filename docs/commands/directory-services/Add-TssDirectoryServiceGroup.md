# Add-TssDirectoryServiceGroup

## SYNOPSIS
Add or link a Directory Service Group to synchronize

## SYNTAX

```
Add-TssDirectoryServiceGroup [-TssSession] <Session> -DomainId <Int32> -GroupName <String>
 [-DomainIdentifier <Guid>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Add or link a Directory Service Group to synchronize

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Add-TssDirectoryServiceGroup -TssSession $session -DomainId 4  -DomainIdentifier 'd87ac1d5-8f28-4910-b08a-5128af003626' -Name 'Secret User Group 1'
```

Add a domain group named "Secret User Group 1" to be synchronized with under Directory Services ID 4

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDirectoryServiceGroup -TssSession $session -DomainId 4 -SearchText 'Secret*' | Add-TssDirectoryServiceGroup -TssSession $session -DomainId 4
Search-TssGroup -TssSession $session -DomainId 4
```

Add all Directory Groups found starign with "Secret" for Domain ID 4, then run a group search to show they are added

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

### -GroupName
Group Name

```yaml
Type: String
Parameter Sets: (All)
Aliases: Name

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DomainIdentifier
Unique directory/domain identifier (e.g.
AD GUID from Active Directory of that object)

```yaml
Type: Guid
Parameter Sets: (All)
Aliases:

Required: False
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

## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Add-TssDirectoryServiceGroup](https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Add-TssDirectoryServiceGroup)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Add-TssDirectoryServiceGroup.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Add-TssDirectoryServiceGroup.ps1)

