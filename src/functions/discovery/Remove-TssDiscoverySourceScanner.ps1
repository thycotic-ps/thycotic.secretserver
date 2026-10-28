function Remove-TssDiscoverySourceScanner {
    <#
    .SYNOPSIS
    Remove a scanner from a discovery source

    .DESCRIPTION
    Removes a scanner from a discovery source.
    The scanner itself is not deleted.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DiscoverySourceId
    Discovery source ID

    .PARAMETER DiscoveryItemScannerId
    Scanner ID on the discovery source

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssDiscoverySourceScanner -TssSession $session -DiscoverySourceId 3 -DiscoveryItemScannerId 12

    Remove scanner 12 from discovery source 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Remove-TssDiscoverySourceScanner

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Remove-TssDiscoverySourceScanner.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.OperationResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $DiscoverySourceId,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $DiscoveryItemScannerId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'source', $DiscoverySourceId, 'scanners', $DiscoveryItemScannerId -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'DELETE'
            if ($PSCmdlet.ShouldProcess("Discovery source scanner: $DiscoverySourceId", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Remove-TssDiscoverySourceScanner request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Discovery.OperationResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.OperationResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
