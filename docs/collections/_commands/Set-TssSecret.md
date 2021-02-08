---
category: secrets
external help file: Thycotic.SecretServer-help.xml
Module Name: Thycotic.SecretServer
online version: https://thycotic-ps.github.io/thycotic.secretserver/commands/Set-TssSecret
schema: 2.0.0
title: Set-TssSecret
---

# Set-TssSecret

## SYNOPSIS
Set a value for a given secret in Secret Server

## SYNTAX

### all (Default)
```
Set-TssSecret [-TssSession] <TssSession> -Id <Int32[]> [-Comment <String>] [-Field <String>] [-Value <String>]
 [-Clear] [-EmailWhenChanged] [-EmailWhenViewed] [-EmailWhenHeartbeatFails] [-Active]
 [-EnableInheritSecretPolicy] [-Folder <Int32>] [-GenerateSshKeys] [-HeartbeatEnabled] [-IsOutOfSync]
 [-SecretName <String>] [-SecretPolicy <Int32>] [-Site <Int32>] [-Template <Int32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### field
```
Set-TssSecret [-TssSession] <TssSession> -Id <Int32[]> [-Comment <String>] -Field <String> [-Value <String>]
 [-Clear] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### email
```
Set-TssSecret [-TssSession] <TssSession> -Id <Int32[]> [-Comment <String>] [-EmailWhenChanged]
 [-EmailWhenViewed] [-EmailWhenHeartbeatFails] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### general
```
Set-TssSecret [-TssSession] <TssSession> -Id <Int32[]> [-Comment <String>] [-Active]
 [-EnableInheritSecretPolicy] [-Folder <Int32>] [-GenerateSshKeys] [-HeartbeatEnabled] [-IsOutOfSync]
 [-SecretName <String>] [-SecretPolicy <Int32>] [-Site <Int32>] [-Template <Int32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Sets a secret property or field in Secret Server.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecret -TssSession $session -Id 93 -Field Machine -Value "server2"
```

Sets secret 93's field, "Machine", to "server2"

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecret -TssSession $session -Id 1455 -Field Notes -Value "to be decommissioned" -Comment "updating notes field"
```

Sets secret 1455's field, "Notes", to the provided value providing required comment

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecret -TssSession $session -Id 113 -Field Notes -Clear
```

Sets secret 1455's field, "Notes", to an empty value

### EXAMPLE 4
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecret -TssSession $session -Id 113 -EmailWhenViewed
```

Sets secret 1455 email when viewed setting to true

### EXAMPLE 5
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssSecret -TssSession $session -Id 113 -EmailWhenChanged:$false
```

Sets secret 1455 disables emailing when changed

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
Secret Id to modify

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

### -Comment
Comment to provide for restricted secret (Require Comment is enabled)

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

### -Field
Field name (slug) of the secret

```yaml
Type: String
Parameter Sets: all
Aliases: FieldName

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: field
Aliases: FieldName

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
Parameter Sets: all, field
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
Parameter Sets: all, field
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EmailWhenChanged
Email when changed to true

```yaml
Type: SwitchParameter
Parameter Sets: all, email
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EmailWhenViewed
Email when viewed to true

```yaml
Type: SwitchParameter
Parameter Sets: all, email
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EmailWhenHeartbeatFails
Email when HB fails to true

```yaml
Type: SwitchParameter
Parameter Sets: all, email
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Active
Set the secret active secret is active

```yaml
Type: SwitchParameter
Parameter Sets: all, general
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableInheritSecretPolicy
Whether Secret Policy is inherited from containing folder

```yaml
Type: SwitchParameter
Parameter Sets: all, general
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Folder
Folder (ID)

```yaml
Type: Int32
Parameter Sets: all, general
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -GenerateSshKeys
Generate new SSH Keys

```yaml
Type: SwitchParameter
Parameter Sets: all, general
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -HeartbeatEnabled
Heartbeat enabled

```yaml
Type: SwitchParameter
Parameter Sets: all, general
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsOutOfSync
Secret out of sync

```yaml
Type: SwitchParameter
Parameter Sets: all, general
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretName
Secret name

```yaml
Type: String
Parameter Sets: all, general
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretPolicy
Secret Policy (ID)

```yaml
Type: Int32
Parameter Sets: all, general
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Site
Secret Site

```yaml
Type: Int32
Parameter Sets: all, general
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Template
Secret Template (ID)

```yaml
Type: Int32
Parameter Sets: all, general
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/Set-TssSecret](https://thycotic-ps.github.io/thycotic.secretserver/commands/Set-TssSecret)

