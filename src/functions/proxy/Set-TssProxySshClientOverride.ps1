function Set-TssProxySshClientOverride {
    <#
    .SYNOPSIS
    Update an SSH terminal client override

    .DESCRIPTION
    Replaces the IP address range and list type of an SSH terminal client override. Both values are required: the API saves the range and type sent as a whole.
    Clients in the range are reset to match the override.
    Use New-TssProxySshClientOverride to add an override and Remove-TssProxySshClientOverride to delete one.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Client override ID (ClientOverrideId in Search-TssProxySshClientOverride output)

    .PARAMETER IpAddressRange
    IP address or range the override applies to, for example 10.0.0.0/24 or 10.0.0.1-10.0.0.50

    .PARAMETER TerminalClientType
    Put the range on the allow list or the block list

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssProxySshClientOverride -TssSession $session -Id 4 -IpAddressRange 10.0.0.0/24 -TerminalClientType BlockList

    Moves override 4 to the block list for 10.0.0.0/24

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Set-TssProxySshClientOverride

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Set-TssProxySshClientOverride.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Proxy.SshClientOverride')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ClientOverrideId')]
        [int]
        $Id,

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
            $uri = $TssSession.ApiUrl, 'proxy', 'ssh', 'client-overrides', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ }
            $body.Add('clientOverrideId', $Id)
            switch ($tssParams.Keys) {
                'IpAddressRange' {
                    $body.Add('ipAddressRange', $IpAddressRange)
                }
                'TerminalClientType' {
                    $body.Add('terminalClientType', $TerminalClientType)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Proxy ssh client override: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssProxySshClientOverride request'
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
