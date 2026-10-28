function Search-TssProxySshClient {
    <#
    .SYNOPSIS
    Search the clients that connected to the SSH terminal

    .DESCRIPTION
    Returns the SSH terminal clients Secret Server has seen: client ID, IP address, allow or block list type, and last connection date.
    Use Set-TssProxySshClient to move a client to the allow list or block list.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER IpAddress
    Return only the client with this IP address

    .PARAMETER TerminalClientType
    Return only clients of this type

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssProxySshClient -TssSession $session -TerminalClientType BlockList

    Returns the clients on the block list

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Search-TssProxySshClient

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Search-TssProxySshClient.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Proxy.SshClient[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [string]
        $IpAddress,

        [ValidateSet('Unknown', 'AllowList', 'BlockList')]
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
            $uri = $TssSession.ApiUrl, 'proxy', 'ssh', 'clients' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'IpAddress' {
                    $queryParams += "filter.ipAddress=$([uri]::EscapeDataString($IpAddress))"
                }
                'TerminalClientType' {
                    $queryParams += "filter.terminalClientType=$([uri]::EscapeDataString($TerminalClientType))"
                }
            }
            if ($queryParams) {
                $uri = $uri, ($queryParams -join '&') -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssProxySshClient request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Proxy.SshClient[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Proxy.SshClient]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
