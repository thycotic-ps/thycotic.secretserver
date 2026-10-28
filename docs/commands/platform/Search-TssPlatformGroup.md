---
title: Search-TssPlatformGroup
parent: Platform
grand_parent: Commands
---
# Search-TssPlatformGroup

## SYNOPSIS
Search the Delinea Platform directories for groups

## SYNTAX

```
Search-TssPlatformGroup [-TssSession] <Session> -SearchText <String>
 [<CommonParameters>]
```

## DESCRIPTION
Searches the directories of the Delinea Platform for groups, using the Platform credentials of the integration.
Use the results with New-TssPlatformGroup to link a group.
When the Platform reports a problem the message is written as a warning.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssPlatformGroup -TssSession $session -SearchText 'Admin'
```

Returns the Platform groups whose name starts with Admin

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssPlatformGroup -TssSession $session -SearchText 'Vault Admins'
```

Returns the Vault Admins group and any other group whose name starts with Vault Admins

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

### -SearchText
Start of the group name.
The Platform matches names that start with this text, case-sensitive; * is not a wildcard, so 'Admin' finds Administrators but 'admin' and 'Admin*' do not

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

### Thycotic.PowerShell.Platform.Group[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Search-TssPlatformGroup](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Search-TssPlatformGroup)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Search-TssPlatformGroup.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Search-TssPlatformGroup.ps1)
