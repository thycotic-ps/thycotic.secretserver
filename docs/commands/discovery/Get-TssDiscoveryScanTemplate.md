---
title: Get-TssDiscoveryScanTemplate
parent: Discovery
grand_parent: Commands
---
# Get-TssDiscoveryScanTemplate

## SYNOPSIS
Get a Discovery scan template

## SYNTAX

```
Get-TssDiscoveryScanTemplate [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns one or more Discovery scan templates by id, including their fields and parent template.
An id with no matching Discovery scan template writes an error.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoveryScanTemplate -TssSession $session -Id 6
```

Get scan template 6

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssDiscoveryScanTemplate -TssSession $session -SearchText Account | Get-TssDiscoveryScanTemplate -TssSession $session
```

Get the detail of every active scan template whose name contains Account

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
Scan template id

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: ScanTemplateId

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

### Thycotic.PowerShell.Discovery.ScanTemplate
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryScanTemplate](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryScanTemplate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryScanTemplate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryScanTemplate.ps1)
