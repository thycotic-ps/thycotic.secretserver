---
title: Find-TssApplicationAccount
parent: Application Accounts
grand_parent: Commands
---
# Find-TssApplicationAccount

## SYNOPSIS
Find application accounts by name

## SYNTAX

```
Find-TssApplicationAccount [-TssSession] <Session> [-IncludeAll] [-IncludeInactive] [-SearchText <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the ID and name of each application account (a user flagged as an application account), filtered by search text.
Only active application accounts are returned unless -IncludeInactive or -IncludeAll is used.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Find-TssApplicationAccount -TssSession $session -SearchText svc
```

Returns the active application accounts whose name contains svc

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Find-TssApplicationAccount -TssSession $session -IncludeAll
```

Returns every application account, active and inactive

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

### -IncludeAll
Include all application accounts, active and inactive

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

### -IncludeInactive
Include inactive application accounts

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

### -SearchText
Text to match against the application account name

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Folders.Lookup[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/application-accounts/Find-TssApplicationAccount](https://thycotic-ps.github.io/thycotic.secretserver/commands/application-accounts/Find-TssApplicationAccount)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/application-accounts/Find-TssApplicationAccount.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/application-accounts/Find-TssApplicationAccount.ps1)
