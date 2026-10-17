---
title: Get-TssFolderStub
parent: Folders
grand_parent: Commands
---
# Get-TssFolderStub

## SYNOPSIS
Get the default values for a new folder

## SYNTAX

```
Get-TssFolderStub [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns a folder object filled with the default values Secret Server uses for a new folder.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssFolderStub -TssSession $session
```

Returns the defaults for a new folder

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Folders.Folder
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Get-TssFolderStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Get-TssFolderStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Get-TssFolderStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Get-TssFolderStub.ps1)
