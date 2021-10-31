# Get-TssSecret

## SYNOPSIS
Get a secret from Secret Server

## SYNTAX

### id
```
Get-TssSecret [-TssSession] <Session> -Id <Int32[]> [-NoAutoCheckout] [-Comment <String>]
 [-DoublelockPassword <SecureString>] [-ForceCheckIn] [-IncludeInactive] [-TicketNumber <String>]
 [-TicketSystemId <Int32>] [<CommonParameters>]
```

### path
```
Get-TssSecret [-TssSession] <Session> -Path <String[]> [-NoAutoCheckout] [-Comment <String>]
 [-DoublelockPassword <SecureString>] [-ForceCheckIn] [-IncludeInactive] [-TicketNumber <String>]
 [-TicketSystemId <Int32>] [<CommonParameters>]
```

### restricted
```
Get-TssSecret [-TssSession] <Session> [-Comment <String>] [-DoublelockPassword <SecureString>] [-ForceCheckIn]
 [-IncludeInactive] [-TicketNumber <String>] [-TicketSystemId <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Get a secret(s) from Secret Server

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecret -TssSession $session -Id 93
```

Returns secret associated with the Secret ID, 93

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecret -TssSession $session -Id 1723 -Comment "Accessing application Y"
```

Returns secret associated with the Secret ID, 1723, providing required comment

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$secret = Get-TssSecret -TssSession $session -Id 46
$cred = $secret.GetCredential('domain','username','password')
```

Gets Secret ID 46 (Active Directory template).
Call GetCredential providing slug names for desired fields to get a PSCredential object

### EXAMPLE 4
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$secret = Search-TssSecret -TssSession $session -FieldSlug server -FieldText 'sql1' | Get-TssSecret
$cred = $secret.GetCredential($null,'username','password')
$serverName = $secret.GetValue('server')
```

Search for the secret with server value of sql1 and pull the secret details.
Call GetCredential() method, only needing the username and password values for the PSCredential object.
Call GetValue() method to get the 'server' value.

### EXAMPLE 5
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecret -TssSession $session -Path '\ABC Company\Vendors\Temp Secret - 32.178.249.171'
```

Get Secret via path.

### EXAMPLE 6
```
$session = nts https://alpha $ssCred
(gts $session 330).GetCredential($null,'username','password')
```

Get PSCredential object for Secret ID 330, using alias for the function names

### EXAMPLE 7
```
$session = nts https://alpha $ssCred
$secret = Get-TssSecret $session 330
$secret.GetFileFields().Foreach({Get-TssSecretField -Id $secret.Id -Slug $_.SlugName})
```

Get the Secert 330, pulling the fields on that Secret that are files and output contents of each file to the console.

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
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Secret ID to retrieve

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

### -Path
Path of Secret to retrieve

```yaml
Type: String[]
Parameter Sets: path
Aliases:

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

### -DoublelockPassword
Double lock password, provie as a secure string

```yaml
Type: SecureString
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

### -IncludeInactive
Include secrets that are inactive/disabled

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

### Thycotic.PowerShell.Secrets.Secret
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecret](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecret)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecret.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecret.ps1)

