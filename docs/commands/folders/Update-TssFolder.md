# Update-TssFolder

## SYNOPSIS
Update all members of a group

## SYNTAX

```
Update-TssFolder [-TssSession] <Session> [-Folder] <Folder> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Update all members of a group

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$folder = Get-TssFolder -TssSession $session -Id 77
$folder.SecretPolicyId = 15
Update-TssFolder -TssSession $session -Folder $folder
```

Updates Folder ID 77 setting Secret Policy ID 15

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

### -Folder
Folder object, output from Get-TssFolder

```yaml
Type: Folder
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Update-TssFolder](https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Update-TssFolder)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Update-TssFolder.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Update-TssFolder.ps1)

