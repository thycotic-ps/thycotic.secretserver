---
title: Search-TssDependencyChangerScript
parent: Dependency Changers
grand_parent: Commands
---
# Search-TssDependencyChangerScript

## SYNOPSIS
List the scripts a dependency changer can use

## SYNTAX

```
Search-TssDependencyChangerScript [-TssSession] <Session> -DependencyChangerId <Int32>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the scripts that can be bound to the script slots of a dependency changer (password change, verification, success and fail).
The server requires a dependency changer ID and returns HTTP 500 without one.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDependencyChangerScript -TssSession $session -DependencyChangerId 7
```

List the scripts available to dependency changer 7

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

### -DependencyChangerId
Dependency changer ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: SecretDependencyChangerId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.DependencyChangers.Script[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/dependency-changers/Search-TssDependencyChangerScript](https://thycotic-ps.github.io/thycotic.secretserver/commands/dependency-changers/Search-TssDependencyChangerScript)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dependency-changers/Search-TssDependencyChangerScript.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dependency-changers/Search-TssDependencyChangerScript.ps1)
