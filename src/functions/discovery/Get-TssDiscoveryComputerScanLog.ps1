function Get-TssDiscoveryComputerScanLog {
    <#
    .SYNOPSIS
    Get Discovery computer scan logs

    .DESCRIPTION
    Returns Discovery computer scan log entries, filtered by computer, scanner, discovery source, scan template, outcome, date range or log text.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ComputerId
    Only return logs for this discovered computer id

    .PARAMETER DiscoveryItemScannerId
    Only return logs for this scanner id

    .PARAMETER DiscoverySourceId
    Only return logs for this discovery source id

    .PARAMETER Result
    Only return successful scans (Success) or failed scans (Error). Omit for both

    .PARAMETER ScanEndDate
    Only return logs with a scan date on or before this date

    .PARAMETER ScanItemTemplateId
    Only return logs for this scan template id

    .PARAMETER ScanStartDate
    Only return logs with a scan date on or after this date

    .PARAMETER SearchText
    Only return logs whose message contains this text

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDiscoveryComputerScanLog -TssSession $session -ComputerId 42

    Get the scan logs of discovered computer 42

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDiscoveryComputerScanLog -TssSession $session -Result Error -ScanStartDate (Get-Date).AddDays(-1)

    Get the failed computer scans of the last day

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryComputerScanLog

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryComputerScanLog.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Discovery.ComputerScanLog[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [int]
        $ComputerId,

        [int]
        $DiscoveryItemScannerId,

        [int]
        $DiscoverySourceId,

        [ValidateSet('Success', 'Error')]
        [string]
        $Result,

        [datetime]
        $ScanEndDate,

        [int]
        $ScanItemTemplateId,

        [datetime]
        $ScanStartDate,

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
            $uri = $TssSession.ApiUrl, 'discovery', 'network', 'item', 'computer', 'scan', 'logs' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'ComputerId' {
                    $queryParams += "filter.computerId=$($ComputerId)"
                }
                'DiscoveryItemScannerId' {
                    $queryParams += "filter.discoveryItemScannerId=$($DiscoveryItemScannerId)"
                }
                'DiscoverySourceId' {
                    $queryParams += "filter.discoverySourceId=$($DiscoverySourceId)"
                }
                'Result' {
                    $queryParams += "filter.logLevel=$(($Result -eq 'Success').ToString().ToLower())"
                }
                'ScanEndDate' {
                    $queryParams += "filter.scanEndDate=$([uri]::EscapeDataString($ScanEndDate.ToString('o')))"
                }
                'ScanItemTemplateId' {
                    $queryParams += "filter.scanItemTemplateId=$($ScanItemTemplateId)"
                }
                'ScanStartDate' {
                    $queryParams += "filter.scanStartDate=$([uri]::EscapeDataString($ScanStartDate.ToString('o')))"
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
                Write-Warning 'Issue with Get-TssDiscoveryComputerScanLog request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Discovery.ComputerScanLog[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Discovery.ComputerScanLog]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
