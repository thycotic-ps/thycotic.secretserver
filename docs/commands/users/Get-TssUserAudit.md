# Get-TssUserAudit

## SYNOPSIS
Get audit for a user

## SYNTAX

```
Get-TssUserAudit [-TssSession] <Session> -UserId <Int32[]> [<CommonParameters>]
```

## DESCRIPTION
Get audit for a Secret Server User

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssUserAudit -TssSession $session -UserId 2
```

Get all of the audits for UserId 2

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

### -UserId
Secret ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: Id

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

### Thycotic.PowerShell.Users.AuditSummary
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Get-TssUserAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Get-TssUserAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-TssUserAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-TssUserAudit.ps1)

