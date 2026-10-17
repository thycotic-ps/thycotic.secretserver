---
title: New-TssPasswordType
parent: Remote Password Changing
grand_parent: Commands
---
# New-TssPasswordType

## SYNOPSIS
Create a custom password type

## SYNTAX

```
New-TssPasswordType [-TssSession] <Session> -Name <String> [-BasePasswordTypeId <Int32>] [-TypeName <String>]
 [-PasswordTypeField <Object[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a custom password type as a copy of an editable base password type (CanEdit True, for example Unix Account Custom (SSH); see Search-TssRpcPasswordType).
Built-in password types that are not editable cannot be used as the base.
When -BasePasswordTypeId is omitted, the server looks up the base from -TypeName and -PasswordTypeField.
Returns the new password type, including its PasswordTypeId.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssPasswordType -TssSession $session -BasePasswordTypeId 9 -Name 'Unix Account Custom (SSH) - Jump hosts'
```

Create a password type that starts as a copy of password type 9

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssRpcPasswordType -TssSession $session -Id 9 | New-TssPasswordType -TssSession $session -Name 'Unix Account Custom (SSH) - Jump hosts'
```

Create the same copy from the output of Get-TssRpcPasswordType

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

### -Name
Name of the new password type

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

### -BasePasswordTypeId
ID of the editable password type to copy

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: PasswordTypeId

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TypeName
Password changer type name used to look up the base when -BasePasswordTypeId is omitted, for example Thycotic.ihawu.Business.Federator.UnixSshCustomAccountFederator

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

### -PasswordTypeField
Password type fields used to look up the base when -BasePasswordTypeId is omitted: objects or hashtables with name and scanItemFieldId

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
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

### Thycotic.PowerShell.Rpc.PasswordType
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/New-TssPasswordType](https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/New-TssPasswordType)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/New-TssPasswordType.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/New-TssPasswordType.ps1)
