---
title: Set-TssLauncherTypeFileAttachment
parent: Launchers
grand_parent: Commands
---
# Set-TssLauncherTypeFileAttachment

## SYNOPSIS
Upload a batch file or shell script for a custom launcher type

## SYNTAX

```
Set-TssLauncherTypeFileAttachment [-TssSession] <Session> -Path <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Upload a batch file (.bat) or shell script (.sh) as a custom launcher file attachment.
The returned FileAttachmentId is the value for -BatchFileId or -ShellScriptId on New-TssLauncherType and Set-TssLauncherType.
The file is sent base64 encoded in a JSON body.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$attachment = Set-TssLauncherTypeFileAttachment -TssSession $session -Path .\launch.bat
Set-TssLauncherType -TssSession $session -Id 9 -BatchFileId $attachment.FileAttachmentId
```

Upload launch.bat and attach it to custom launcher type 9

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

### -Path
Path of the .bat or .sh file to upload

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

### Thycotic.PowerShell.Launchers.FileAttachment
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/launchers/Set-TssLauncherTypeFileAttachment](https://thycotic-ps.github.io/thycotic.secretserver/commands/launchers/Set-TssLauncherTypeFileAttachment)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launchers/Set-TssLauncherTypeFileAttachment.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launchers/Set-TssLauncherTypeFileAttachment.ps1)
