---
title: Get-TssUserSecretActivity
parent: Users
grand_parent: Commands
---
# Get-TssUserSecretActivity

## SYNOPSIS
Get the secrets a user has accessed

## SYNTAX

```
Get-TssUserSecretActivity [-TssSession] <Session> -Id <Int32[]> [-EndDate <DateTime>] [-ExcludeInactiveSecrets]
 [-ExcludeRotatedSecrets] [-FolderId <Int32>] [-IncludeSubfolders] -StartDate <DateTime>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the secrets a user accessed, with the last access date and IP address, filtered by date range and folder.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssUserSecretActivity -TssSession $session -Id 12 -StartDate (Get-Date).AddDays(-30)
```

Returns the secrets user 12 accessed in the last 30 days

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssUserSecretActivity -TssSession $session -Id 12 -StartDate (Get-Date).AddDays(-90) -FolderId 7 -IncludeSubfolders
```

Returns the secrets user 12 accessed under folder 7 and its subfolders in the last 90 days

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
User ID

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Users.SecretActivity[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Get-TssUserSecretActivity](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Get-TssUserSecretActivity)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-TssUserSecretActivity.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-TssUserSecretActivity.ps1)
