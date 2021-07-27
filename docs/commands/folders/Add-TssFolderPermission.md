# Add-TssFolderPermission

## SYNOPSIS
Add a User or Group permission to a Folder

## SYNTAX

### user
```
Add-TssFolderPermission [-TssSession] <Session> -FolderId <Int32[]> -Username <String> -FolderRole <String>
 -SecretRole <String> [-Force] [<CommonParameters>]
```

### group
```
Add-TssFolderPermission [-TssSession] <Session> -FolderId <Int32[]> -Group <String> -FolderRole <String>
 -SecretRole <String> [-Force] [<CommonParameters>]
```

## DESCRIPTION
Add a User or Group permission to a Folder.
Use -Force to break inheritance.

## EXAMPLES

### EXAMPLE 1
```
session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Add-TssFolderPermission -TssSession $session -Id 65 -Username bob -FolderRole Owner -SecretRole Edit
```

Add bob to Folder 65 granting Folder role of owner and Secret role of Edit

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$folders = Search-TssFolder -TssSession $session | Where-Object -not InheritPermission
$folders | Add-TssFolderPermission -TssSession $session -Username chance.wayne -FolderRole View -SecretRole List
```

Add "chance.wayne" to all Folders that do not have Inherit Permissions enabled.
Granting Folder role of View and Secret Role of List

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$folders = Search-TssFolder -TssSession $session -SearchText 'App'
$folders | Add-TssFolderPermission -TssSession $session -Username chad -FolderRole Owner -SecretRole Owner -Force
```

Add "chad" as owner for Folder and Secret on Folders that have "App" in their name, will also break inheritance if enabled on any of the Folders

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

### -FolderId
Folder ID

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

### -Username
Name of user to add

```yaml
Type: String
Parameter Sets: user
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Group
Name of group to add

```yaml
Type: String
Parameter Sets: group
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FolderRole
Folder Access Role (View, Edit, Add Secret, Owner)

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

### -SecretRole
Secret Access Role (View, Edit, List, Owner, None)

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

### -Force
If provided will break inheritance on the folder and add the permission

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.FolderPermissions.Permission
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Add-TssFolderPermission](https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Add-TssFolderPermission)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Add-TssFolderPermission.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Add-TssFolderPermission.ps1)

