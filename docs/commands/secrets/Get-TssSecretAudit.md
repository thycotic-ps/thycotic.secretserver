# Get-TssSecretAudit

## SYNOPSIS
Get audits for a Secret(s)

## SYNTAX

```
Get-TssSecretAudit [-TssSession] <Session> -Id <Int32[]> [-IncludePasswordChangeLog] [-SortBy <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Get audits for a Secret(s), data is sorted (server-side) in descending order (latest record comes first)

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
PS> Get-TssSecretAudit -TssSession $session -Id 65
```

Get audit for Secret ID 65

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
Parameter Sets: (All)
Aliases: SecretId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IncludePasswordChangeLog
Include password changes in the results

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

### -SortBy
Sort output, default to DateRecorded

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: DateRecorded
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.Secrets.Audit
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretAudit](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretAudit)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretAudit.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretAudit.ps1)

