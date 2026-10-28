---
title: Search-TssPlatformSsDomain
parent: Platform Integration
grand_parent: Commands
---
# Search-TssPlatformSsDomain

## SYNOPSIS
Search the Secret Server domains for Platform integration

## SYNTAX

```
Search-TssPlatformSsDomain [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
List the Active Directory and Azure AD domains of this Secret Server as Platform data integration sees them, with the engine hosts of each domain.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssPlatformSsDomain -TssSession $session | Where-Object IsAzure -EQ $false
```

List the Active Directory domains

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.PlatformIntegration.SsDomain[]
## NOTES
Requires TssSession object returned by New-TssSession

Requires Platform integration: a Secret Server without it answers 500 API_PlatformNotEnabled.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-integration/Search-TssPlatformSsDomain](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-integration/Search-TssPlatformSsDomain)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-integration/Search-TssPlatformSsDomain.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-integration/Search-TssPlatformSsDomain.ps1)
