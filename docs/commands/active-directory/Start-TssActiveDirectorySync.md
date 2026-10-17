---
title: Start-TssActiveDirectorySync
parent: Active Directory
grand_parent: Commands
---
# Start-TssActiveDirectorySync

## SYNOPSIS
Start the Active Directory group and user synchronization

## SYNTAX

```
Start-TssActiveDirectorySync [-TssSession] <Session> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Queue the Active Directory synchronization, which updates the members of every directory group that has synchronization enabled.
Returns True when the run is queued.
The server answers 400 API_ADConfigDisabled when directory integration or directory synchronization is disabled (see Get-TssDirectoryConfiguration).
Start-TssDirectoryServiceSync queues the same background synchronization through the directory-services endpoint.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Start-TssActiveDirectorySync -TssSession $session
```

Queue the Active Directory synchronization

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

### System.Boolean
## NOTES
Requires TssSession object returned by New-TssSession

Requires the Administer Active Directory permission.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/active-directory/Start-TssActiveDirectorySync](https://thycotic-ps.github.io/thycotic.secretserver/commands/active-directory/Start-TssActiveDirectorySync)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/active-directory/Start-TssActiveDirectorySync.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/active-directory/Start-TssActiveDirectorySync.ps1)
