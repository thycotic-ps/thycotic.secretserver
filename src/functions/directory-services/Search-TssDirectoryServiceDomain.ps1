function Search-TssDirectoryServiceDomain {
    <#
    .SYNOPSIS
    Search Directory Services domains

    .DESCRIPTION
    Search Directory Services domains

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDirectoryServiceDomain -TssSession $session -DomainName lab.local

    Return the domain lab.local information

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Search-TssDirectoryServiceDomain

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Search-TssDirectoryServiceDomain.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DirectoryServices.DomainSummary')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Domain Name
        [Alias('Domain')]
        [int]
        $DomainName,

        # Include inactive domains
        [switch]
        $IncludeInactive,

        # Sort by specific property, default DomainName
        [string]
        $SortBy = 'DomainName'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'directory-services', 'domains' -join '/'
            $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)&filter.includeInactive=$([boolean]$IncludeInactive)" -join '?'

            $filters = @()
            if ($tssParams.ContainsKey('DomainName')) {
                $filters += "filter.DomainName=$DomainName"
            }
            if ($filters) {
                $uriFilter = $filters -join '&'
                Write-Verbose "Filters: $uriFilter"
                $uri = $uri, $uriFilter -join '&'
            }

            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue on search request'
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.records.Count -le 0 -and $restResponse.records.Length -eq 0) {
                Write-Warning 'No Directory Domain found'
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.DirectoryServices.DomainSummary[]]$restResponse.records
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}