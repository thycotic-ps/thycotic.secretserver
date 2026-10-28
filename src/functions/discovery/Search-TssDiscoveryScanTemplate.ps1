function Search-TssDiscoveryScanTemplate {
    <#
    .SYNOPSIS
    Search Discovery scan templates

    .DESCRIPTION
    Returns the Discovery scan templates (for example Active Directory Account or Computer) that shape what Discovery finds.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DiscoveryScanTypeId
    Scan type id: 1 find host ranges, 2 find machines, 3 find local accounts, 4 find dependencies

    .PARAMETER DiscoverySourceId
    Return only templates used by this discovery source

    .PARAMETER IncludeInput
    Include input scan templates

    .PARAMETER OnlyIncludeBaseScanTemplates
    Return only base templates (templates without a parent)

    .PARAMETER SearchText
    Text to match in the template name

    .PARAMETER Status
    Active, Inactive or All. The server returns active templates when omitted

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDiscoveryScanTemplate -TssSession $session

    List the active scan templates

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDiscoveryScanTemplate -TssSession $session -DiscoveryScanTypeId 3 -OnlyIncludeBaseScanTemplates

    List the base scan templates that find local accounts

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoveryScanTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoveryScanTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Discovery.ScanTemplateSummary[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [int]
        $DiscoveryScanTypeId,

        [int]
        $DiscoverySourceId,

        [switch]
        $IncludeInput,

        [switch]
        $OnlyIncludeBaseScanTemplates,

        [string]
        $SearchText,

        [ValidateSet('Active', 'Inactive', 'All')]
        [string]
        $Status
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'scan-templates' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'DiscoveryScanTypeId' {
                    $queryParams += "filter.discoveryScanTypeId=$($DiscoveryScanTypeId)"
                }
                'DiscoverySourceId' {
                    $queryParams += "filter.discoverySourceId=$($DiscoverySourceId)"
                }
                'IncludeInput' {
                    $queryParams += "filter.includeInput=$([boolean]$IncludeInput)"
                }
                'OnlyIncludeBaseScanTemplates' {
                    $queryParams += "filter.onlyIncludeBaseScanTemplates=$([boolean]$OnlyIncludeBaseScanTemplates)"
                }
                'SearchText' {
                    $queryParams += "filter.searchText=$([uri]::EscapeDataString($SearchText))"
                }
                'Status' {
                    $queryParams += "filter.status=$([uri]::EscapeDataString($Status))"
                }
            }
            if ($queryParams) {
                $uri = $uri, ($queryParams -join '&') -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssDiscoveryScanTemplate request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Discovery.ScanTemplateSummary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Discovery.ScanTemplateSummary]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
