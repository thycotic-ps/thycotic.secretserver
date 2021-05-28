---
category: groups
external help file: Thycotic.SecretServer-help.xml
Module Name: Thycotic.SecretServer
online version: https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssGroupRole
schema: 2.0.0
title: Get-TssGroupRole
---

# Get-TssGroupRole

## SYNOPSIS
Get roles assigned to a Group

## SYNTAX

```
Get-TssGroupRole [-TssSession] <TssSession> -Id <Int32[]> [<CommonParameters>]
```

## DESCRIPTION
Get roles assigned to a Group

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssGroupRole -TssSession $session -Id 8
```

Return list of roles assigned to Group ID 8

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
Short description for parameter

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: GroupRoleId

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

### TssRoleSummary
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssGroupRole](https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssGroupRole)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/<folder>/Get-GroupRole.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/<folder>/Get-GroupRole.ps1)

