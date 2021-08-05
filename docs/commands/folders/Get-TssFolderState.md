# Get-TssFolderState

## SYNOPSIS
Get details on a Folder

## SYNTAX

```
Get-TssFolderState [-TssSession] <Session> [-Id] <Int32[]> [-NoException] [<CommonParameters>]
```

## DESCRIPTION
Get details on allowed actions (create subfolders, edit folder, add secret, etc.) and templates of a Folder

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssFolderState -TssSession $session -Id 482
```

Returns details on Folder ID 482, if no access to folder will throw API exception

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssFolderState -TssSession $session -Id 482 -NoException
```

Returns details on Folder ID 482, if no access to folder will return no results

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
Folder ID

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

### -NoException
Return empty result instead of access denied exception

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

### Thycotic.PowerShell.Folders.DetailView
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Get-TssFolderState](https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Get-TssFolderState)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Get-TssFolderState.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Get-TssFolderState.ps1)

