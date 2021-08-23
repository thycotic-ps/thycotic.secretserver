# Set-TssConfigurationAutoExport

## SYNOPSIS
Set Automatic Export configuration

## SYNTAX

```
Set-TssConfigurationAutoExport [-TssSession] <Session> [-Enable] [-Path <String>] [-FolderId <Int32>]
 [-AllFolders] [-Frequency <Int32>] [-SecretId <Int32>] [-IncludeChildFolders] [-IncludeFolderPaths]
 [-IncludeTotpSettings] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Set Automatic Export configuration

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssConfigurationAutoExport -TssSession $session -EnableAutoExport -ExportPath 'c:\temp\export'
```

Enable Automatic Export, setting the needed configuration options

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssConfigurationAutoExport -TssSession $session -TimeZone (Get-TimeZone).Id
```

Set Secret Server Time Zone to the current user's Windows' default TimeZone.

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

### -Enable
Enable Automatic Export feature

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

### -Path
Export path, local path on Secret Server web node(s)

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

### -FolderId
Folder ID to export, pass in $null for All Folders

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllFolders
Export All Folders

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

### -Frequency
Frequency (days)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretId
Secret ID for export password

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeChildFolders
Include Child folders on export

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

### -IncludeFolderPaths
Include Folder paths on export

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

### -IncludeTotpSettings
Include TOTP settings

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

## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssConfigurationAutoExport](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssConfigurationAutoExport)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssConfigurationAutoExport.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssConfigurationAutoExport.ps1)

