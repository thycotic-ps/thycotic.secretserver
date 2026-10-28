function Get-TssDiscoveryNetworkTree {
    <#
    .SYNOPSIS
    Get the Discovery network tree

    .DESCRIPTION
    Returns the nodes of the Discovery network tree (discovery sources, domains and organizational units). Without ParentId the root nodes are returned; a root node has ParentId -1.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DiscoverySourceId
    Return only the tree of this discovery source

    .PARAMETER ParentId
    Return the children of this node

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDiscoveryNetworkTree -TssSession $session

    Get the root nodes of the Discovery network tree

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDiscoveryNetworkTree -TssSession $session -DiscoverySourceId 1 -ParentId 3

    Get the children of node 3 in discovery source 1

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryNetworkTree

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryNetworkTree.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Discovery.NetworkTree[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [int]
        $DiscoverySourceId,

        [int]
        $ParentId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'network', 'tree' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'DiscoverySourceId' {
                    $queryParams += "filter.discoverySourceId=$($DiscoverySourceId)"
                }
                'ParentId' {
                    $queryParams += "filter.parentId=$($ParentId)"
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
                Write-Warning 'Issue with Get-TssDiscoveryNetworkTree request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Discovery.NetworkTree[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Discovery.NetworkTree]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
