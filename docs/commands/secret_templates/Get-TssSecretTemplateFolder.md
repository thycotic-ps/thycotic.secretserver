# Get-TssSecretTemplateFolder

## SYNOPSIS
Get Secret Templates allowed on a given folder

## SYNTAX

```
Get-TssSecretTemplateFolder [-TssSession] <TssSession> -FolderId <Int32[]> [<CommonParameters>]
```

## DESCRIPTION
Get Secret Templates allowed on a given folder

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretTemplateFolder -TssSession $session -FolderId 64
```

Returns a list of Secret Templates allowed for Folder ID 64

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

### -FolderId
Folder ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

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

### TssSecretTemplateView
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssSecretTemplateFolder](https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssSecretTemplateFolder)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Get-SecretTemplateFolder.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Get-SecretTemplateFolder.ps1)

