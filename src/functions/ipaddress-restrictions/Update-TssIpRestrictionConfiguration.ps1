function Update-TssIpRestrictionConfiguration {
    <#
    .SYNOPSIS
    Update the IP address restrictions configuration

    .DESCRIPTION
    Sets the global IP address restrictions setting IpAddressSourceType: where Secret Server takes the client IP address that IP address restrictions are checked against.
    In Secret Server Cloud, TrueAddress takes the client IP address from the header set by the cloud infrastructure, and HeaderBasedAddress takes it from a forwarded IP address header, which the client can spoof.
    Returns the configuration as saved.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER IpAddressSourceType
    Source of the client IP address: TrueAddress (header set by the Secret Server Cloud infrastructure) or HeaderBasedAddress (forwarded IP address header, which the client can spoof)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssIpRestrictionConfiguration -TssSession $session -IpAddressSourceType TrueAddress

    Takes the client IP address from the header set by the cloud infrastructure

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $original = Get-TssIpRestrictionConfiguration -TssSession $session
    Update-TssIpRestrictionConfiguration -TssSession $session -IpAddressSourceType HeaderBasedAddress
    $original | Update-TssIpRestrictionConfiguration -TssSession $session

    Switches to the forwarded IP address header, then restores the original setting by piping the saved configuration

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/Update-TssIpRestrictionConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/Update-TssIpRestrictionConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server Cloud only: on-premises Secret Server rejects the update with access denied for every user. Requires permission to administer IP address restrictions.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.IpRestrictions.Configuration')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateSet('TrueAddress', 'HeaderBasedAddress')]
        [string]
        $IpAddressSourceType
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
            $invokeParams.Method = 'PUT'
            $body = @{ }
            switch ($tssParams.Keys) {
                'IpAddressSourceType' {
                    $body.Add('ipAddressSourceType', @{ dirty = $true; value = $IpAddressSourceType })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("IP address restrictions configuration", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssIpRestrictionConfiguration request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.IpRestrictions.Configuration]@{
                        IpAddressSourceType = $restResponse.ipAddressSourceType.value
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
