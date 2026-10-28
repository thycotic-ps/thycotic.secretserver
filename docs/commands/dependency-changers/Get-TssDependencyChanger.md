---
title: Get-TssDependencyChanger
parent: Dependency Changers
grand_parent: Commands
---
# Get-TssDependencyChanger

## SYNOPSIS
Get a dependency changer

## SYNTAX

```
Get-TssDependencyChanger [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns a dependency changer with its settings and its password change, verification, success and fail scripts.
Script credentials (Username, Password, Key, Passphrase) are token placeholders when UseTokens is true; otherwise they are the values stored on the changer, returned as is.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDependencyChanger -TssSession $session -Id 7
```

Get dependency changer 7

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDependencyChanger -TssSession $session -Status All | Get-TssDependencyChanger -TssSession $session
```

Get every dependency changer, active or not, in full

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
Dependency changer ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SecretDependencyChangerId

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

### Thycotic.PowerShell.DependencyChangers.DependencyChanger
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/dependency-changers/Get-TssDependencyChanger](https://thycotic-ps.github.io/thycotic.secretserver/commands/dependency-changers/Get-TssDependencyChanger)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dependency-changers/Get-TssDependencyChanger.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dependency-changers/Get-TssDependencyChanger.ps1)
