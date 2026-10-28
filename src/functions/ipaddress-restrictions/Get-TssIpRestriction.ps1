function Get-TssIpRestriction {
    <#
    .SYNOPSIS
    Get an IP address restriction by ID

    .DESCRIPTION
    Returns the name and IP range of an IP address restriction.
    IP address restrictions limit the IP addresses that the users and groups assigned to them can log in from.
    Use Search-TssIpRestriction to list every IP address restriction.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    IP address restriction ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssIpRestriction -TssSession $session -Id 3

    Returns IP address restriction ID 3

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssIpRestriction -TssSession $session | Where-Object Name -like 'Office*' | Get-TssIpRestriction -TssSession $session

    Returns each IP address restriction whose name starts with Office

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/Get-TssIpRestriction

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/Get-TssIpRestriction.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.IpRestrictions.IpRestriction')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('IpAddressRestrictionId')]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'ipaddress-restrictions', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssIpRestriction request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.IpRestrictions.IpRestriction](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.IpRestrictions.IpRestriction]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
