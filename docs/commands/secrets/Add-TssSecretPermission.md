# Add-TssSecretPermission

## SYNOPSIS
Add a User or Group permission to a Secret

## SYNTAX

```
Add-TssSecretPermission [-TssSession] <Session> -SecretId <Int32[]> -AccessRole <SecretPermissions>
 [-DomainName <String>] [-GroupName <String>] [-Username <String>] [-Force] [<CommonParameters>]
```

## DESCRIPTION
Add a User or Group permission to a Secret.
Use -Force to break inheritance.

## EXAMPLES

### EXAMPLE 1
```
session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Add-TssSecretPermission -TssSession $session -Id 65 -Type User -Name bob -AccessRole Owner
```

Add bob to Secret 65 granting Secret role of owner

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$secrets = Search-TssSecret -TssSession $session | Where-Object -not InheritPermission
$secrets | Add-TssSecretPermission -TssSession $session -Username chance.wayne -AccessRole View
```

Add "chance.wayne" to all Secrets that do not have Inherit Permissions enabled.
Granting Secret role of View

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$Secrets = Search-TssSecret -TssSession $session -SearchText 'App'
$Secrets | Add-TssSecretPermission -TssSession $session -Username chad -AccessRole Owner -Force
```

Add "chad" as owner for Secrets that have "App" in their name, will also break inheritance if enabled on any of the Secrets

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
Secret Id

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -AccessRole
Secret Access Role Name (List, View, Edit, Owner)

```yaml
Type: SecretPermissions
Parameter Sets: (All)
Aliases:
Accepted values: List, View, Edit, Owner

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -DomainName
Domain Name (the friendly name), if user or group is an Directory Service domain

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

### -GroupName
Group Name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Username
Username

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Force
If provided will break inheritance on the secret and add the permission

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

### TssSecretPermission
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/Secrets/Add-TssSecretPermission](https://thycotic-ps.github.io/thycotic.secretserver/commands/Secrets/Add-TssSecretPermission)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/Secrets/Add-TssSecretPermission.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/Secrets/Add-TssSecretPermission.ps1)

