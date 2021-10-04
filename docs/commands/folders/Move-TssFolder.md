# Move-TssFolder

## SYNOPSIS
Move a folder in Secret Server

## SYNTAX

```
Move-TssFolder [-TssSession] <Session> [-Id] <Int32[]> [-ParentFolderId] <Int32> [-DisableInheritPermissions]
 [-DisableInheritSecretPolicy] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Move a folder in Secret Server

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Move-TssFolder -TssSession $session -Id 45 -ParentFolderId 98
```

Moves folder 45 to parent folder 98, defaulting permissions and Secret Policy to inheritting from Folder 98

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Move-TssFolder -TssSession $session -Id 1092 -ParentFolderId 5409 -DisableInheritPermission
```

Moves folder 1092 to parent folder 5409, disabling inherit permissions and enabling inherit Secret Policy from folder 5409

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
Folder ID that will be moved

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: FolderId

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ParentFolderId
Parent Folder ID to move the folder to

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisableInheritPermissions
Do not inherit permissions from parent folder

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

### -DisableInheritSecretPolicy
Do not inherit Secret Policy from parent folder

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

### Thycotic.PowerShell.Folders.Folder
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Move-TssFolder](https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Move-TssFolder)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Move-TssFolder.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Move-TssFolder.ps1)

