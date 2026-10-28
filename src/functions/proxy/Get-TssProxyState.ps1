function Get-TssProxyState {
    <#
    .SYNOPSIS
    Get the proxy state

    .DESCRIPTION
    Returns the proxy state. ShowLogs is True on Secret Server on-premises, where proxy operational logs are available, and False on Secret Server Cloud.
    Requires the View Proxying Configuration or Administer Proxying Configuration permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssProxyState -TssSession $session

    Returns the proxy state

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Get-TssProxyState

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Get-TssProxyState.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Proxy.State')]
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
            $uri = $TssSession.ApiUrl, 'proxy', 'state' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssProxyState request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Proxy.State](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Proxy.State]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
