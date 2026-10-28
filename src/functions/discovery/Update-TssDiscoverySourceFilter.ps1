function Update-TssDiscoverySourceFilter {
    <#
    .SYNOPSIS
    Replace the OU filters of a discovery source

    .DESCRIPTION
    Replaces the domain scope of an Active Directory discovery source: the organizational units and containers it includes or excludes.
    Filters not given are removed; pass an empty array to remove them all.
    Each filter needs Guid, FilterType (Include or Exclude) and ScanTargetType (Users, Computers or UsersAndComputers), and may carry DiscoveryFilterId, SiteId and SecretId.
    The Filters of Get-TssDiscoverySourceFilter can be changed and passed back.
    Secret Server reads the domain to apply the filters, so a domain controller must be reachable from the site of the source.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Discovery source ID

    .PARAMETER Filter
    Filters to set, as objects or hashtables with the properties named in the description

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $scope = Get-TssDiscoverySourceFilter -TssSession $session -Id 3
    Update-TssDiscoverySourceFilter -TssSession $session -Id 3 -Filter ($scope.Filters | Where-Object DisplayName -NE 'Test')

    Remove the filter named Test from discovery source 3 and keep the others

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $ou = Get-TssDiscoverySourceOu -TssSession $session -Id 3 -SearchText 'Servers' -Include | Select-Object -First 1
    Update-TssDiscoverySourceFilter -TssSession $session -Id 3 -Filter @{ Guid = $ou.Guid; FilterType = 'Include'; ScanTargetType = 'Computers' }

    Scope discovery source 3 to the computers in the first OU whose name contains Servers

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Update-TssDiscoverySourceFilter

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Update-TssDiscoverySourceFilter.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.SourceFilter')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('DiscoverySourceId')]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [AllowEmptyCollection()]
        [object[]]
        $Filter
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'source', $Id, 'filters' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $filters = @(foreach ($item in $Filter) {
                    $wire = @{ }
                    foreach ($field in 'discoveryFilterId', 'guid', 'filterType', 'scanTargetType', 'siteId', 'secretId') {
                        $value = $item.$field
                        if ($null -ne $value) {
                            $wire.Add($field, $value)
                        }
                    }
                    $wire
                })
            $body = @{ data = @{ filters = $filters } }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Discovery source filters: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssDiscoverySourceFilter request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Discovery.SourceFilter](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.SourceFilter]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
