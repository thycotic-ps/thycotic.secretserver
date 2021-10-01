function Search-TssIpRestriction {
    <#
    .SYNOPSIS
    Search for IP Address restrictions

    .DESCRIPTION
    Search for IP Address restrictions

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/Search-TssIpRestriction

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/Search-TssIpRestriction.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssIpRestriction -TssSession $session

    Return list of IP Address restrictions for Secret Server

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.IpRestrictions.IpRestriction')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Sort by specific property, default Id
        [string]
        $SortBy = 'Id'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'ipaddress-restrictions' -join '/'
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
                [Thycotic.PowerShell.IpRestrictions.IpRestriction[]]$restResponse.records
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}