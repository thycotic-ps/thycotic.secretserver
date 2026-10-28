---
title: Get-TssDiscoveryFolderRule
parent: Discovery
grand_parent: Commands
---
# Get-TssDiscoveryFolderRule

## SYNOPSIS
Get the Discovery import rules that target a folder or its subfolders

## SYNTAX

```
Get-TssDiscoveryFolderRule [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the id and name of each Discovery import rule that creates secrets in the given folder or in any of its subfolders.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoveryFolderRule -TssSession $session -Id 7
```

Get the Discovery rules that import into folder 7 or a folder below it

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
Folder id

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: FolderId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Discovery.FolderRule[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryFolderRule](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryFolderRule)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryFolderRule.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryFolderRule.ps1)
