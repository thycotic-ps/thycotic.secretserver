function Search-TssDiscoveryNetworkItem {
    <#
    .SYNOPSIS
    Search items found by Discovery

    .DESCRIPTION
    Returns the computers, accounts, public keys and service accounts found by Discovery and linked in a discovery source and network tree.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER CreatedEndDate
    If set, used to return results that have a created date less than or equal to the value

    .PARAMETER CreatedStartDate
    If set, used to return results that have a created date greater than or equal to the value

    .PARAMETER DiscoveryRuleId
    Filter for items that will be imported by a specific rule

    .PARAMETER DiscoverySourceId
    Filter by Discovery Source Id

    .PARAMETER HasComputerAccounts
    Return only items with computer accounts; use -HasComputerAccounts:$false for items without

    .PARAMETER ItemType
    Item type: Computer, ComputerAccount, ServiceAccount, PublicKey, DirectoryAccount, EntraIDRole or EntraIDMember. Omit for every type

    .PARAMETER LastPolledEndDate
    If set, used to return results that have a last polled date less than or equal to the value

    .PARAMETER LastPolledStartDate
    If set, used to return results that have a last polled date greater than or equal to the value

    .PARAMETER LastReachedEndDate
    If set, used to return results that have a last reached date less than or equal to the value

    .PARAMETER LastReachedStartDate
    If set, used to return results that have a last reached date greater than or equal to the value

    .PARAMETER Managed
    Return only managed items; use -Managed:$false for unmanaged items. Omit for both

    .PARAMETER OperatingSystem
    Operating system to match

    .PARAMETER OrganizationalUnitId
    Filter by Organizational Unit Id

    .PARAMETER ScanItemTemplateId
    Filter by scan template id

    .PARAMETER SearchChildren
    Include every descendant of the organizational unit, not only its direct children

    .PARAMETER SearchText
    Text to search for

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDiscoveryNetworkItem -TssSession $session -DiscoverySourceId 1 -ItemType computer

    List the computers found by discovery source 1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDiscoveryNetworkItem -TssSession $session -Managed:$false -SearchText svc

    List unmanaged items whose name contains svc

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoveryNetworkItem

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoveryNetworkItem.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Discovery.NetworkItem[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [datetime]
        $CreatedEndDate,

        [datetime]
        $CreatedStartDate,

        [int]
        $DiscoveryRuleId,

        [int]
        $DiscoverySourceId,

        [switch]
        $HasComputerAccounts,

        [ValidateSet('Computer', 'ComputerAccount', 'ServiceAccount', 'PublicKey', 'DirectoryAccount', 'EntraIDRole', 'EntraIDMember')]
        [string]
        $ItemType,

        [datetime]
        $LastPolledEndDate,

        [datetime]
        $LastPolledStartDate,

        [datetime]
        $LastReachedEndDate,

        [datetime]
        $LastReachedStartDate,

        [switch]
        $Managed,

        [string]
        $OperatingSystem,

        [int]
        $OrganizationalUnitId,

        [int]
        $ScanItemTemplateId,

        [switch]
        $SearchChildren,

        [string]
        $SearchText
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'network', 'items' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'CreatedEndDate' {
                    $queryParams += "filter.createdEndDate=$([uri]::EscapeDataString($CreatedEndDate.ToString('o')))"
                }
                'CreatedStartDate' {
                    $queryParams += "filter.createdStartDate=$([uri]::EscapeDataString($CreatedStartDate.ToString('o')))"
                }
                'DiscoveryRuleId' {
                    $queryParams += "filter.discoveryRuleId=$($DiscoveryRuleId)"
                }
                'DiscoverySourceId' {
                    $queryParams += "filter.discoverySourceId=$($DiscoverySourceId)"
                }
                'HasComputerAccounts' {
                    $queryParams += "filter.hasComputerAccounts=$([boolean]$HasComputerAccounts)"
                }
                'ItemType' {
                    $queryParams += "filter.itemType=$([uri]::EscapeDataString($ItemType))"
                }
                'LastPolledEndDate' {
                    $queryParams += "filter.lastPolledEndDate=$([uri]::EscapeDataString($LastPolledEndDate.ToString('o')))"
                }
                'LastPolledStartDate' {
                    $queryParams += "filter.lastPolledStartDate=$([uri]::EscapeDataString($LastPolledStartDate.ToString('o')))"
                }
                'LastReachedEndDate' {
                    $queryParams += "filter.lastReachedEndDate=$([uri]::EscapeDataString($LastReachedEndDate.ToString('o')))"
                }
                'LastReachedStartDate' {
                    $queryParams += "filter.lastReachedStartDate=$([uri]::EscapeDataString($LastReachedStartDate.ToString('o')))"
                }
                'Managed' {
                    $queryParams += "filter.managed=$([boolean]$Managed)"
                }
                'OperatingSystem' {
                    $queryParams += "filter.operatingSystem=$([uri]::EscapeDataString($OperatingSystem))"
                }
                'OrganizationalUnitId' {
                    $queryParams += "filter.organizationalUnitId=$($OrganizationalUnitId)"
                }
                'ScanItemTemplateId' {
                    $queryParams += "filter.scanItemTemplateId=$($ScanItemTemplateId)"
                }
                'SearchChildren' {
                    $queryParams += "filter.searchChildren=$([boolean]$SearchChildren)"
                }
                'SearchText' {
                    $queryParams += "filter.searchText=$([uri]::EscapeDataString($SearchText))"
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
                Write-Warning 'Issue with Search-TssDiscoveryNetworkItem request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Discovery.NetworkItem[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Discovery.NetworkItem]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
