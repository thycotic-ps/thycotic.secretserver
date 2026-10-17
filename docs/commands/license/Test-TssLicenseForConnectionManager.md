---
title: Test-TssLicenseForConnectionManager
parent: License
grand_parent: Commands
---
# Test-TssLicenseForConnectionManager

## SYNOPSIS
Test whether the Secret Server license covers Connection Manager

## SYNTAX

```
Test-TssLicenseForConnectionManager [-TssSession] <Session>
 [<CommonParameters>]
```

## DESCRIPTION
Checks whether the Secret Server license allows Connection Manager and returns IsLicensed, IsTrial and LicenseEndDate.
On-premises, IsLicensed is True when a valid Connection Manager subscription or evaluation key is installed.
On Secret Server Cloud it follows the tenant subscription and IsTrial is always False.
LicenseEndDate can be empty.
Any signed-in user can call it; no role permission is required.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Test-TssLicenseForConnectionManager -TssSession $session
```

Returns IsLicensed, IsTrial and LicenseEndDate for Connection Manager

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
if (-not (Test-TssLicenseForConnectionManager -TssSession $session).IsLicensed) { Write-Warning 'Connection Manager is not licensed' }
```

Warns when the license does not cover Connection Manager

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

### Thycotic.PowerShell.License.ValidLicense
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/license/Test-TssLicenseForConnectionManager](https://thycotic-ps.github.io/thycotic.secretserver/commands/license/Test-TssLicenseForConnectionManager)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/license/Test-TssLicenseForConnectionManager.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/license/Test-TssLicenseForConnectionManager.ps1)
