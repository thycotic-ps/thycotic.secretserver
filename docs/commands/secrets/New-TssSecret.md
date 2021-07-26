# New-TssSecret

## SYNOPSIS
Create a new secret

## SYNTAX

```
New-TssSecret [-TssSession] <Session> [-SecretStub] <Secret> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create a new secret

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$TemplateId = 6003
$WindowsAccountTemplate = Get-TssSecretStub -TssSession $session -SecretTemplateId $TemplateId
$data = Import-Csv c:\temp\testdata.csv
$createdSecrets = @()
foreach ($item in $data) {
    $currentTemplate = $WindowsAccountTemplate.PSObject.Copy()
    $machine = $item.Machine
    $user = $item.Username
    $currentTemplate.Name = "$machine $user"
    $currentTemplate.FolderId = 9
    $currentTemplate.SetFieldValue('Machine',$item.Machine)
    $currentTemplate.SetFieldValue('Username',$item.Username)
    $currentTemplate.SetFieldValue('Password',$item.Password)
    $created = New-TssSecret -TssSession $session -SecretStub $currentTemplate -Verbose
    $createdSecrets += $created
    Remove-Variable currentTemplate,machine,user -Force
}
return $createdSecrets | Select-Object FolderId, Name, SecretTemplateName, Active
```

Accept input from CSV file that contains Machine, Username and Password.
Iterate over each record and create a secret.
Output will show the FolderId, Name, SecretTemplateName, and Active properties.

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

### -SecretStub
Input object obtained via Get-TssSecretStub

```yaml
Type: Secret
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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

### Thycotic.PowerShell.Secrets.Secret
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/New-TssSecret](https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/New-TssSecret)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/New-TssSecret.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/New-TssSecret.ps1)

