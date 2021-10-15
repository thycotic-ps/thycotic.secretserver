# New-TssDistributedEngineSite

## SYNOPSIS
Create a new Site

## SYNTAX

```
New-TssDistributedEngineSite [-TssSession] <Session> -SiteName <String> [-Active] [-CallbackInterval <Int32>]
 [-SiteConnectorId <Int32>] [-WinRmEndpoint <String>] [-EnableCredSsp] [-PowerShellRunAsSecret <Int32>]
 [-EnableRdpProxy] [-RdpProxyPort <Int32>] [-EnableSshProxy] [-SshProxyPort <Int32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Create a new Site.
Note that on-premises requires a Site Connector to create a site.
Secret Server Cloud subscriptions do not.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://tenant.secretservercloud.com -Credential $ssCred
New-TssDistributedEngineSite -TssSession $session -SiteName 'New Site 1'
```

Create a new Site in SSC subscription called "New Site 1"

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://tenant.secretservercloud.com -Credential $ssCred
New-TssDistributedEngineSite -TssSession $session -SiteName 'New Site 2' -Active:$false
```

Create a new Site in SSC subscription called "New Site 2" and disable it upon creation.

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://vault.local/SecretServer -Credential $ssCred
New-TssDistributedEngineSite -TssSession $session -SiteName 'Dev Network' -SiteConnector 4
```

Create a new Site called "Dev Network", assigning Site Connector 4

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

### -SiteName
Site Name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Active
Activate/Disable the Site upon creation

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

### -CallbackInterval
Engine callbank interval in seconds, default 300

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 300
Accept pipeline input: False
Accept wildcard characters: False
```

### -SiteConnectorId
Site Connector ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -WinRmEndpoint
WinRM Endpoint URL, defaults to \[http://localhost:5985/wsman\]

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Http://localhost:5985/wsman
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableCredSsp
Enable or Disable CredSSP

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

### -PowerShellRunAsSecret
Set Default PowerShell RunAs Secret ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableRdpProxy
Enable or Disable RDP Proxy

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

### -RdpProxyPort
Set RDP Proxy Port

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableSshProxy
Enable or Disable SSH Proxy

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

### -SshProxyPort
Set SSH Proxy Port

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
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

### Thycotic.PowerShell.DistributedEngines.Site
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/New-TssDistributedEngineSite](https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/New-TssDistributedEngineSite)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/New-TssDistributedEngineSite.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/New-TssDistributedEngineSite.ps1)

