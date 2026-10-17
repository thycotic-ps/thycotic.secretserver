function Set-TssProxySshConfiguration {
    <#
    .SYNOPSIS
    Set the SSH proxy configuration

    .DESCRIPTION
    Updates the SSH proxy and SSH terminal configuration. Only the parameters provided are changed.
    Use New-TssProxySshKey to generate a new SSH proxy host key, or -SshHostKey to install an existing one.
    Returns the SSH proxy configuration after the change.
    The response includes key material: treat the output as sensitive, do not log it or write it to disk unprotected. SshHostKey is the SSH proxy host private key in PEM form.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER EnableSshProxy
    Enable or disable the SSH proxy

    .PARAMETER SshProxyPort
    Port the SSH proxy listens on (on-premises only; ignored by Secret Server Cloud)

    .PARAMETER EnableSshTunneling
    Allow SSH tunneling through the proxy for proxied RDP sessions

    .PARAMETER EnableProxyInactivityTimeout
    Disconnect inactive proxy sessions

    .PARAMETER ProxyInactivityTimeoutSeconds
    Seconds of inactivity before a proxy session is disconnected

    .PARAMETER ProxyNewSecretsByDefault
    Create new SSH secrets with proxying enabled

    .PARAMETER AllowSiteSelectionForActiveDirectoryAccounts
    Allow users to pick a site when launching or generating proxy credentials for an RDP proxied secret

    .PARAMETER SshProxyBanner
    Banner shown when a shell connection to the proxy opens (2000 characters or fewer)

    .PARAMETER DaysToKeepOperationalLogs
    Number of days to keep SSH proxy logs (1 or more)

    .PARAMETER EnableSshTerminal
    Enable or disable the SSH terminal

    .PARAMETER SshTerminalBanner
    Banner shown after a user authenticates to the SSH terminal (2000 characters or fewer)

    .PARAMETER EnableTerminalInactivityTimeout
    Disconnect inactive SSH terminal sessions

    .PARAMETER TerminalInactivityTimeoutSeconds
    Seconds of inactivity before an SSH terminal session is disconnected

    .PARAMETER EnablePasswordHiding
    Hide input on lines detected as password prompts from SSH keystroke capture

    .PARAMETER PasswordRegexFilter
    Regular expression that identifies password prompts for password hiding

    .PARAMETER EnableWindowTitleChangeCommand
    Send the window title change command when a session starts

    .PARAMETER EnableProxyBlockListing
    Block IP addresses that fail to authenticate too many times

    .PARAMETER ProxyAutoBlockListingMaxNum
    Failed authentication attempts before an IP address is blocked

    .PARAMETER ProxyAutoBlockListingMaxHistory
    History entries kept per client (not less than ProxyAutoBlockListingMaxNum)

    .PARAMETER ProxyAutoBlockListingTimeFrameMinutes
    Minutes within which the failed attempts must happen for a block

    .PARAMETER AvailablePortRange
    Port range available on the SSH proxy for jumpbox port forwarding, for example 5000-5100

    .PARAMETER TunnelKeepAliveInSeconds
    Interval in seconds for keep alive signals on port forwarding tunnels (0-86400)

    .PARAMETER SshHostKey
    SSH proxy host private key in PEM form, as a secure string. SSH clients that stored the previous host key must update it

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssProxySshConfiguration -TssSession $session -EnableSshProxy -EnableSshTerminal | Out-Null

    Enables the SSH proxy and SSH terminal

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssProxySshConfiguration -TssSession $session -EnableTerminalInactivityTimeout -TerminalInactivityTimeoutSeconds 900 | Out-Null

    Disconnects idle SSH terminal sessions after 15 minutes

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $hostKey = ConvertTo-SecureString -String (Get-Content -Path ./ssh-proxy-host.pem -Raw) -AsPlainText -Force
    (Set-TssProxySshConfiguration -TssSession $session -SshHostKey $hostKey).SshProxyHostFingerprint

    Installs an existing SSH proxy host key from a PEM file and returns its fingerprint

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Set-TssProxySshConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Set-TssProxySshConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Proxy.SshConfiguration')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $EnableSshProxy,

        [int]
        $SshProxyPort,

        [switch]
        $EnableSshTunneling,

        [switch]
        $EnableProxyInactivityTimeout,

        [int]
        $ProxyInactivityTimeoutSeconds,

        [switch]
        $ProxyNewSecretsByDefault,

        [switch]
        $AllowSiteSelectionForActiveDirectoryAccounts,

        [string]
        $SshProxyBanner,

        [int]
        $DaysToKeepOperationalLogs,

        [switch]
        $EnableSshTerminal,

        [string]
        $SshTerminalBanner,

        [switch]
        $EnableTerminalInactivityTimeout,

        [int]
        $TerminalInactivityTimeoutSeconds,

        [switch]
        $EnablePasswordHiding,

        [string]
        $PasswordRegexFilter,

        [switch]
        $EnableWindowTitleChangeCommand,

        [switch]
        $EnableProxyBlockListing,

        [int]
        $ProxyAutoBlockListingMaxNum,

        [int]
        $ProxyAutoBlockListingMaxHistory,

        [int]
        $ProxyAutoBlockListingTimeFrameMinutes,

        [string]
        $AvailablePortRange,

        [int]
        $TunnelKeepAliveInSeconds,

        [securestring]
        $SshHostKey
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'proxy', 'ssh', 'config' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ }
            switch ($tssParams.Keys) {
                'EnableSshProxy' {
                    $body.Add('enableSshProxy', [boolean]$EnableSshProxy)
                }
                'SshProxyPort' {
                    $body.Add('sshProxyPort', $SshProxyPort)
                }
                'EnableSshTunneling' {
                    $body.Add('enableSshTunneling', [boolean]$EnableSshTunneling)
                }
                'EnableProxyInactivityTimeout' {
                    $body.Add('enableProxyInactivityTimeout', [boolean]$EnableProxyInactivityTimeout)
                }
                'ProxyInactivityTimeoutSeconds' {
                    $body.Add('proxyInactivityTimeoutSeconds', $ProxyInactivityTimeoutSeconds)
                }
                'ProxyNewSecretsByDefault' {
                    $body.Add('proxyNewSecretsByDefault', [boolean]$ProxyNewSecretsByDefault)
                }
                'AllowSiteSelectionForActiveDirectoryAccounts' {
                    $body.Add('allowSiteSelectionForActiveDirectoryAccounts', [boolean]$AllowSiteSelectionForActiveDirectoryAccounts)
                }
                'SshProxyBanner' {
                    $body.Add('sshProxyBanner', $SshProxyBanner)
                }
                'DaysToKeepOperationalLogs' {
                    $body.Add('daysToKeepOperationalLogs', $DaysToKeepOperationalLogs)
                }
                'EnableSshTerminal' {
                    $body.Add('enableSshTerminal', [boolean]$EnableSshTerminal)
                }
                'SshTerminalBanner' {
                    $body.Add('sshTerminalBanner', $SshTerminalBanner)
                }
                'EnableTerminalInactivityTimeout' {
                    $body.Add('enableTerminalInactivityTimeout', [boolean]$EnableTerminalInactivityTimeout)
                }
                'TerminalInactivityTimeoutSeconds' {
                    $body.Add('terminalInactivityTimeoutSeconds', $TerminalInactivityTimeoutSeconds)
                }
                'EnablePasswordHiding' {
                    $body.Add('enablePasswordHiding', [boolean]$EnablePasswordHiding)
                }
                'PasswordRegexFilter' {
                    $body.Add('passwordRegexFilter', $PasswordRegexFilter)
                }
                'EnableWindowTitleChangeCommand' {
                    $body.Add('enableWindowTitleChangeCommand', [boolean]$EnableWindowTitleChangeCommand)
                }
                'EnableProxyBlockListing' {
                    $body.Add('enableProxyBlockListing', [boolean]$EnableProxyBlockListing)
                }
                'ProxyAutoBlockListingMaxNum' {
                    $body.Add('proxyAutoBlockListingMaxNum', $ProxyAutoBlockListingMaxNum)
                }
                'ProxyAutoBlockListingMaxHistory' {
                    $body.Add('proxyAutoBlockListingMaxHistory', $ProxyAutoBlockListingMaxHistory)
                }
                'ProxyAutoBlockListingTimeFrameMinutes' {
                    $body.Add('proxyAutoBlockListingTimeFrameMinutes', $ProxyAutoBlockListingTimeFrameMinutes)
                }
                'AvailablePortRange' {
                    $body.Add('availablePortRange', $AvailablePortRange)
                }
                'TunnelKeepAliveInSeconds' {
                    $body.Add('tunnelKeepAliveInSeconds', $TunnelKeepAliveInSeconds)
                }
                'SshHostKey' {
                    $body.Add('sshHostKey', [System.Net.NetworkCredential]::new('', $SshHostKey).Password)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            $bodyText = if ($tssParams.ContainsKey('SshHostKey')) { ' (request body not shown: it carries the host key)' } else { " with:`n$($invokeParams.Body)`n" }
            if ($PSCmdlet.ShouldProcess("Proxy ssh configuration", "$($invokeParams.Method) $uri$bodyText")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri$bodyText"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssProxySshConfiguration request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Proxy.SshConfiguration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Proxy.SshConfiguration]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
