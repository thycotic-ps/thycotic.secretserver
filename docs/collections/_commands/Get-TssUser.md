---
category: general
external help file: Thycotic.SecretServer-help.xml
Module Name: Thycotic.SecretServer
online version: https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssUser
schema: 2.0.0
title: Get-TssUser
---

# Get-TssUser

## SYNOPSIS
Get a Secret Server User

## SYNTAX

```
Get-TssUser [-TssSession] <TssSession> -Id <Int32[]> [-IncludeInactive] [<CommonParameters>]
```

## DESCRIPTION
Get a Secret Server User

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
PS> Get-TssUser -TssSession $session -Id 2
```

Get the User ID 2

## PARAMETERS

### -TssSession
TssSession object created by New-TssSession for auth

```yaml
Type: TssSession
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Id
User ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: UserId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IncludeInactive
Include inactive users in results

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### TssUser
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssUser](https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssUser)

