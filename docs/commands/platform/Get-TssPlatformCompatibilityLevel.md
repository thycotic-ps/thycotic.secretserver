---
title: Get-TssPlatformCompatibilityLevel
parent: Platform
grand_parent: Commands
---
# Get-TssPlatformCompatibilityLevel

## SYNOPSIS
Get the Delinea Platform integration compatibility level

## SYNTAX

```
Get-TssPlatformCompatibilityLevel [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the Delinea Platform integration compatibility level of the Secret Server instance as a version (Major, Minor, Build, Revision).
The endpoint allows anonymous access, so it answers for every session type, including a session to an instance that is not connected to the Platform.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPlatformCompatibilityLevel -TssSession $session
```

Returns the compatibility level the Secret Server instance reports for Delinea Platform integration

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://vault.secretservercloud.com -AccessToken $platformToken
$level = Get-TssPlatformCompatibilityLevel -TssSession $session
'{0}.{1}' -f $level.Major, $level.Minor
```

Uses a Delinea Platform access token and shows the major and minor compatibility level of the vault

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

### Thycotic.PowerShell.Platform.CompatibilityLevel
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Get-TssPlatformCompatibilityLevel](https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Get-TssPlatformCompatibilityLevel)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Get-TssPlatformCompatibilityLevel.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Get-TssPlatformCompatibilityLevel.ps1)
