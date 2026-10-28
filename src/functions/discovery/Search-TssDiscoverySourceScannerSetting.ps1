function Search-TssDiscoverySourceScannerSetting {
    <#
    .SYNOPSIS
    Get the scanners configured on a discovery source

    .DESCRIPTION
    Lists the scanners configured on a discovery source in run order, with the scan type, input and output templates, and any validation errors.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Discovery source ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDiscoverySourceScannerSetting -TssSession $session -Id 3 | Where-Object Errors

    List the scanners of discovery source 3 that have validation errors

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Search-TssDiscoverySourceScannerSetting

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Search-TssDiscoverySourceScannerSetting.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Discovery.SourceScannerSettingSummary[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('DiscoverySourceId')]
        [int[]]
        $Id
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
                $uri = $TssSession.ApiUrl, 'discovery', 'source', $currentId, 'scanner-settings', 'search' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Search-TssDiscoverySourceScannerSetting request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Discovery.SourceScannerSettingSummary[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.SourceScannerSettingSummary]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
