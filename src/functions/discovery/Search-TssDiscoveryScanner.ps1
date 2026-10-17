function Search-TssDiscoveryScanner {
    <#
    .SYNOPSIS
    Search Discovery scanners

    .DESCRIPTION
    Returns the Discovery scanners (for example AD user account or local Windows account scanners) that can be added to a discovery source.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DiscoveryItemScannerId
    Return only this scanner. Replaces -ScanTypeId; -Status and -SearchText still apply, so an inactive scanner needs -Status Inactive or All

    .PARAMETER ScanTypeId
    Scan type id: 1 find host ranges, 2 find machines, 3 find local accounts, 4 find dependencies. Ignored when -DiscoveryItemScannerId is set

    .PARAMETER SearchText
    Text to match, case-insensitive, anywhere in the scanner display name (the name shown in the UI, not DiscoveryItemScannerName)

    .PARAMETER Status
    Active, Inactive or All. The server returns active scanners when omitted

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDiscoveryScanner -TssSession $session

    List the active scanners

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDiscoveryScanner -TssSession $session -ScanTypeId 3 -Status All

    List every scanner that finds local accounts

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoveryScanner

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoveryScanner.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Discovery.ScannerSummary[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [int]
        $DiscoveryItemScannerId,

        [int]
        $ScanTypeId,

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
            $uri = $TssSession.ApiUrl, 'discovery', 'scanners' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'DiscoveryItemScannerId' {
                    $queryParams += "filter.discoveryItemScannerId=$($DiscoveryItemScannerId)"
                }
                'ScanTypeId' {
                    $queryParams += "filter.scanTypeId=$($ScanTypeId)"
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
                Write-Warning 'Issue with Search-TssDiscoveryScanner request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Discovery.ScannerSummary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Discovery.ScannerSummary]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
