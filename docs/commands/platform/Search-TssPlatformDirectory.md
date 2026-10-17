---
title: Search-TssPlatformDirectory
parent: Platform
grand_parent: Commands
---
# Search-TssPlatformDirectory

## SYNOPSIS
Search the directories configured in the Delinea Platform

## SYNTAX

```
Search-TssPlatformDirectory [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the directory services of the Delinea Platform tenant that Secret Server is integrated with, with their display name and status.
Requires Delinea Platform integration on the Secret Server instance.
When the server reports the search as unsuccessful (Platform integration not enabled, access denied, or a user restricted by teams) the cmdlet writes a warning and returns nothing; the server does not say which.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssPlatformDirectory -TssSession $session
```

Returns the Platform directories and their status

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

### Thycotic.PowerShell.Platform.Directory[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Search-TssPlatformDirectory](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Search-TssPlatformDirectory)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Search-TssPlatformDirectory.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Search-TssPlatformDirectory.ps1)
