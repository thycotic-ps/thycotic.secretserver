function Search-TssDiscoveryCommandSet {
    <#
    .SYNOPSIS
    Search Discovery command sets

    .DESCRIPTION
    Returns Discovery command sets. Active command sets only unless Status is set.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ScanTypeId
    Scan type: 1 = host ranges, 2 = machines, 3 = local accounts, 4 = dependencies

    .PARAMETER SearchText
    Only return command sets whose name contains this text

    .PARAMETER Status
    Command set status to include: All, Active or Inactive

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDiscoveryCommandSet -TssSession $session -Status All -ScanTypeId 3

    Get every Discovery command set that finds local accounts

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoveryCommandSet

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoveryCommandSet.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Discovery.CommandSetSummary[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [int]
        $ScanTypeId,

        [string]
        $SearchText,

        [ValidateSet('All', 'Active', 'Inactive')]
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
            $uri = $TssSession.ApiUrl, 'discovery', 'command-sets' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
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
                Write-Warning 'Issue with Search-TssDiscoveryCommandSet request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Discovery.CommandSetSummary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Discovery.CommandSetSummary]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
