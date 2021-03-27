---
category: general
external help file: Thycotic.SecretServer-help.xml
Module Name: Thycotic.SecretServer
online version: https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssUserStub
schema: 2.0.0
title: Get-TssUserStub
---

# Get-TssUserStub

## SYNOPSIS
Get user stub object

## SYNTAX

```
Get-TssUserStub [-TssSession] <TssSession> [<CommonParameters>]
```

## DESCRIPTION
Get user stub object to create a new user

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssUserStub -TssSession $session
```

Returns an empty User object

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$newUser = Get-TssUserStub -TssSession $session
$newUser.DisplayName = 'IT Operator - Bob'
$newUser.Username = 'bob'
New-TssUser -TssSession $session -UserStub $newUser -Password (ConvertTo-SecureString 'P@ssword$01' -AsPlainText -Force)
```

Get empty User object, setting required minimum properties for Local User, and creating via New-TssUser

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### TssUser
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssUserStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssUserStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-UserStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-UserStub.ps1)

