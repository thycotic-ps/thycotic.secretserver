---
title: Set-TssDiscoverySecretSearchFilter
parent: Discovery
grand_parent: Commands
---
# Set-TssDiscoverySecretSearchFilter

## SYNOPSIS
Update a discovery secret search filter

## SYNTAX

```
Set-TssDiscoverySecretSearchFilter [-TssSession] <Session> -Id <Int32> [-AllowPartialMatch] [-ExpectSingle]
 [-FolderId <Int32>] [-IncludeSubfolders] [-IsActive] [-SecretNameSearchPattern <String>]
 [-SecretTypeId <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a discovery secret search filter.
Only the parameters given are changed.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDiscoverySecretSearchFilter -TssSession $session -Id 4 -IsActive:$false
```

Make secret search filter 4 inactive

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssDiscoverySecretSearchFilter -TssSession $session -Id 4 -SecretNameSearchPattern 'svc-sql' -AllowPartialMatch
```

Match secret names containing svc-sql

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
Secret search filter ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: SecretSearchFilterId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
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

### -FolderId
ID of the folder to search

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeSubfolders
Also search the subfolders of the folder

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
Make the filter active, or inactive with -IsActive:$false

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

### -SecretNameSearchPattern
Secret name to match

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretTypeId
Secret template ID of the secrets to match

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoverySecretSearchFilter](https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoverySecretSearchFilter)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoverySecretSearchFilter.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoverySecretSearchFilter.ps1)
