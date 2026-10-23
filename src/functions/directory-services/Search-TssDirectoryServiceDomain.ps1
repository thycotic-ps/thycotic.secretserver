function Search-TssDirectoryServiceDomain {
    <#
    .SYNOPSIS
    Search Directory Services domains

    .DESCRIPTION
    Search Directory Services domains
    -SearchText matches the domain name or the friendly name and adds DistinguishedName and SiteId to the output; it reads the active-directory/domains endpoint because the directory-services endpoint filters on the domain name only.

    .PARAMETER SearchText
    Text to match in the domain name or friendly name

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDirectoryServiceDomain -TssSession $session -DomainName lab.local

    Return the domain lab.local information

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDirectoryServiceDomain -TssSession $session -SearchText corp | Select-Object DomainId, DomainName, FriendlyName, DistinguishedName

    Find domains whose name or friendly name matches corp and show their distinguished names

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Search-TssDirectoryServiceDomain

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Search-TssDirectoryServiceDomain.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server marks the active-directory/domains endpoint used by -SearchText obsolete in favor of the directory-services endpoints; it still answers on current versions.
    #>
    [CmdletBinding(DefaultParameterSetName = 'filter')]
    [OutputType('Thycotic.PowerShell.DirectoryServices.DomainSummary[]')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Domain Name
        [Parameter(ParameterSetName = 'filter')]
        [Alias('Domain')]
        [string]
        $DomainName,

        [Parameter(Mandatory, ParameterSetName = 'searchText')]
        [string]
        $SearchText,

        # Include inactive domains
        [switch]
        $IncludeInactive,

        # Sort by specific property, default DomainName
        [Parameter(ParameterSetName = 'filter')]
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
            if ($PSCmdlet.ParameterSetName -eq 'searchText') {
                $uri = $TssSession.ApiUrl, 'active-directory', 'domains' -join '/'
                $uri = $uri, "filter.searchText=$([uri]::EscapeDataString($SearchText))&filter.includeInactive=$([boolean]$IncludeInactive)&take=$($TssSession.Take)" -join '?'
            } else {
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
                [Thycotic.PowerShell.DirectoryServices.DomainSummary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.DirectoryServices.DomainSummary]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}