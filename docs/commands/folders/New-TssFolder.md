# New-TssFolder

## SYNOPSIS
Create a new folder

## SYNTAX

```
New-TssFolder [-TssSession] <Session> -FolderName <String> [-ParentFolderId <Int32>] [-SecretPolicyId <Int32>]
 [-InheritPermissions] [-InheritSecretPolicy] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create a new folder

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssFolder -TssSession $session -FolderName 'tssNewFolder'
```

Creates a root folder named "tssNewFolder"

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$folderParams = @{
    TssSession = $session
    FolderName 'IT Dept'
    ParentFolderId = 27
    InheritPermissions = $false
}
New-TssFolder @folderParams
```

Creates a folder named "IT Dept" under parent folder 27 with Inherit Permissins disabled (set to No if viewed in the UI)

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssFolder -TssSession $session -FolderName 'Marketing Dept' -ParentFolderId 27 -InheritPermissions -InheritSecretPolicy
```

Creates a folder named "Marketing Dept" under parent folder 27 with inheritance enabled for Permissions and Secret Policy

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

### -FolderName
Folder Name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ParentFolderId
Parent Folder ID, default to root folder (-1)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: ParentFolder

Required: False
Position: Named
Default value: -1
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretPolicyId
Secret Policy ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: SecretPolicy

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -InheritPermissions
Inherit Permissions

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

### -InheritSecretPolicy
Inherit Secret Policy

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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/New-TssFolder](https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/New-TssFolder)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/New-TssFolder.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/New-TssFolder.ps1)

