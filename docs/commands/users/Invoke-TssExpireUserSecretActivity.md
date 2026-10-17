---
title: Invoke-TssExpireUserSecretActivity
parent: Users
grand_parent: Commands
---
# Invoke-TssExpireUserSecretActivity

## SYNOPSIS
Expire the secrets a user has accessed

## SYNTAX

```
Invoke-TssExpireUserSecretActivity [-TssSession] <Session> -Id <Int32[]> -StartDate <DateTime>
 [-EndDate <DateTime>] [-FolderId <Int32>] [-IncludeSubfolders] [-ExcludeInactiveSecrets]
 [-ExcludeRotatedSecrets] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Expires every secret the user accessed that matches the filter, so each one is due for a password change.
The expiration runs as a bulk operation; the result carries its bulk operation ID.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Invoke-TssExpireUserSecretActivity -TssSession $session -Id 12 -StartDate (Get-Date).AddDays(-30)
```

Expires every secret user 12 accessed in the last 30 days

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Invoke-TssExpireUserSecretActivity -TssSession $session -Id 12 -StartDate (Get-Date).AddDays(-90) -FolderId 7 -IncludeSubfolders -ExcludeRotatedSecrets -WhatIf
```

Shows the request that would expire the secrets user 12 accessed under folder 7 in the last 90 days, skipping secrets that rotate automatically

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
ID of the user whose accessed secrets are expired

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: UserId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -StartDate
Only secrets accessed on or after this date (required: without it the server fails with a SQL date overflow)

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EndDate
Only secrets accessed before this date

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FolderId
Only secrets in this folder

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
With -FolderId, also secrets in its subfolders

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

### -ExcludeInactiveSecrets
Skip inactive secrets

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

### -ExcludeRotatedSecrets
Skip secrets whose passwords rotate automatically

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

### Thycotic.PowerShell.Users.SecretActivityExpireResult
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Invoke-TssExpireUserSecretActivity](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Invoke-TssExpireUserSecretActivity)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Invoke-TssExpireUserSecretActivity.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Invoke-TssExpireUserSecretActivity.ps1)
