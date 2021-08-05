# Remove-TssFolderPermission

## SYNOPSIS
Delete a folder permissions

## SYNTAX

```
Remove-TssFolderPermission [-TssSession] <Session> -Id <Int32[]> [-BreakInheritance] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Delete a folder permissions

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssFolderPermission -TssSession $session -Id 9
```

Delete Folder Permission ID 9

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
Folder Permission ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: FolderPermissionId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -BreakInheritance
Include to remove permission inheritance

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

### Thycotic.PowerShell.Common.Delete
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/folder-permissions/Remove-TssFolderPermission](https://thycotic-ps.github.io/thycotic.secretserver/commands/folder-permissions/Remove-TssFolderPermission)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folder-permissions/Remove-TssFolderPermission.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folder-permissions/Remove-TssFolderPermission.ps1)

