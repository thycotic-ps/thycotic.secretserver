# Get-TssSecretAttachment

## SYNOPSIS
Get a Secret attachment

## SYNTAX

### id
```
Get-TssSecretAttachment [-TssSession] <Session> -Id <Int32[]> -Slug <String> [-NoAutoCheckout]
 [-Comment <String>] [-ForceCheckIn] [-TicketNumber <String>] [-TicketSystemId <Int32>] [<CommonParameters>]
```

### path
```
Get-TssSecretAttachment [-TssSession] <Session> -Slug <String> -Path <String> [-NoAutoCheckout]
 [-Comment <String>] [-ForceCheckIn] [-TicketNumber <String>] [-TicketSystemId <Int32>] [<CommonParameters>]
```

### restricted
```
Get-TssSecretAttachment [-TssSession] <Session> -Slug <String> [-Comment <String>] [-ForceCheckIn]
 [-TicketNumber <String>] [-TicketSystemId <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Get a Secret attachment with the filename in order to write it out to disk.
Combining the use of two public functions to write the attachment out to the given filename in the Secret.
The filename of an attachment is in Get-TssSecret output (items)
The content of the file is in Get-TssSecretField.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretAttachment -TssSession $session -Id 35 -Slug attached-file -Path 'c:\thycotic'
```

Get the Secert ID 35's field Attached File (using slug name attached-file), writing the file to c:\thycotic directory using the filename stored on that Secret

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
Secret ID

```yaml
Type: Int32[]
Parameter Sets: id
Aliases: SecretId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Slug
Field name

```yaml
Type: String
Parameter Sets: (All)
Aliases: FieldName

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path
Write contents to a file (for file attachments and SSH public/private keys)

```yaml
Type: String
Parameter Sets: path
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoAutoCheckout
Don't check out the secret automatically (added in 11.0+)

```yaml
Type: SwitchParameter
Parameter Sets: id, path
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
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

### -ForceCheckIn
Check in the secret if it is checked out

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

### -TicketNumber
Associated ticket number (required for ticket integrations)

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

### -TicketSystemId
Associated ticket system ID (required for ticket integrations)

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretAttachment](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretAttachment)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretAttachment.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretAttachment.ps1)

