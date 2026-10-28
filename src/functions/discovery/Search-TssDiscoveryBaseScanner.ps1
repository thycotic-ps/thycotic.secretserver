function Search-TssDiscoveryBaseScanner {
    <#
    .SYNOPSIS
    Search Discovery base scanners

    .DESCRIPTION
    Returns the Discovery base scanners (Windows, SSH, ESX, AWS and others) and the scan type each supports.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Status
    Only return scanners that are Enabled or Disabled

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDiscoveryBaseScanner -TssSession $session -Status Enabled

    Get the enabled Discovery base scanners

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoveryBaseScanner

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoveryBaseScanner.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Discovery.BaseScanner[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [ValidateSet('Enabled', 'Disabled')]
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
            $uri = $TssSession.ApiUrl, 'discovery', 'base-scanners' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'Status' {
                    $queryParams += "filter.isActive=$([uri]::EscapeDataString($Status))"
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
                Write-Warning 'Issue with Search-TssDiscoveryBaseScanner request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Discovery.BaseScanner[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Discovery.BaseScanner]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
