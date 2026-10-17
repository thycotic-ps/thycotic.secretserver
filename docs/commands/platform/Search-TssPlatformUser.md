---
title: Search-TssPlatformUser
parent: Platform
grand_parent: Commands
---
# Search-TssPlatformUser

## SYNOPSIS
Search the Delinea Platform users

## SYNTAX

```
Search-TssPlatformUser [-TssSession] <Session> [-IsDomainUser] [-SearchText <String>]
 [<CommonParameters>]
```

## DESCRIPTION
List the Delinea Platform users known to this Secret Server, with their directory service and membership type.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssPlatformUser -TssSession $session -SearchText 'adm'
```

Find Platform users whose name starts with adm

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

### -IsDomainUser
Return domain users only

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

### -SearchText
Start of the name.
The Platform matches names that start with this text; * is not a wildcard, so 'adm' finds admin but 'adm*' does not

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Platform.User[]
## NOTES
Requires TssSession object returned by New-TssSession

Requires Platform integration: a Secret Server without it answers with an error.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Search-TssPlatformUser](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Search-TssPlatformUser)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Search-TssPlatformUser.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Search-TssPlatformUser.ps1)
