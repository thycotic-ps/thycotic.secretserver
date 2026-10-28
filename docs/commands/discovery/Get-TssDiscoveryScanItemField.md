---
title: Get-TssDiscoveryScanItemField
parent: Discovery
grand_parent: Commands
---
# Get-TssDiscoveryScanItemField

## SYNOPSIS
Get the scan item fields of a Discovery scan template

## SYNTAX

```
Get-TssDiscoveryScanItemField [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the fields of a scan template that Discovery rules can filter on.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoveryScanItemField -TssSession $session -Id 6
```

Get the fields of scan template 6

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
Discovery scan template id

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

### Thycotic.PowerShell.Discovery.ScanItemField[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryScanItemField](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryScanItemField)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryScanItemField.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryScanItemField.ps1)
