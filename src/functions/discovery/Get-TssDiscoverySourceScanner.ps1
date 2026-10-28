function Get-TssDiscoverySourceScanner {
    <#
    .SYNOPSIS
    Get a scanner of a discovery source

    .DESCRIPTION
    Gets a scanner attached to a discovery source, with its input and output templates, credentials and settings.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DiscoverySourceId
    Discovery source ID

    .PARAMETER DiscoveryItemScannerId
    Scanner ID on the discovery source

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDiscoverySourceScanner -TssSession $session -DiscoverySourceId 3 -DiscoveryItemScannerId 12

    Get scanner 12 of discovery source 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoverySourceScanner

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoverySourceScanner.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Discovery.SourceScanner')]
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
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssDiscoverySourceScanner request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Discovery.SourceScanner](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.SourceScanner]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
