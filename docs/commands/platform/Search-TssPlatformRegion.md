---
title: Search-TssPlatformRegion
parent: Platform
grand_parent: Commands
---
# Search-TssPlatformRegion

## SYNOPSIS
Search the Delinea Platform regions

## SYNTAX

```
Search-TssPlatformRegion [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
List the Delinea Platform regions this Secret Server can be provisioned in.
IsDefault marks the default region of the instance.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssPlatformRegion -TssSession $session | Where-Object IsDefault
```

Show the default Platform region

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

### Thycotic.PowerShell.Platform.Region[]
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server Cloud only: an on-premises Secret Server answers this endpoint with an error.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Search-TssPlatformRegion](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Search-TssPlatformRegion)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Search-TssPlatformRegion.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Search-TssPlatformRegion.ps1)
