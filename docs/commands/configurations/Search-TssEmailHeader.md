---
title: Search-TssEmailHeader
parent: Configurations
grand_parent: Commands
---
# Search-TssEmailHeader

## SYNOPSIS
Search custom email message headers

## SYNTAX

```
Search-TssEmailHeader [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Get every custom header Secret Server adds to outgoing email, active and inactive.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssEmailHeader -TssSession $session
```

List the custom email headers

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

### Thycotic.PowerShell.Configuration.EmailHeader[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Search-TssEmailHeader](https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Search-TssEmailHeader)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Search-TssEmailHeader.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Search-TssEmailHeader.ps1)
