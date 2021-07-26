# Get-TssSecretDependencyStub

## SYNOPSIS
Get default values for a new Secret Dependency

## SYNTAX

### template
```
Get-TssSecretDependencyStub [-TssSession] <Session> [-SecretId] <Int32> -TemplateId <Int32>
 [<CommonParameters>]
```

### script
```
Get-TssSecretDependencyStub [-TssSession] <Session> [-SecretId] <Int32> [-ScriptId <Int32>] -Type <String>
 [<CommonParameters>]
```

## DESCRIPTION
Get default values for a new Secret Dependency

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Get-TssSecretDependencyStub -TssSession $session -SecretId 42 -TemplateId 6
```

Return Secret Dependency Stub for Secret 42 and Template ID 6

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
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -TemplateId
Dependency Template ID

```yaml
Type: Int32
Parameter Sets: template
Aliases: Id

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScriptId
ID of the Script this Dependency will run, must match the TypeID

```yaml
Type: Int32
Parameter Sets: script
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type
Dependency Type this Dependency will be modeled on.
Allowed values: PowerShell (7), SSH (8), SQL (9)

```yaml
Type: String
Parameter Sets: script
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

### Thycotic.PowerShell.SecretDependencies.Dependency
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-dependencies/Get-TssSecretDependencyStub](https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-dependencies/Get-TssSecretDependencyStub)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/Get-TssSecretDependencyStub.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/Get-TssSecretDependencyStub.ps1)

