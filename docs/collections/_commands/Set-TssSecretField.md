---
category: secrets
external help file: Thycotic.SecretServer-help.xml
Module Name: Thycotic.SecretServer
online version: https://thycotic-ps.github.io/thycotic.secretserver/commands/Set-TssSecretField
schema: 2.0.0
title: Set-TssSecretField
---

# Set-TssSecretField

## SYNOPSIS
Set value for a Secret Field

## SYNTAX

### all (Default)
```
Set-TssSecretField [-TssSession] <TssSession> -Id <Int32[]> -Slug <String> [-Value <String>] [-Clear]
 [-Path <Object>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### restricted
```
Set-TssSecretField [-TssSession] <TssSession> -Id <Int32[]> -Slug <String> [-Value <String>] [-Clear]
 [-Path <Object>] [-Comment <String>] [-ForceCheckIn] [-TicketNumber <Int32>] [-TicketSystemId <Int32>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Set value for a Secret Field

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecretField -TssSession $session Id 42 -Slug notes -Value "Test test test"
```

Set Notes field on Secret 42 to the value "Test test test"

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecret -TssSession $session -Id 93 -Slug Machine -Value "server2"
```

Sets secret 93's field, "Machine", to "server2"

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecret -TssSession $session -Id 1455 -Slug Notes -Value "to be decommissioned" -Comment "updating notes field"
```

Sets secret 1455's field, "Notes", to the provided value providing required comment

### EXAMPLE 4
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecret -TssSession $session -Id 113 -Slug Notes -Clear
```

Sets secret 1455's field, "Notes", to an empty value

### EXAMPLE 5
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecret -TssSession $session -Id 42 -Slug attached-file c:\files\attachment.txt
```

Sets the attached-file field on Secret 42 to the attachment.txt (uploads the file to Secret Server)

## PARAMETERS

### -TssSession
TssSession object created by New-TssSession for auth

```yaml
Type: TssSession
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Id
Folder Id to modify

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: SecretId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Slug
Field name (slug) of the secret

```yaml
Type: String
Parameter Sets: (All)
Aliases: Field

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value
Value to set for the provided field

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

### -Clear
Clear/blank out the field value

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

### -Path
Path of file to attach

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Comment
Comment to provide for restricted secret (Require Comment is enabled)

```yaml
Type: String
Parameter Sets: restricted
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ForceCheckIn
Force check-in of the Secret

```yaml
Type: SwitchParameter
Parameter Sets: restricted
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -TicketNumber
Associated Ticket Number

```yaml
Type: Int32
Parameter Sets: restricted
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -TicketSystemId
Associated Ticket System ID

```yaml
Type: Int32
Parameter Sets: restricted
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

## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/Set-TssSecretField](https://thycotic-ps.github.io/thycotic.secretserver/commands/Set-TssSecretField)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Set-SecretField.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Set-SecretField.ps1)

