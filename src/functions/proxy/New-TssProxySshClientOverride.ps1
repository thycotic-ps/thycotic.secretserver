function New-TssProxySshClientOverride {
    <#
    .SYNOPSIS
    Add an SSH terminal client override

    .DESCRIPTION
    Adds an IP address range that is always on the SSH terminal allow list or block list. Clients in the range are reset to match the override.
    Returns the new override.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER IpAddressRange
    IP address or range the override applies to, for example 10.0.0.0/24 or 10.0.0.1-10.0.0.50

    .PARAMETER TerminalClientType
    Put the range on the allow list or the block list

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssProxySshClientOverride -TssSession $session -IpAddressRange 203.0.113.0/24 -TerminalClientType BlockList

    Always blocks SSH terminal clients from 203.0.113.0/24

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/New-TssProxySshClientOverride

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/New-TssProxySshClientOverride.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Proxy.SshClientOverride')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [string]
        $IpAddressRange,

        [Parameter(Mandatory)]
        [ValidateSet('AllowList', 'BlockList')]
        [string]
        $TerminalClientType
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'proxy', 'ssh', 'client-overrides' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ }
            switch ($tssParams.Keys) {
                'IpAddressRange' {
                    $body.Add('ipAddressRange', $IpAddressRange)
                }
                'TerminalClientType' {
                    $body.Add('terminalClientType', $TerminalClientType)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Proxy ssh client override", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssProxySshClientOverride request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Proxy.SshClientOverride](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Proxy.SshClientOverride]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
