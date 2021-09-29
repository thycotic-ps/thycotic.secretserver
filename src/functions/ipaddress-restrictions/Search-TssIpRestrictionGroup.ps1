function Search-TssIpRestrictionGroup {
    <#
    .SYNOPSIS
    Search IP Address restrictions assigned to groups.

    .DESCRIPTION
    Search IP Address restrictions assigned to groups. Search based on Group Id or IP Address Restriction Id.

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/Search-TssIpRestrictionGroup

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/Search-TssIpRestrictionGroup.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssIpRestrictionGroup -TssSession $session -Id 5

    Return groups assigned to IP Address restriction 5

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssIpRestrictionGroup -TssSession $session -GroupId 46

    Return IP Address restrictions assigned to Group ID 46

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.IpRestrictions.Group')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # IP Address Restriction
        [int]
        $IpAddressRestrictionId,

        # Group ID
        [int]
        $GroupId,

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
                $uri = $TssSession.ApiUrl, 'ipaddress-restrictions', $IpAddressRestrictionId, 'groups' -join '/'
            }
            if ($tssParams.ContainsKey('GroupId')) {
                $uri = $TssSession.ApiUrl, 'groups', $GroupId, 'ipaddress-restrictions' -join '/'
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
                [Thycotic.PowerShell.IpRestrictions.Group[]]$restResponse.records
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}