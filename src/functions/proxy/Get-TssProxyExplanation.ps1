function Get-TssProxyExplanation {
    <#
    .SYNOPSIS
    Get the explanations of the SSH proxy, SSH terminal and RDP proxy features

    .DESCRIPTION
    Returns the help text Secret Server shows on the proxy configuration pages, one property per feature.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssProxyExplanation -TssSession $session).RdpProxyExplanation

    Returns the RDP proxy explanation text

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Get-TssProxyExplanation

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Get-TssProxyExplanation.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Proxy.Explanation')]
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
            $uri = $TssSession.ApiUrl, 'proxy', 'explanation' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssProxyExplanation request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Proxy.Explanation](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Proxy.Explanation]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
