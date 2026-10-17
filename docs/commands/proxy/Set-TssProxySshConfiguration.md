---
title: Set-TssProxySshConfiguration
parent: Proxy
grand_parent: Commands
---
# Set-TssProxySshConfiguration

## SYNOPSIS
Set the SSH proxy configuration

## SYNTAX

```
Set-TssProxySshConfiguration [-TssSession] <Session> [-EnableSshProxy] [-SshProxyPort <Int32>]
 [-EnableSshTunneling] [-EnableProxyInactivityTimeout] [-ProxyInactivityTimeoutSeconds <Int32>]
 [-ProxyNewSecretsByDefault] [-AllowSiteSelectionForActiveDirectoryAccounts] [-SshProxyBanner <String>]
 [-DaysToKeepOperationalLogs <Int32>] [-EnableSshTerminal] [-SshTerminalBanner <String>]
 [-EnableTerminalInactivityTimeout] [-TerminalInactivityTimeoutSeconds <Int32>] [-EnablePasswordHiding]
 [-PasswordRegexFilter <String>] [-EnableWindowTitleChangeCommand] [-EnableProxyBlockListing]
 [-ProxyAutoBlockListingMaxNum <Int32>] [-ProxyAutoBlockListingMaxHistory <Int32>]
 [-ProxyAutoBlockListingTimeFrameMinutes <Int32>] [-AvailablePortRange <String>]
 [-TunnelKeepAliveInSeconds <Int32>] [-SshHostKey <SecureString>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the SSH proxy and SSH terminal configuration.
Only the parameters provided are changed.
Use New-TssProxySshKey to generate a new SSH proxy host key, or -SshHostKey to install an existing one.
Returns the SSH proxy configuration after the change.
The response includes key material: treat the output as sensitive, do not log it or write it to disk unprotected.
SshHostKey is the SSH proxy host private key in PEM form.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssProxySshConfiguration -TssSession $session -EnableSshProxy -EnableSshTerminal | Out-Null
```

Enables the SSH proxy and SSH terminal

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssProxySshConfiguration -TssSession $session -EnableTerminalInactivityTimeout -TerminalInactivityTimeoutSeconds 900 | Out-Null
```

Disconnects idle SSH terminal sessions after 15 minutes

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
$hostKey = ConvertTo-SecureString -String (Get-Content -Path ./ssh-proxy-host.pem -Raw) -AsPlainText -Force
(Set-TssProxySshConfiguration -TssSession $session -SshHostKey $hostKey).SshProxyHostFingerprint
```

Installs an existing SSH proxy host key from a PEM file and returns its fingerprint

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

### -EnableSshProxy
Enable or disable the SSH proxy

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
Port the SSH proxy listens on (on-premises only; ignored by Secret Server Cloud)

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

### -EnableSshTunneling
Allow SSH tunneling through the proxy for proxied RDP sessions

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

### -EnableProxyInactivityTimeout
Disconnect inactive proxy sessions

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

### -ProxyInactivityTimeoutSeconds
Seconds of inactivity before a proxy session is disconnected

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

### -ProxyNewSecretsByDefault
Create new SSH secrets with proxying enabled

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

### -AllowSiteSelectionForActiveDirectoryAccounts
Allow users to pick a site when launching or generating proxy credentials for an RDP proxied secret

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

### -SshProxyBanner
Banner shown when a shell connection to the proxy opens (2000 characters or fewer)

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

### -DaysToKeepOperationalLogs
Number of days to keep SSH proxy logs (1 or more)

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

### -EnableSshTerminal
Enable or disable the SSH terminal

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

### -SshTerminalBanner
Banner shown after a user authenticates to the SSH terminal (2000 characters or fewer)

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

### -EnableTerminalInactivityTimeout
Disconnect inactive SSH terminal sessions

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

### -TerminalInactivityTimeoutSeconds
Seconds of inactivity before an SSH terminal session is disconnected

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

### -EnablePasswordHiding
Hide input on lines detected as password prompts from SSH keystroke capture

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

### -PasswordRegexFilter
Regular expression that identifies password prompts for password hiding

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

### -EnableWindowTitleChangeCommand
Send the window title change command when a session starts

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

### -EnableProxyBlockListing
Block IP addresses that fail to authenticate too many times

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

### -ProxyAutoBlockListingMaxNum
Failed authentication attempts before an IP address is blocked

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

### -ProxyAutoBlockListingMaxHistory
History entries kept per client (not less than ProxyAutoBlockListingMaxNum)

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

### -ProxyAutoBlockListingTimeFrameMinutes
Minutes within which the failed attempts must happen for a block

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

### -AvailablePortRange
Port range available on the SSH proxy for jumpbox port forwarding, for example 5000-5100

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

### -TunnelKeepAliveInSeconds
Interval in seconds for keep alive signals on port forwarding tunnels (0-86400)

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

### -SshHostKey
SSH proxy host private key in PEM form, as a secure string.
SSH clients that stored the previous host key must update it

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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

### Thycotic.PowerShell.Proxy.SshConfiguration
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Set-TssProxySshConfiguration](https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Set-TssProxySshConfiguration)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Set-TssProxySshConfiguration.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Set-TssProxySshConfiguration.ps1)
