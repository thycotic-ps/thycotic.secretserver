---
title: Search-TssDependencyScanField
parent: Dependency Changers
grand_parent: Commands
---
# Search-TssDependencyScanField

## SYNOPSIS
List the scan fields of a discovery scan template

## SYNTAX

```
Search-TssDependencyScanField [-TssSession] <Session> -ScanTemplateId <Int32>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the fields of a discovery scan template that dependency changers can match on.
The server requires a scan template ID and returns HTTP 500 without one.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDependencyScanField -TssSession $session -ScanTemplateId 11
```

List the scan fields of scan template 11

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDependencyChanger -TssSession $session -Id 1 | Search-TssDependencyScanField -TssSession $session
```

List the scan fields of the scan template that dependency changer 1 uses

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

### -ScanTemplateId
Discovery scan template ID (ScanItemTemplateId on a dependency changer)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: ScanItemTemplateId

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

### Thycotic.PowerShell.DependencyChangers.ScanField[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/dependency-changers/Search-TssDependencyScanField](https://thycotic-ps.github.io/thycotic.secretserver/commands/dependency-changers/Search-TssDependencyScanField)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dependency-changers/Search-TssDependencyScanField.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dependency-changers/Search-TssDependencyScanField.ps1)
