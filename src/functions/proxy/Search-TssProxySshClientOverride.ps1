function Search-TssProxySshClientOverride {
    <#
    .SYNOPSIS
    Get the SSH terminal client overrides

    .DESCRIPTION
    Returns every SSH terminal client override: an IP address range that is always on the allow list or the block list.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssProxySshClientOverride -TssSession $session

    Returns the client overrides

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Search-TssProxySshClientOverride

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Search-TssProxySshClientOverride.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Proxy.SshClientOverride[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
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
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssProxySshClientOverride request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Proxy.SshClientOverride[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Proxy.SshClientOverride]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
