function Search-TssIpRestrictionUser {
    <#
    .SYNOPSIS
    Search IP Address restrictions assigned to users.

    .DESCRIPTION
    Search IP Address restrictions assigned to groups. Search based on User ID or IP Address Restriction Id.

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/Search-TssIpRestrictionUser

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/Search-TssIpRestrictionUser.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssIpRestrictionUser -TssSession $session -Id 5

    Return users assigned to IP Address restriction 5

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssIpRestrictionUser -TssSession $session -UserId 46

    Return IP Address restrictions assigned to User ID 46

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.IpRestrictions.User')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # IP Address Restriction
        [int]
        $IpAddressRestrictionId,

        # User ID
        [int]
        $UserId,

        # Sort by specific property, default IpAddressRestrictionId
        [string]
        $SortBy = 'IpAddressRestrictionId'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            if ($tssParams.ContainsKey('IpAddressRestrictionId')) {
                $uri = $TssSession.ApiUrl, 'ipaddress-restrictions', $IpAddressRestrictionId, 'users' -join '/'
            }
            if ($tssParams.ContainsKey('UserId')) {
                $uri = $TssSession.ApiUrl, 'users', $UserId, 'ipaddress-restrictions' -join '/'
            }
            $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'
            $invokeParams.Method = 'GET'
            $invokeParams.Uri = $uri

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue on search request"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.records.Count -le 0 -and $restResponse.records.Length -eq 0) {
                Write-Warning "No records found"
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.IpRestrictions.User[]]$restResponse.records
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}