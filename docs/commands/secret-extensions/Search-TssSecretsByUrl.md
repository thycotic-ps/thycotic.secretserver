# Search-TssSecretsByUrl

## SYNOPSIS
Search for Secrets that match a URL for Web Password Filler

## SYNTAX

```
Search-TssSecretsByUrl [-TssSession] <Session> [-Url <String>] [<CommonParameters>]
```

## DESCRIPTION
Search for Secrets that match a URL for Web Password Filler

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Search-TssWpfSecretsByUrl -TssSession $session -Url 'https://citibank.com/login'
```

Return Secrets that match the URL provided

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

### -Url
URL to search against

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.SecretExtensions.Secret
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-extensions/Search-TssSecretsByUrl](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-extensions/Search-TssSecretsByUrl)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-extensions/Search-TssSecretsByUrl.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-extensions/Search-TssSecretsByUrl.ps1)

