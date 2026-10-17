---
title: Get-TssUserPreference
parent: Users
grand_parent: Commands
---
# Get-TssUserPreference

## SYNOPSIS
Get a stored preference of the current user

## SYNTAX

```
Get-TssUserPreference [-TssSession] <Session> [-IsLegacy] -SettingCode <String> [-SettingName <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Gets one stored UI preference of the current user by setting code, narrowed by setting name for named preferences.
Without -SettingName only the unnamed preference of the setting code is returned.
A preference the user has not set returns an empty record (UserSettingId 0).

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssUserPreference -TssSession $session -SettingCode favoriteFolders
```

Returns the favorite folders preference of the current user

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssUserPreference -TssSession $session -SettingCode LastSearchString -SettingName serverSearch
```

Returns the preference stored under setting code LastSearchString with setting name serverSearch

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

### -IsLegacy
Read the preference from the legacy setting store

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

### -SettingCode
Setting code of the preference, for example favoriteFolders

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

### -SettingName
Setting name of a named preference, sent with its setting code

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

### Thycotic.PowerShell.Users.Preference
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Get-TssUserPreference](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Get-TssUserPreference)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-TssUserPreference.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-TssUserPreference.ps1)
