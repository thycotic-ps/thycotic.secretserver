# Get-TssFolder

## SYNOPSIS
Get a folder from Secret Server

## SYNTAX

### id
```
Get-TssFolder [-TssSession] <TssSession> [-Id <Int32[]>] [-GetChildren] [-IncludeTemplate] [<CommonParameters>]
```

### filter
```
Get-TssFolder [-TssSession] <TssSession> [-GetChildren] [-IncludeTemplate] [<CommonParameters>]
```

### path
```
Get-TssFolder [-TssSession] <TssSession> [-FolderPath <String>] [<CommonParameters>]
```

## DESCRIPTION
Get a folder(s) from Secret Server

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssFolder -TssSession $session -Id 4
```

Returns folder associated with the Folder ID, 4

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssFolder -TssSession $session -Id 93 -GetChildren
```

Returns folder associated with the Folder ID, 93 and include child folders

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssFolder -TssSession $session -Id 93 -IncludeTemplate
```

Returns folder associated with Folder ID, 93 and include Secret Templates associated with the folder

### EXAMPLE 4
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssFolder -TssSession $session -FolderPath '\ABC Company\Security'
```

Returns folder that has a path of ABC Company\Security

## PARAMETERS

### -TssSession
TssSession object created by New-TssSession for auth

```yaml
Type: TssSession
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

### -GetChildren
Retrieve all child folders within the requested folder

```yaml
Type: SwitchParameter
Parameter Sets: id, filter
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
Parameter Sets: id, filter
Aliases: IncludeAssociatedTemplates, IncludeTemplates

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FolderPath
Get folder based on path (e.g.
\Parent\child1\child2)

```yaml
Type: String
Parameter Sets: path
Aliases:

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

### TssFolder
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssFolder](https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssFolder)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Get-Folder.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Get-Folder.ps1)

