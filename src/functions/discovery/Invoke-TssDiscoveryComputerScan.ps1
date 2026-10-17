function Invoke-TssDiscoveryComputerScan {
    <#
    .SYNOPSIS
    Scan discovered computers now

    .DESCRIPTION
    Starts a Discovery scan of one or more discovered computers without waiting for the next Discovery run. Returns one result per computer with the status of each scan type started.
    Each computer is scanned in its own request: when several computers are sent together the server stops at the first one it cannot scan (unknown id, Entra ID source or no scanners) and skips the rest.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ComputerId
    Discovered computer id

    .PARAMETER ScanType
    Scan type: All (default), LocalAccount, DependencyAccount or EntraRole

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Invoke-TssDiscoveryComputerScan -TssSession $session -ComputerId 42

    Scan discovered computer 42 for every account type

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Invoke-TssDiscoveryComputerScan -TssSession $session -ComputerId 42, 43 -ScanType LocalAccount

    Scan discovered computers 42 and 43 for local accounts only

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Invoke-TssDiscoveryComputerScan

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Invoke-TssDiscoveryComputerScan.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.ComputerScanResult[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('Id', 'NetworkItemId')]
        [int[]]
        $ComputerId,

        [ValidateSet('All', 'LocalAccount', 'DependencyAccount', 'EntraRole')]
        [string]
        $ScanType = 'All'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'network', 'item', 'computer', 'scan' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            foreach ($currentId in ($ComputerId | Select-Object -Unique)) {
                $restResponse = $null
                $body = @{ data = @{ computerScans = @(@{ computerId = $currentId; scanType = $ScanType }) } }
                $invokeParams.Body = $body | ConvertTo-Json -Depth 100
                if ($PSCmdlet.ShouldProcess("Discovery computer $currentId", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Invoke-TssDiscoveryComputerScan request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse.results) {
                        [Thycotic.PowerShell.Discovery.ComputerScanResult[]](. $FilterTssResponse $restResponse.results ([Thycotic.PowerShell.Discovery.ComputerScanResult]))
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
