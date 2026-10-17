---
title: Invoke-TssPlatformProvision
parent: Platform
grand_parent: Commands
---
# Invoke-TssPlatformProvision

## SYNOPSIS
Provision a Delinea Platform tenant for this Secret Server

## SYNTAX

```
Invoke-TssPlatformProvision [-TssSession] <Session> -AdminEmail <String> -AdminUsername <String>
 [-IsPlatformRegionEditable] [-OptIn] -PlatformRegion <String> -TenantName <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
One-time opt-in call that starts provisioning a Delinea Platform tenant and connects it to this Secret Server Cloud instance.
The Delinea UI is the recommended path; this cmdlet sends the same request.
The server rejects the request unless -OptIn is passed, every required value is set and the region is one of Search-TssPlatformRegion; it also refuses a second request within an hour.
Returns the provisioning status, which can include a one-time Platform login URL: treat it as a credential.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$region = Search-TssPlatformRegion -TssSession $session | Where-Object IsDefault
Invoke-TssPlatformProvision -TssSession $session -OptIn -TenantName contoso -AdminUsername platformadmin -AdminEmail platformadmin@contoso.com -PlatformRegion $region.Id
```

Provision a Platform tenant in the default region of the instance

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

### -AdminEmail
Email address of the initial Platform administrator

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AdminUsername
User name of the initial Platform administrator

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsPlatformRegionEditable
Mark the region as chosen by the user; without it the server uses the default region of the instance

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -OptIn
Acknowledge that provisioning is a one-time opt-in; the server refuses the request without it

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: OptinToPlatformAcknowledgement

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PlatformRegion
Id (GUID) of the Platform region, from Search-TssPlatformRegion

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TenantName
Host name for the new Platform tenant

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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

### Thycotic.PowerShell.Platform.ProvisionStatus
## NOTES
Requires TssSession object returned by New-TssSession

Secret Server Cloud only: an on-premises Secret Server answers this endpoint with an error.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Invoke-TssPlatformProvision](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Invoke-TssPlatformProvision)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Invoke-TssPlatformProvision.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Invoke-TssPlatformProvision.ps1)
