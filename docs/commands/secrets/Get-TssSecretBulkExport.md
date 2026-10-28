---
title: Get-TssSecretBulkExport
parent: Secrets
grand_parent: Commands
---
# Get-TssSecretBulkExport

## SYNOPSIS
Get a bulk secret export job

## SYNTAX

### Default (Default)
```
Get-TssSecretBulkExport [-TssSession] <Session> -Id <String[]>
 [<CommonParameters>]
```

### Status
```
Get-TssSecretBulkExport [-TssSession] <Session> -Id <String[]> [-Status]
 [<CommonParameters>]
```

### Detail
```
Get-TssSecretBulkExport [-TssSession] <Session> -Id <String[]> [-Detail]
 [<CommonParameters>]
```

## DESCRIPTION
Reads an export job started by Export-TssSecretBulk -Job.
By default it returns the exported file text in ExportedSecretsFileText.
-Status returns the job status (Pending, Completed or Failed); -Detail returns the secret count and any errors.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretBulkExport -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' -Status
```

Returns the status of the export job

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
(Get-TssSecretBulkExport -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e').ExportedSecretsFileText | Set-Content -Path ./secrets.xml
```

Saves the file of a completed export job

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
Export job ID returned by Export-TssSecretBulk -Job

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: ExportJobId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Status
Return the status of the export job (GET api/v2/secrets/export/job/{jobId})

```yaml
Type: SwitchParameter
Parameter Sets: Status
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Detail
Return the secret count and errors of the export job (GET api/v2/secrets/export/{jobId}/details)

```yaml
Type: SwitchParameter
Parameter Sets: Detail
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Secrets.BulkExport
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretBulkExport](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretBulkExport)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretBulkExport.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretBulkExport.ps1)
