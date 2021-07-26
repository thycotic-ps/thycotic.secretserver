# Initialize-TssSdkClient

## SYNOPSIS
Initialize SDK Client for the module

## SYNTAX

```
Initialize-TssSdkClient -SecretServer <String> -RuleName <String> [-OnboardingKey <String>]
 -ConfigPath <String> [-Force] [<CommonParameters>]
```

## DESCRIPTION
Initialize SDK Client for the module to utilize token request using machine authentication via SDK Client Management feature in Secret Server (see notes section)
See help for New-TssSession using the associated UseSdkClient/ConfigPath parameters

## EXAMPLES

### EXAMPLE 1
```
Initialize-TssSdkClient -SecretServer 'http://alpha.local/SecretServer' -RuleName tss_module -ConfigPath $env:HOME
```

On Ubuntu 20.04 client, initialize SDK Client saving the configuration files in the user's HOME path

### EXAMPLE 2
```
Initialize-TssSdkClient -SecretServer 'http://alpha.local/SecretServer' -RuleName tss_module -ConfigPath c:\thycotic -Force
```

Initializes SDK Client saving the configuration files to c:\thycotic, with Force provided configuration will drop current configs (if exist) and recreate

## PARAMETERS

### -SecretServer
Secret Server

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

### -RuleName
SDK Client Management rule name

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

### -OnboardingKey
SDK Client Management rule onboarding key

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

### -ConfigPath
Config path for the key/config files, no folder names with spaces allowed

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

### -Force
Overwrite configuration (drop and create a new)

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

## NOTES
Secret Server docs cover configuring Application Account and SDK Client rule
https://docs.thycotic.com/ss/10.9.0/api-scripting/sdk-cli/index.md#task_1__configuring_secret_server

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/authentication/Initialize-TssSdkClient](https://thycotic-ps.github.io/thycotic.secretserver/commands/authentication/Initialize-TssSdkClient)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/authentication/Initialize-TssSdkClient.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/authentication/Initialize-TssSdkClient.ps1)

