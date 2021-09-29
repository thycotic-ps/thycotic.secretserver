function Get-TssDiscoveryStatus {
    <#
    .SYNOPSIS
    Get status of Discovery

    .DESCRIPTION
    Get status of Discovery

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDiscoveryStatus -TssSession $session - some test value

    Add minimum example for each parameter

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryStatus

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryStatus.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Discovery.Status')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
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