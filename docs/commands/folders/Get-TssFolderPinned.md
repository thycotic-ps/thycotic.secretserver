---
title: Get-TssFolderPinned
parent: Folders
grand_parent: Commands
---
# Get-TssFolderPinned

## SYNOPSIS
Get the folders the current user has pinned

## SYNTAX

```
Get-TssFolderPinned [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the folders the current user has pinned, with the display name and browse settings saved for each pin.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssFolderPinned -TssSession $session
```

Returns every folder pinned by the user the session belongs to

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

### Thycotic.PowerShell.Folders.Pinned[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Get-TssFolderPinned](https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Get-TssFolderPinned)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Get-TssFolderPinned.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Get-TssFolderPinned.ps1)
