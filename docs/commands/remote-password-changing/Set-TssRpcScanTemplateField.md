---
title: Set-TssRpcScanTemplateField
parent: Remote Password Changing
grand_parent: Commands
---
# Set-TssRpcScanTemplateField

## SYNOPSIS
Map the fields of a password type to the fields of a scan item template

## SYNTAX

```
Set-TssRpcScanTemplateField [-TssSession] <Session> -Id <Int32> -ScanTemplateId <Int32> -Field <Object[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Set the scan item template of a password type and map each password type field to a field of that template.
Each field entry needs PasswordTypeFieldId and ScanItemFieldId; the Fields property of Get-TssRpcPasswordType output has that shape, so read it, change the ScanItemFieldId values you want and pass it back.
A ScanItemFieldId of 0 or null leaves that password type field unmapped.
Fields you do not pass keep their current mapping.
Every required field of the scan item template must stay mapped (see Get-TssRpcScanTemplate).
The output is the updated password type.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssRpcScanTemplateField -TssSession $session -Id 9 -ScanTemplateId 10 -Field @{ PasswordTypeFieldId = 21; ScanItemFieldId = 7 }
```

Keep password type 9 on scan item template 10 and map its password type field 21 to scan item field 7

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$passwordType = Get-TssRpcPasswordType -TssSession $session -Id 9
($passwordType.Fields | Where-Object Name -eq 'Machine').ScanItemFieldId = 7
$passwordType | Set-TssRpcScanTemplateField -TssSession $session
```

Read password type 9, remap its Machine field to scan item field 7 and save every mapping back

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
Password type ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: PasswordTypeId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ScanTemplateId
Scan item template ID the password type uses (Get-TssRpcScanTemplate)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: ScanItemTemplateId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Field
Field mappings: objects or hashtables with PasswordTypeFieldId and ScanItemFieldId, for example the Fields property of Get-TssRpcPasswordType output

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases: Fields

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Set-TssRpcScanTemplateField](https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Set-TssRpcScanTemplateField)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Set-TssRpcScanTemplateField.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Set-TssRpcScanTemplateField.ps1)
