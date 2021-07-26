# Close-TssSecret

## SYNOPSIS
Check-In a Secret

## SYNTAX

```
Close-TssSecret [-TssSession] <Session> -Id <Int32[]> [-Comment <String>] [-ForceCheckIn]
 [-TicketNumber <Int32>] [-TicketSystemId <Int32>] [-IncludeInactive] [<CommonParameters>]
```

## DESCRIPTION
Check-In a Secret

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
CheckIn-TssSecret -TssSession $session -Id 86
```

Check-In Secret 86

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
CheckIn-TssSecret -TssSession $session -Id 98 -ForceCheckIn
```

Check-In Secret 98 applying ForceCheckIn

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$secret = Get-TssSecret -TssSession $session -Id 42
$scriptCred = $secret.GetCredential()
Close-TssSecret -TssSession $session -Id 42
```

Check-In Secret 42 after using it to get the username/password credential

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
Force check-in of the Secret

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
Associated Ticket Number

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

### -TicketSystemId
Associated Ticket System ID

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

### -IncludeInactive
Whether to include inactive secrets

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Secrets.Summary
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Close-TssSecret](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Close-TssSecret)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Close-TssSecret.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Close-TssSecret.ps1)

