---
title: Get-TssSecretExtensionAutofillValue
parent: Secret Extensions
grand_parent: Commands
---
# Get-TssSecretExtensionAutofillValue

## SYNOPSIS
Get the web autofill values of a secret

## SYNTAX

```
Get-TssSecretExtensionAutofillValue [-TssSession] <Session> -SecretId <Int32> -Url <String>
 [<CommonParameters>]
```

## DESCRIPTION
Returns the username and password the browser extension fills in for a web secret at the given URL, plus its launcher settings.
The output contains the password in clear text.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretExtensionAutofillValue -TssSession $session -SecretId 42 -Url 'https://portal.example.com/login'
```

Returns the autofill values of secret 42 for the portal login page

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

### -SecretId
Secret ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Url
URL of the page to fill in; must match the URL stored on the secret

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.SecretExtensions.AutofillValue
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-extensions/Get-TssSecretExtensionAutofillValue](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-extensions/Get-TssSecretExtensionAutofillValue)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-extensions/Get-TssSecretExtensionAutofillValue.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-extensions/Get-TssSecretExtensionAutofillValue.ps1)
