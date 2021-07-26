# Find-TssFolder

## SYNOPSIS
Find secret folders

## SYNTAX

```
Find-TssFolder [-TssSession] <Session> [-ParentFolderId <Int32>] [-SearchText <String>]
 [-PermissionRequired <String>] [-SortBy <String>] [<CommonParameters>]
```

## DESCRIPTION
Find secret folders returning Folder ID and Name only

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Find-TssFolder -TssSession $session -ParentFolderId 56
```

Return folders with Parent Folder ID of 56

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

### -ParentFolderId
Parent Folder Id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: FolderId

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SearchText
Search by text value

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PermissionRequired
Filter based on folder permission (Owner, Edit, AddSecret, View).
Default: View

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SortBy
Sort by specific property (Id, FolderName).
Default: FolderName

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: FolderName
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Folders.Lookup
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Find-TssFolder](https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Find-TssFolder)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Find-TssFolder.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Find-TssFolder.ps1)

