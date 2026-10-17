---
title: Get-TssPbaImportStatus
parent: Pba Configuration
grand_parent: Commands
---
# Get-TssPbaImportStatus

## SYNOPSIS
Get the Privilege Behavior Analytics (PBA) historical import status

## SYNTAX

```
Get-TssPbaImportStatus [-TssSession] <Session> [<CommonParameters>]
```

## DESCRIPTION
Returns the total number of historical events and how many are not yet processed into PBA.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssPbaImportStatus -TssSession $session
```

Returns the historical event counts

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

### Thycotic.PowerShell.PbaConfiguration.ImportStatus
## NOTES
Requires TssSession object returned by New-TssSession

Requires the View or Administer Security Analytics permission and a Privilege Behavior Analytics license; otherwise the server returns 403.

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/pba-configuration/Get-TssPbaImportStatus](https://thycotic-ps.github.io/thycotic.secretserver/commands/pba-configuration/Get-TssPbaImportStatus)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/pba-configuration/Get-TssPbaImportStatus.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/pba-configuration/Get-TssPbaImportStatus.ps1)
