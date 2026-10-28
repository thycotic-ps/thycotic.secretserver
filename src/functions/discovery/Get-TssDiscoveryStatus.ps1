function Get-TssDiscoveryStatus {
    <#
    .SYNOPSIS
    Get status of Discovery

    .DESCRIPTION
    Get status of Discovery
    With -ItemMetrics, -OsMetrics or -ScanResults, returns the managed and unmanaged counts per discovered item type, the computer count per operating system, or the success and error counts per discovery source instead.

    .PARAMETER ItemMetrics
    Return the managed and unmanaged counts per discovered item type

    .PARAMETER OsMetrics
    Return the number of discovered computers per operating system

    .PARAMETER ScanResults
    Return the success and error counts of the last scan per discovery source

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDiscoveryStatus -TssSession $session - some test value

    Add minimum example for each parameter

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDiscoveryStatus -TssSession $session -ItemMetrics

    List the managed and unmanaged counts of discovered accounts, keys and other item types

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDiscoveryStatus -TssSession $session -OsMetrics

    List how many discovered computers run each operating system

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDiscoveryStatus -TssSession $session -ScanResults | Where-Object ErrorCount -GT 0

    List the discovery sources whose last scan had errors

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryStatus

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryStatus.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'status')]
    [OutputType('Thycotic.PowerShell.Discovery.Status')]
    [OutputType('Thycotic.PowerShell.Discovery.StatusItemMetric[]', ParameterSetName = 'itemMetrics')]
    [OutputType('Thycotic.PowerShell.Discovery.StatusOsMetric[]', ParameterSetName = 'osMetrics')]
    [OutputType('Thycotic.PowerShell.Discovery.StatusScanResult[]', ParameterSetName = 'scanResults')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ParameterSetName = 'itemMetrics')]
        [switch]
        $ItemMetrics,

        [Parameter(Mandatory, ParameterSetName = 'osMetrics')]
        [switch]
        $OsMetrics,

        [Parameter(Mandatory, ParameterSetName = 'scanResults')]
        [switch]
        $ScanResults
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'status' -join '/'
            switch ($PSCmdlet.ParameterSetName) {
                'itemMetrics' {
                    $uri = $TssSession.ApiUrl, 'discovery', 'status', 'item-metrics' -join '/'
                }
                'osMetrics' {
                    $uri = $TssSession.ApiUrl, 'discovery', 'status', 'os-metrics' -join '/'
                }
                'scanResults' {
                    $uri = $TssSession.ApiUrl, 'discovery', 'status', 'scan-results' -join '/'
                }
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue getting Discovery status"
                $err = $_
                . $ErrorHandling $err
            }

            switch ($PSCmdlet.ParameterSetName) {
                'itemMetrics' {
                    if ($restResponse.itemMetrics) {
                        [Thycotic.PowerShell.Discovery.StatusItemMetric[]](. $FilterTssResponse $restResponse.itemMetrics ([Thycotic.PowerShell.Discovery.StatusItemMetric]))
                    }
                    return
                }
                'osMetrics' {
                    if ($restResponse.operatingSystemMetrics) {
                        [Thycotic.PowerShell.Discovery.StatusOsMetric[]](. $FilterTssResponse $restResponse.operatingSystemMetrics ([Thycotic.PowerShell.Discovery.StatusOsMetric]))
                    }
                    return
                }
                'scanResults' {
                    if ($restResponse.scanResultItemMetrics) {
                        [Thycotic.PowerShell.Discovery.StatusScanResult[]](. $FilterTssResponse $restResponse.scanResultItemMetrics ([Thycotic.PowerShell.Discovery.StatusScanResult]))
                    }
                    return
                }
            }

            if ($restResponse) {
                $result = [Thycotic.PowerShell.Discovery.Status]@{
                    Actions                   = $restResponse.actions
                    ComputerScanEndDateTime   = $restResponse.discoveryComputerScanEndDateTime
                    ComputerScanStartDateTime = $restResponse.discoveryComputerScanStartDateTime
                    DiscoveryEndDateTime      = $restResponse.discoveryFetchEndDateTime
                    DiscoveryStartDateTime    = $restResponse.discoveryFetchStartDateTime
                    DiscoverySourceCount      = $restResponse.discoverySourceCount
                    IsComputerScanRunning     = $restResponse.isDiscoveryComputerScanRunning
                    IsDiscoveryEnabled        = $restResponse.isDiscoveryEnabled
                    IsDiscoveryRunning        = $restResponse.isDiscoveryFetchRunning
                    NextComputerScanStart     = $restResponse.nextComputerScanDiscoveryDateTime
                    NextDiscoveryStart        = $restResponse.nextFetchDiscoveryDateTime
                }
                return $result
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}