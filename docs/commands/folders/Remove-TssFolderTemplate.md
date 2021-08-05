# Remove-TssFolderTemplate

## SYNOPSIS
Remove the associated template on the folder

## SYNTAX

```
Remove-TssFolderTemplate [-TssSession] <Session> -Id <Int32> [-TemplateId <Int32[]>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Remove the ability to create secrets based on the template on the folder.
If no associated template exists on the folder then any template can be used.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Remove-TssFolderTemplate -TssSession $session -Id 23 -Template 6001, 6003, 6036
```

Removes Template 6001 from Folder ID 23

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
Type: Int32
Parameter Sets: (All)
Aliases: FolderId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TemplateId
Template ID to associated

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Remove-TssFolderTemplate](https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Remove-TssFolderTemplate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Remove-TssFolderTemplate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Remove-TssFolderTemplate.ps1)

