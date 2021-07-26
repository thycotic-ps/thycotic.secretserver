# Test-TssSdkClient

## SYNOPSIS
Test the SDK Client configuration based on the ConfigPath

## SYNTAX

```
Test-TssSdkClient [-SecretServer] <String> [-ConfigPath] <String> [<CommonParameters>]
```

## DESCRIPTION
Test the SDK Client configuration based on the ConfigPath.
Based on status message returned:
- "Connected to endpoint \<Secret Server URL\>" = true
- "Not connected" = false

## EXAMPLES

### EXAMPLE 1
```
Test-TssSdkClient -SecretServer 'http://alpha.local/SecretServer' -RuleName tss_module -ConfigPath $env:HOME
```

On Ubuntu 20.04 client, will test SDK Client configuration and return true if connected

### EXAMPLE 2
```
Test-TssSdkClient -SecretServer 'http://alpha.local/SecretServer' -RuleName tss_module -ConfigPath c:\thycotic -Force
```

Tests SDK Client configuration and return true if connected

## PARAMETERS

### -SecretServer
Secret Server

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Boolean
## NOTES
Secret Server docs cover configuring Application Account and SDK Client rule
https://docs.thycotic.com/ss/10.9.0/api-scripting/sdk-cli/index.md#task_1__configuring_secret_server

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/authentication/Test-TssSdkClient](https://thycotic-ps.github.io/thycotic.secretserver/commands/authentication/Test-TssSdkClient)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/authentication/Test-TssSdkClient.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/authentication/Test-TssSdkClient.ps1)

