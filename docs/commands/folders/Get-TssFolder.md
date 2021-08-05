# Get-TssFolder

## SYNOPSIS
Get a folder from Secret Server

## SYNTAX

### id
```
Get-TssFolder [-TssSession] <Session> [-Id <Int32[]>] [-GetChildren] [-IncludeTemplate] [<CommonParameters>]
```

### filter
```
Get-TssFolder [-TssSession] <Session> [-FolderPath <String[]>] [-GetChildren] [-IncludeTemplate]
 [<CommonParameters>]
```

## DESCRIPTION
Get a folder(s) from Secret Server

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssFolder -TssSession $session -Id 4
```

Returns the folder object for Folder ID, 4

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssFolder -TssSession $session -Id 93 -GetChildren
```

Returns the folder object for Folder ID 93, including the child folder details

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssFolder -TssSession $session -Id 93,34 -IncludeTemplate
```

Returns the folder object for Folder ID 93 and 94, including the Secret Templates associated with each folder

### EXAMPLE 4
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssFolder -TssSession $session -FolderPath '\ABC Company\Security'
```

Returns the folder object for the Security folder

### EXAMPLE 5
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssFolder -TssSession $session -FolderPath '\ABC Company\Security', 'ABC Company\Vendors'
```

Returns the folder object for the Security and Vendors folder

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
Folder ID to retrieve

```yaml
Type: Int32[]
Parameter Sets: id
Aliases: FolderId

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FolderPath
Folder Path, will retrieve the leaf level folder (see examples)

```yaml
Type: String[]
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -GetChildren
Retrieve all child folders within the requested folder

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: GetAllChildren

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeTemplate
Include allowable Secret Templates of the requested folder

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: IncludeAssociatedTemplates, IncludeTemplates

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

### Thycotic.PowerShell.Folders.Folder
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Get-TssFolder](https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Get-TssFolder)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Get-TssFolder.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Get-TssFolder.ps1)

