---
title: Get-TssIcon
parent: Icon
grand_parent: Commands
---
# Get-TssIcon

## SYNOPSIS
Save an icon to a file

## SYNTAX

```
Get-TssIcon [-TssSession] <Session> -Id <Int32[]> -Output <String>
 [<CommonParameters>]
```

## DESCRIPTION
Download an icon by Id and save it as icon-\<Id\>.ico in the Output folder.
Returns the saved file.
An Id without an icon saves nothing and writes a warning.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssIcon -TssSession $session -Id 1 -Output $env:TEMP
```

Save icon 1 as icon-1.ico in the temp folder

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
Icon Id

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

### -Output
Folder the icon files are saved to

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.IO.FileInfo
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/icon/Get-TssIcon](https://thycotic-ps.github.io/thycotic.secretserver/commands/icon/Get-TssIcon)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/icon/Get-TssIcon.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/icon/Get-TssIcon.ps1)
