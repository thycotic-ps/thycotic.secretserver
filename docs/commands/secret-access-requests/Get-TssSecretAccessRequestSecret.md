# Get-TssSecretAccessRequestSecret

## SYNOPSIS
Get Secret Access Request by Secret ID for Current User

## SYNTAX

```
Get-TssSecretAccessRequestSecret [-TssSession] <TssSession> -SecretId <Int32[]> [<CommonParameters>]
```

## DESCRIPTION
Get Secret Access Request by Secret ID for Current User

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretAccessRequestSecret -TssSession $session -SecretId 42
```

Get any Secret Access Request on Secret 42 for current user (based on access token for session)

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

### -SecretId
Short description for parameter

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

### TssSecretAccessRequest
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssSecretAccessRequestSecret](https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssSecretAccessRequestSecret)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/Folder name/Get-SecretAccessRequestSecret.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/Folder name/Get-SecretAccessRequestSecret.ps1)

