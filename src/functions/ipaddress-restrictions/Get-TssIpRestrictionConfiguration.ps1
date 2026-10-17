function Get-TssIpRestrictionConfiguration {
    <#
    .SYNOPSIS
    Get the IP address restrictions configuration

    .DESCRIPTION
    Returns the global IP address restrictions setting IpAddressSourceType: where Secret Server takes the client IP address that IP address restrictions are checked against. The value is TrueAddress or HeaderBasedAddress.
    In Secret Server Cloud, TrueAddress takes the client IP address from the header set by the cloud infrastructure, and HeaderBasedAddress takes it from a forwarded IP address header, which the client can spoof.
    On-premises Secret Server returns the setting but does not use it.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssIpRestrictionConfiguration -TssSession $session

    Returns the IP address restrictions configuration

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssIpRestrictionConfiguration -TssSession $session).IpAddressSourceType

    Returns TrueAddress or HeaderBasedAddress

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/Get-TssIpRestrictionConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/Get-TssIpRestrictionConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Requires permission to administer IP address restrictions.
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.IpRestrictions.Configuration')]
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
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'ipaddress-restrictions', 'configuration' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssIpRestrictionConfiguration request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.IpRestrictions.Configuration]@{
                    IpAddressSourceType = $restResponse.ipAddressSourceType.value
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
