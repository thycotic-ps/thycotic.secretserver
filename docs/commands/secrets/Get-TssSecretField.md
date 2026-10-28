---
title: Get-TssSecretField
parent: Secrets
grand_parent: Commands
---
# Get-TssSecretField

## SYNOPSIS
Get data of a field

## SYNTAX

### field (Default)
```
Get-TssSecretField [-TssSession] <Session> -Id <Int32[]> -Slug <String> [-NoAutoCheckout] [-OutFile <FileInfo>]
 [<CommonParameters>]
```

### checkout
```
Get-TssSecretField [-TssSession] <Session> -Id <Int32[]> -Slug <String> [-AutoCheckout] [-AutoCheckIn]
 [-AutoComment <String>] [<CommonParameters>]
```

### restricted
```
Get-TssSecretField [-TssSession] <Session> -Id <Int32[]> -Slug <String> [-NoAutoCheckout] [-OutFile <FileInfo>]
 [-Comment <String>] [-DoublelockPassword <SecureString>] [-ForceCheckIn] [-IncludeInactive]
 [-TicketNumber <String>] [-TicketSystemId <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Get data from a given secret field

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretField -TssSession $session -Id 14 -Slug username
```

Get the username value of secret ID 14, output is in Byte\[\] format

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretField -TssSession $session -Id 432 -Slug json-private-key -OutFile C:\temp\private-key.json
```

Get the private key from Secret 432, writing to the file private-key.json

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretField -TssSession $session -Id 14 -Slug password -AutoCheckout -AutoComment 'Quarterly access review'
```

Get the password of secret ID 14, checking the secret out first when it requires checkout and recording the comment

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
Secret ID to retrieve

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
Secret ID to retrieve

```yaml
Type: String
Parameter Sets: field, checkout
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

### -NoAutoCheckout
Don't check out the secret automatically (added in 11.0+)

```yaml
Type: SwitchParameter
Parameter Sets: field, restricted
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutFile
Write contents to a file (for file attachments and SSH public/private keys)

```yaml
Type: FileInfo
Parameter Sets: field, restricted
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

### -AutoCheckout
Check out the secret automatically when it requires checkout

```yaml
Type: SwitchParameter
Parameter Sets: checkout
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AutoCheckIn
Check the secret back in after the field is read

```yaml
Type: SwitchParameter
Parameter Sets: checkout
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AutoComment
Comment to record with the automatic checkout, for secrets that require a comment

```yaml
Type: String
Parameter Sets: checkout
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

### System.String
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretField](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretField)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretField.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretField.ps1)
