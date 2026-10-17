function Get-TssDiscoverySourceOu {
    <#
    .SYNOPSIS
    Search the organizational units of an Active Directory discovery source

    .DESCRIPTION
    Searches the organizational units (OUs) of an Active Directory discovery source.
    Returns nothing for source types that have no OUs.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Discovery source ID

    .PARAMETER Include
    Only return OUs that can be included in the discovery scope

    .PARAMETER SearchText
    Only return OUs whose name contains this text

    .PARAMETER SelectedIds
    OU IDs to limit the search to when -Include is not set

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDiscoverySourceOu -TssSession $session -Id 3 -SearchText 'Servers'

    Search discovery source 3 for OUs whose name contains Servers

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoverySourceOu

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoverySourceOu.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Discovery.SourceOu[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('DiscoverySourceId')]
        [int[]]
        $Id,

        [switch]
        $Include,

        [string]
        $SearchText,

        [string[]]
        $SelectedIds
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'discovery', 'source', $currentId, 'ou' -join '/'
                $queryParams = @()
                $queryParams += "take=$($TssSession.Take)"
                switch ($tssParams.Keys) {
                    'Include' {
                        $queryParams += "include=$([boolean]$Include)"
                    }
                    'SearchText' {
                        $queryParams += "searchText=$([uri]::EscapeDataString($SearchText))"
                    }
                    'SelectedIds' {
                        foreach ($queryValue in $SelectedIds) {
                            $queryParams += "selectedIds=$([uri]::EscapeDataString($queryValue))"
                        }
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
                    Write-Warning 'Issue with Get-TssDiscoverySourceOu request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Discovery.SourceOu[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.SourceOu]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
