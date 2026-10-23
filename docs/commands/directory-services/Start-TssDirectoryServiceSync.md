---
title: Start-TssDirectoryServiceSync
parent: Directory Services
grand_parent: Commands
---
# Start-TssDirectoryServiceSync

## SYNOPSIS
Run synchronization to update users and groups for all enabled Directories

## SYNTAX

```
Start-TssDirectoryServiceSync [-TssSession] <Session> [-PassThru]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Run synchronization to update users and groups for all enabled Directories

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Start-TssDirectoryServiceSync -TssSession $session
```

Run Directory Services synchronization

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Start-TssDirectoryServiceSync -TssSession $session -PassThru
```

Run Directory Services synchronization and output True when it is queued

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

### -PassThru
Output the Boolean Secret Server returns, True when the synchronization is queued

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
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

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Start-TssDirectoryServiceSync](https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Start-TssDirectoryServiceSync)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Start-TssDirectoryServiceSync.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Start-TssDirectoryServiceSync.ps1)
