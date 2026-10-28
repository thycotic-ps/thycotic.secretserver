---
title: Get-TssDiscoverySecretTemplate
parent: Discovery
grand_parent: Commands
---
# Get-TssDiscoverySecretTemplate

## SYNOPSIS
Get the secret templates a discovery rule can use for a scan template

## SYNTAX

```
Get-TssDiscoverySecretTemplate [-TssSession] <Session> -Id <Int32[]>
 [<CommonParameters>]
```

## DESCRIPTION
Lists the secret templates that are compatible with a discovery scan template, for use in discovery rules.
Returns nothing when no secret template is compatible.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssDiscoverySecretTemplate -TssSession $session -Id 6
```

List the secret templates compatible with scan template 6

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
Scan template ID

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

### Thycotic.PowerShell.Folders.DetailTemplateView[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoverySecretTemplate](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoverySecretTemplate)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoverySecretTemplate.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoverySecretTemplate.ps1)
