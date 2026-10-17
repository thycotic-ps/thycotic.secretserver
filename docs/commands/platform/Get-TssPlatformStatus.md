---
title: Get-TssPlatformStatus
parent: Platform
grand_parent: Commands
---
# Get-TssPlatformStatus

## SYNOPSIS
Get the status of a Delinea Platform tenant

## SYNTAX

```
Get-TssPlatformStatus [-TssSession] <Session> -Hostname <String[]>
 [<CommonParameters>]
```

## DESCRIPTION
Ask the Delinea Platform about a tenant host name and get its tenant id.
Secret Server calls the Platform for each host name.
An empty TenantId means no tenant has the host name: the Platform reports TenantExists True for any name it does not answer as not found, so check TenantId, not TenantExists.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPlatformStatus -TssSession $session -Hostname contoso.delinea.app | Select-Object TenantId
```

Get the tenant id of the contoso Platform tenant; an empty TenantId means no tenant has that host name

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

### -Hostname
Platform tenant host name to check

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

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

### Thycotic.PowerShell.Platform.TenantStatus
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server Cloud only: an on-premises Secret Server answers this endpoint with an error.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Get-TssPlatformStatus](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Get-TssPlatformStatus)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Get-TssPlatformStatus.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Get-TssPlatformStatus.ps1)
