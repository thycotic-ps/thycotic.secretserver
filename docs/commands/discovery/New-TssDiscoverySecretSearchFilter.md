---
title: New-TssDiscoverySecretSearchFilter
parent: Discovery
grand_parent: Commands
---
# New-TssDiscoverySecretSearchFilter

## SYNOPSIS
Create a discovery secret search filter

## SYNTAX

```
New-TssDiscoverySecretSearchFilter [-TssSession] <Session> -FolderId <Int32> -SecretTypeId <Int32>
 -SecretNameSearchPattern <String> [-IncludeSubfolders] [-AllowPartialMatch] [-ExpectSingle] [-IsActive]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a secret search filter.
Discovery scanners use it to find the secret that holds the credential for a scan by matching secret names in a folder.
The filter is created active and searches subfolders unless -IsActive:$false or -IncludeSubfolders:$false is given.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssDiscoverySecretSearchFilter -TssSession $session -FolderId 12 -SecretTypeId 6003 -SecretNameSearchPattern 'svc-sql' -AllowPartialMatch
```

Create a filter that finds secrets of template 6003 in folder 12 or its subfolders whose name contains svc-sql

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

### -FolderId
ID of the folder to search for matching secrets

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretTypeId
Secret template ID of the secrets to match

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretNameSearchPattern
Secret name to match

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

### -IncludeSubfolders
Also search the subfolders of the folder (default true)

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

### -AllowPartialMatch
Match when the pattern is only part of the secret name

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

### -ExpectSingle
Log a warning when more than one secret matches

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

### -IsActive
Create the filter active (default true)

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

### Thycotic.PowerShell.Discovery.SecretSearchFilter
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/New-TssDiscoverySecretSearchFilter](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/New-TssDiscoverySecretSearchFilter)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/New-TssDiscoverySecretSearchFilter.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/New-TssDiscoverySecretSearchFilter.ps1)
