---
category: secrets
external help file: Thycotic.SecretServer-help.xml
Module Name: Thycotic.SecretServer
online version: https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssSecretField
schema: 2.0.0
title: Get-TssSecretField
---

# Get-TssSecretField

## SYNOPSIS
Get data of a field

## SYNTAX

### field (Default)
```
Get-TssSecretField [-TssSession] <TssSession> -Id <Int32[]> -Slug <String> [-OutFile <FileInfo>]
 [<CommonParameters>]
```

### restricted
```
Get-TssSecretField [-TssSession] <TssSession> -Id <Int32[]> -Slug <String> [-OutFile <FileInfo>]
 [-Comment <String>] [-DoublelockPassword <SecureString>] [-ForceCheckIn] [-IncludeInactive]
 [-TicketNumber <String>] [-TicketSystemId <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Get data from a given secret field

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
PS C:\> Get-TssSecretField -TssSession $session -Id 14 -Slug username
```

Get the username value of secret ID 14

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
Secret ID to retrieve

```yaml
Type: Int32[]
Parameter Sets: field
Aliases: SecretId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

```yaml
Type: Int32[]
Parameter Sets: restricted
Aliases: SecretId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Slug
Secret ID to retrieve

```yaml
Type: String
Parameter Sets: field
Aliases: FieldName

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: restricted
Aliases: FieldName

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -OutFile
Write contents to a file (for file attachments and SSH public/private keys)

```yaml
Type: FileInfo
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

### -DoublelockPassword
Double lock password, provie as a secure string

```yaml
Type: SecureString
Parameter Sets: restricted
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ForceCheckIn
Check in the secret if it is checked out

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

### -IncludeInactive
Include secrets that are inactive/disabled

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
Associated ticket number (required for ticket integrations)

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

### -TicketSystemId
Associated ticket system ID (required for ticket integrations)

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssSecretField](https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssSecretField)

