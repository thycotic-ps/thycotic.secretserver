---
title: Search-TssDependencyChanger
parent: Dependency Changers
grand_parent: Commands
---
# Search-TssDependencyChanger

## SYNOPSIS
List dependency changers

## SYNTAX

```
Search-TssDependencyChanger [-TssSession] <Session> [-DependencyTypeId <Int32>] [-Status <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns dependency changers, active only unless -Status says otherwise.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDependencyChanger -TssSession $session
```

List the active dependency changers

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDependencyChanger -TssSession $session -DependencyTypeId 8 -Status All
```

List every dependency changer of dependency type 8 (SSH Script)

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

### -DependencyTypeId
Only return changers of this dependency type

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: SecretDependencyTypeId

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status
Active (server default), Inactive or All

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

### Thycotic.PowerShell.DependencyChangers.DependencyChangerSummary[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/dependency-changers/Search-TssDependencyChanger](https://thycotic-ps.github.io/thycotic.secretserver/commands/dependency-changers/Search-TssDependencyChanger)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dependency-changers/Search-TssDependencyChanger.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dependency-changers/Search-TssDependencyChanger.ps1)
