---
title: Get-TssSshCommandBlocklistPolicy
parent: SSH Command Blocklist
grand_parent: Commands
---
# Get-TssSshCommandBlocklistPolicy

## SYNOPSIS
Get the secret policies that apply an SSH command blocklist

## SYNTAX

```
Get-TssSshCommandBlocklistPolicy [-TssSession] <Session> -SshCommandBlocklistId <String>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the secret policies that apply the SSH command blocklist with the given ID.
Requires the View SSH Menus or Administer SSH Menus role permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSshCommandBlocklistPolicy -TssSession $session -SshCommandBlocklistId 'a3f1c9e2-5b7d-4e8a-9c0f-1d2e3b4a5c6d'
```

Returns the secret policies that apply that blocklist

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssSshCommandBlocklist -TssSession $session -Name 'Production' | Get-TssSshCommandBlocklistPolicy -TssSession $session
```

Returns the secret policies that apply a blocklist with "Production" in the name

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

### -SshCommandBlocklistId
ID (a GUID) of the blocklist whose secret policies are returned

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.SshCommandBlocklist.Policy[]
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-blocklist/Get-TssSshCommandBlocklistPolicy](https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-blocklist/Get-TssSshCommandBlocklistPolicy)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-blocklist/Get-TssSshCommandBlocklistPolicy.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-blocklist/Get-TssSshCommandBlocklistPolicy.ps1)
