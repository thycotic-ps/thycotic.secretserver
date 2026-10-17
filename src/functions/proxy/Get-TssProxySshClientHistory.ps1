function Get-TssProxySshClientHistory {
    <#
    .SYNOPSIS
    Get the authentication history of SSH terminal clients

    .DESCRIPTION
    Returns SSH terminal client authentication attempts: client IP address, engine identity GUID, date, and authentication result. Secret Server filters this list by client IP address only.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER IpAddress
    Return only entries from this client IP address

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssProxySshClientHistory -TssSession $session -IpAddress 10.0.0.25

    Returns the authentication attempts from 10.0.0.25

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Get-TssProxySshClientHistory

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Get-TssProxySshClientHistory.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Proxy.SshClientHistory[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [string]
        $IpAddress
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'proxy', 'ssh', 'clienthistory' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'IpAddress' {
                    $queryParams += "filter.ipAddress=$([uri]::EscapeDataString($IpAddress))"
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
                Write-Warning 'Issue with Get-TssProxySshClientHistory request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Proxy.SshClientHistory[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Proxy.SshClientHistory]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
